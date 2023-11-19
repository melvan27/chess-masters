package com.melchizedek.chessmasters.repositories;

import org.springframework.data.repository.CrudRepository;

import com.melchizedek.chessmasters.models.FriendRequest;
import com.melchizedek.chessmasters.models.User;

import java.util.List;


public interface FriendRequestRepository extends CrudRepository<FriendRequest, Long> {
    List<FriendRequest> findByRecipient(User recipient);
}
