package com.angularspringbootecommerce.backend.controllers;


import com.angularspringbootecommerce.backend.dtos.UserDto;
import com.angularspringbootecommerce.backend.exceptions.AppException;
import com.angularspringbootecommerce.backend.models.User;
import com.angularspringbootecommerce.backend.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping("api/v1/user")
public class UserController {

    private final UserService userService;

    @GetMapping("/{userId}")
    public User getUserById(@PathVariable Long userId, Authentication authentication) {
        return userService.getUserById(userId, authentication);
    }

    @PutMapping("/update/{userId}")
    public User updateUserById(@PathVariable Long userId, @RequestBody UserDto userDto, Authentication authentication) {
        if (userDto.getEmail() == null || userDto.getEmail().isEmpty() || userDto.getPassword() == null || userDto.getPassword().isEmpty()) {
            throw new AppException("All fields are required", HttpStatus.BAD_REQUEST);
        }
        return userService.updateUserById(userId, userDto, authentication);
    }
}
