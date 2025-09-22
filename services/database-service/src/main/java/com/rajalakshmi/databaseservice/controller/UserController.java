package com.rajalakshmi.databaseservice.controller;

import com.rajalakshmi.databaseservice.model.User;
import com.rajalakshmi.databaseservice.repository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserController {
    private final UserRepository repo;

    public UserController(UserRepository repo) { this.repo = repo; }

    @GetMapping
    public List<User> all() { return repo.findAll(); }

    @GetMapping("/{id}")
    public ResponseEntity<User> get(@PathVariable Long id) {
        return repo.findById(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public User create(@RequestBody User user) { return repo.save(user); }

    @PutMapping("/{id}")
    public ResponseEntity<User> update(@PathVariable Long id, @RequestBody User input) {
        return repo.findById(id).map(u -> {
            u.setName(input.getName());
            u.setEmail(input.getEmail());
            u.setAge(input.getAge());
            return ResponseEntity.ok(repo.save(u));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> delete(@PathVariable Long id) {
        return repo.findById(id).map(u -> { repo.deleteById(id); return ResponseEntity.noContent().build(); })
                .orElse(ResponseEntity.notFound().build());
    }
}
