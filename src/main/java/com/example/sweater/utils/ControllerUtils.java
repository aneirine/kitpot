package com.example.sweater.utils;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

public class ControllerUtils {


    static public Map<String, String> getErrors(BindingResult bindingResult) {
        return bindingResult.getFieldErrors().stream().collect(Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                FieldError::getDefaultMessage
        ));
    }

    static public String UUIDFileName(String fileName){
        String uuid = UUID.randomUUID().toString();
        return uuid + "." + fileName;
    }

}
