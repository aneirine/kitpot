package com.example.sweater.repository;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;


import java.util.List;

public interface MessageRepository extends CrudRepository<Message, Long> {


    Page<Message> findAll(Pageable pageable);

    List<Message> findAll();

    Page<Message> findByTag(String tag, Pageable pageable);

    List<Message> findByTag(String tag);

    Page<Message> findByAuthor(User author, Pageable pageable);

    List<Message> findByAuthor(User author);
}
