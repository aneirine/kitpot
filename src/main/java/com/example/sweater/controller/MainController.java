package com.example.sweater.controller;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.repository.MessageRepository;
import com.example.sweater.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;


@Controller
public class MainController {

    @Autowired
    private MessageRepository messageRepository;

    @Value("${upload.path}")
    private String uploadPath;


    @GetMapping("/")
    public String greeting(@AuthenticationPrincipal User user,
                           Map<String, Object> model) {
        if (user == null) {
            return "redirect:/login";
        } else {
            model.put("username", user.getUsername());

            return "redirect:/main";
        }
    }


    @GetMapping("main")
    public String main(@AuthenticationPrincipal User user,
                       @RequestParam(required = false) String filter,
                       Model model) {

        if (user == null) {
            return "redirect:/login";
        } else {
            Iterable<Message> messages;
            if (filter != null && !filter.isEmpty()) {
                messages = messageRepository.findByTag(filter);
            } else {
                messages = getMessages();
            }
            model.addAttribute("messages", messages);
            model.addAttribute("filter", filter);
            return "main";
        }

    }


    // @PostMapping("add")
   /* public String add(@AuthenticationPrincipal User user,
                      @Valid Message message,
                      BindingResult bindingResult,
                      Model model,
                      @RequestParam("file") MultipartFile file) throws IOException {
        message.setAuthor(user);

        if (bindingResult.hasErrors()) {
            Map<String, String> collect = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(collect);
            model.addAttribute("message", message);
        } else {
            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) uploadDir.mkdir();

                String uuidFile = UUID.randomUUID().toString();
                String resultFilename = uuidFile + "." + file.getOriginalFilename();

                file.transferTo(new File(uploadPath + "/" + resultFilename));

                message.setFilename(resultFilename);
            }

            model.addAttribute("message", null);
            messageRepository.save(message);
        }
        model.addAttribute("messages", getMessages());
        return "add";
    }*/


    @PostMapping("deleteAll")
    public String deleteAll(Map<String, Object> model) {
        messageRepository.deleteAll(getMessages());
        model.put("messages", getMessages());
        return "redirect:/main";
    }


    @GetMapping("deleteById/{id}")
    public String delete(@PathVariable Long id, Map<String, Object> model) {
        messageRepository.deleteById(id);
        model.put("messages", getMessages());
        return "redirect:/main";
    }

    @PostMapping("showAllMyMessages")
    public String showAllMyMessages(@AuthenticationPrincipal User user, Map<String, Object> model) {
        Iterable<Message> messages = messageRepository.findByAuthor(user);
        model.put("messages", messages);
        return "main";
    }

    @PostMapping("showAll")
    public String showAll(Map<String, Object> model) {
        model.put("messages", getMessages());
        return "redirect:/main";
    }


    private Iterable<Message> getMessages() {
        return messageRepository.findAll();
    }


}
