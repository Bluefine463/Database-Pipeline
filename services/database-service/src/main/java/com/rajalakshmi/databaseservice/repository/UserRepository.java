package com.rajalakshmi.databaseservice.repository;

import com.rajalakshmi.databaseservice.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {}
