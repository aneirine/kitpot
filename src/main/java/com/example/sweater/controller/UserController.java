package com.example.sweater.controller;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repository.MessageRepository;
import com.example.sweater.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private MessageRepository messageRepository;


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
                             User user,
                             Model model) {
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

        model.addAttribute("currentSubscribers", user.getSubscribers().size());
        model.addAttribute("currentSubscriptions", user.getSubscriptions().size());

        return "profile";
    }

    @GetMapping("profileEdit")
    public String getProfileEdit(@AuthenticationPrincipal User user,
                                 Model model){
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());
        return "profileEdit";

    }

    @PostMapping("profile")
    public String updateProfile(@AuthenticationPrincipal User user,
                                @RequestParam String password,
                                @RequestParam String email) {

        userService.updateProfile(user, password, email);
        return "redirect:/user/profile";

    }

}
