package com.example.sweater.controller;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repository.UserRepository;
import com.example.sweater.service.UserService;
import com.example.sweater.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Value("${upload.path}")
    private String path;


    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userService.findAll());
        return "userList";
    }


    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String editUser(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }


    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String userSave(
            @RequestParam String username,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ) {
        userService.saveUser(user, username, form);
        return "redirect:/user";
    }


    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("deleteUser")
    public String deleteUser(@RequestParam("userId") User user) {

        userService.deleteUser(user);
        return "redirect:/user";
    }

    @GetMapping("profile/{user}")
    public String getProfile(@AuthenticationPrincipal User currentUser,
                             @PathVariable User user,
                             Model model) {

        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

        model.addAttribute("filename", user.getFilename());

        model.addAttribute("id", user.getId());

        model.addAttribute("currentSubscribers", user.getSubscribers().size());
        model.addAttribute("currentSubscriptions", user.getSubscriptions().size());

        model.addAttribute("isCurrentUser", currentUser.equals(user));
        model.addAttribute("isSubscriber", user.getSubscribers().contains(currentUser));
        return "profile";
    }

    @GetMapping("profile/name/{username}")
    public String getProfileByUsername(@PathVariable String username) {
        User user = userRepository.findByUsername(username);
        return "redirect:/user/profile/" + user.getId();
    }

    @GetMapping("profileEdit")
    public String getProfileEdit(@AuthenticationPrincipal User user,
                                 Model model) {
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());


       // model.addAttribute("image_url", user.getFilename());
        //  model.addAttribute("image_url", "logo_pink_small.png");


        //public/img/
        return "profileEdit";

    }

    @PostMapping("profileEdit")
    public String updateProfile(@AuthenticationPrincipal User user,
                                @RequestParam String password,
                                @RequestParam String email,
                                @RequestParam("file") MultipartFile file) throws IOException {

        User newUser = user;
        newUser.setPassword(password);
        newUser.setEmail(email);
        String resultName = "";
        if (file != null) {
            System.out.println("ITS NOT NULL");
            File uploadDir = new File(path);
            if (!uploadDir.exists()) uploadDir.mkdir();
            resultName = ControllerUtils.UUIDFileName(file.getOriginalFilename());
            file.transferTo(new File(path + "/" + resultName));
            newUser.setFilename(resultName);
        }



        try {
            userService.updateProfile(user, newUser);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/user/profileEdit";

    }


    //Subscribers and subscriptions


    @GetMapping("subscribe/{user}")
    public String subscribe(@AuthenticationPrincipal User currentUser,
                            @PathVariable User user) {
        userService.subscribe(currentUser, user);
        return "redirect:/user/profile/" + user.getId();

    }

    @GetMapping("unsubscribe/{user}")
    public String unsubscribe(@AuthenticationPrincipal User currentUser,
                              @PathVariable User user) {
        userService.unsubscribe(currentUser, user);
        return "redirect:/user/profile/" + user.getId();

    }

    @GetMapping("{type}/{user}/list")
    public String userList(@PathVariable User user,
                           @PathVariable String type,
                           Model model) {
        model.addAttribute("type", type);
        model.addAttribute("userChannel", user);
        model.addAttribute("users",
                type.equals("subscriptions") ? user.getSubscriptions() : user.getSubscribers());

        return "subscriptions";
    }


}
