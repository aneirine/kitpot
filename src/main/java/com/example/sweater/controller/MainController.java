package com.example.sweater.controller;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.awt.print.Pageable;
import java.util.Map;


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
                       Model model,
                       @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {

        if (user == null) {
            return "redirect:/login";
        } else {
            Page<Message> page;
            boolean condition = filter != null && !filter.isEmpty();
            page = condition ? messageRepository.findByTag(filter, pageable) : getMessages(pageable);
            /*if () {
                messages = messageRepository.findByTag(filter);
            } else {
                messages = getMessages();
            }*/
            model.addAttribute("messages", page);
            model.addAttribute("filter", filter);
            return "main";
        }

    }


    @PostMapping("deleteAll")
    public String deleteAll(Map<String, Object> model,
                            @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        messageRepository.deleteAll(getMessages(pageable));
        model.put("messages", getMessages(pageable));
        return "redirect:/main";
    }


    @GetMapping("deleteById/{id}")
    public String delete(@PathVariable Long id,
                         Map<String, Object> model,
                         @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        messageRepository.deleteById(id);
        model.put("messages", getMessages(pageable));
        return "redirect:/main";
    }

    @PostMapping("showAllMyMessages")
    public String showAllMyMessages(@AuthenticationPrincipal User user,
                                    Map<String, Object> model,
                                    @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        Iterable<Message> messages = messageRepository.findByAuthor(user, pageable);
        model.put("messages", messages);
        return "main";
    }

    @PostMapping("showAll")
    public String showAll(Map<String, Object> model,
                          @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        model.put("messages", getMessages(pageable));
        return "redirect:/main";
    }


    private Page<Message> getMessages(Pageable pageable) {
        return messageRepository.findAll(pageable);
    }


}
