package com.example.sweater.service;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repository.MessageRepository;
import com.example.sweater.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository repository;

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private MailSender sender;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = repository.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return user;
    }


    public boolean addUser(User user) {
        User userFromDb = repository.findByUsername(user.getUsername());


        if (userFromDb != null) {
            return false;
        }

        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        repository.save(user);

        sendMessage(user);

        return true;
    }

    private void sendMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format("Hello, %s! \n" +
                            "Welcome to Sweater. PLease, visit next link: http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode());
            sender.send(user.getEmail(), "Activation Code", message);
        }
    }

    public boolean activateUser(String code) {
        User user = repository.findByActivationCode(code);
        if (user == null) {
            return false;

        }
        user.setActivationCode(null);
        repository.save(user);
        return true;
    }

    public List<User> findAll() {
        return repository.findAll();
    }

    public void saveUser(User user, String username, Map<String, String> form) {
        user.setUsername(username);

        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        repository.save(user);

    }

    public void deleteUser(User user) {
        Iterable<Message> messages = messageRepository.findByAuthor(user);
        messageRepository.deleteAll(messages);
        repository.deleteById(user.getId());
    }

    public void updateProfile(User user, String password, String email, String filename) {
        if(email.isEmpty() || email == null){
            email = user.getEmail();
        }

        String userEmail = user.getEmail();

        boolean isEmailChanged = (email != null && !email.equals(userEmail)) ||
                (userEmail != null && !userEmail.equals(email));

        if (isEmailChanged) {
            user.setEmail(email);

            if (!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }

        if (!StringUtils.isEmpty(password)) {
            user.setPassword(password);
        }

        user.setFilename(filename);

        repository.save(user);
        if (isEmailChanged) {
            sendMessage(user);
        }

    }

    public void subscribe(User currentUser, User user) {
        user.getSubscribers().add(currentUser);
        repository.save(user);
    }

    public void unsubscribe(User currentUser, User user) {
        user.getSubscribers().remove(currentUser);
        repository.save(user);
    }
}
