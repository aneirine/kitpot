package com.example.sweater.repository;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageRepository extends CrudRepository<Message, Long> {
    List<Message> findByTag(String tag);
    List<Message> findByAuthor(User author);
}
