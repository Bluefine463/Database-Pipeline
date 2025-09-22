package com.rajalakshmi.userservice.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/api/users")
public class UserProxyController {
    private final WebClient webClient;
    private final String dbBaseUrl;

    public UserProxyController(WebClient webClient,
                               @Value("${DATABASE_SERVICE_BASE_URL:http://localhost:8080/api}") String dbBaseUrl) {
        this.webClient = webClient;
        this.dbBaseUrl = dbBaseUrl;
    }

    @GetMapping
    public Mono<ResponseEntity<String>> all() {
        return webClient.get()
                .uri(dbBaseUrl)
                .accept(MediaType.APPLICATION_JSON)
                .retrieve()
                .toEntity(String.class);
    }

    @GetMapping("/{id}")
    public Mono<ResponseEntity<String>> get(@PathVariable String id) {
        return webClient.get()
                .uri(dbBaseUrl + "/" + id)
                .retrieve()
                .toEntity(String.class);
    }

    @PostMapping
    public Mono<ResponseEntity<String>> create(@RequestBody String body) {
        return webClient.post()
                .uri(dbBaseUrl)
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(body)
                .retrieve()
                .toEntity(String.class);
    }

    @PutMapping("/{id}")
    public Mono<ResponseEntity<String>> update(@PathVariable String id, @RequestBody String body) {
        return webClient.put()
                .uri(dbBaseUrl + "/" + id)
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(body)
                .retrieve()
                .toEntity(String.class);
    }

    @DeleteMapping("/{id}")
    public Mono<ResponseEntity<String>> delete(@PathVariable String id) {
        return webClient.delete()
                .uri(dbBaseUrl + "/" + id)
                .retrieve()
                .toEntity(String.class);
    }
}
