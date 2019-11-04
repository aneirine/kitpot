package com.example.sweater.utils;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
public class Mappings {

    private String commonUrl = "/Users/annashypilova/IdeaProjects/kitpot";

    @GetMapping(value = "/img/{imageUrl}")
    public @ResponseBody
    byte[] image(@PathVariable String imageUrl) throws IOException {
        return returnFile(commonUrl + "/uploads/" + imageUrl);
    }


    @RequestMapping(method = GET,
            value = {"{path}/public/{directoryName}/{fileName}",
                    "public/{directoryName}/{fileName}"})
    public @ResponseBody
    byte[] style(@PathVariable(name = "fileName") String fileName,
                 @PathVariable(name = "directoryName") String directory) throws IOException {
        return returnFile(commonUrl + "/src/main/resources/public/" + directory + "/" + fileName);
    }

    /*@GetMapping(value = "/user/public/{directoryName}/{fileName}")
    public @ResponseBody
    byte[] styleUser(@PathVariable(name = "fileName") String fileName,
                 @PathVariable(name = "directoryName") String directory) throws IOException {
        return returnFile(commonUrl + "/src/main/resources/public/" + directory + "/" + fileName);
    }*/


    private byte[] returnFile(String url) throws IOException {
        InputStream in = new FileInputStream(url);
        return IOUtils.toByteArray(in);
    }
}
