package com.example.sweater.utils;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

@Controller
public class Mappings {

    private String commonUrl = "/Users/annasipilova/IdeaProjects/sweater";

    @GetMapping(value = "/img/{imageUrl}")
    public @ResponseBody
    byte[] image(@PathVariable String imageUrl) throws IOException {
        return returnFile(commonUrl + "/uploads/" + imageUrl);
    }


    @GetMapping(value = "/public/{directoryName}/{fileName}")
    public @ResponseBody
    byte[] style(@PathVariable(name = "fileName") String fileName,
                 @PathVariable(name = "directoryName") String directory) throws IOException {
        return returnFile(commonUrl + "/src/main/resources/public/" + directory + "/" + fileName);
    }


    private byte[] returnFile(String url) throws IOException {
        InputStream in = new FileInputStream(url);
        return IOUtils.toByteArray(in);
    }
}
