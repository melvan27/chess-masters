package com.melchizedek.chessmasters.services;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.melchizedek.chessmasters.models.FriendRequest;
import com.melchizedek.chessmasters.models.User;
import com.melchizedek.chessmasters.repositories.FriendRequestRepository;
import com.melchizedek.chessmasters.repositories.RoleRepository;
import com.melchizedek.chessmasters.repositories.UserRepository;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private FriendRequestRepository friendRequestRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public void newUser(User user, String role) {
		try {
            user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
            user.setRoles(roleRepository.findByName(role));
            byte[] defaultPicture = Files.readAllBytes(Paths.get("src/main/resources/static/default.png"));
            user.setProfilePicture(defaultPicture);
            userRepository.save(user);
        } catch (IOException e) {
        e.printStackTrace();
        }
    }
	
	public void updateUser(User user) {
		userRepository.save(user);
	}
    
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public List<User> allUsers(){
		return userRepository.findAll();
	}
	
	public User upgradeUser(User user) {
		user.setRoles(roleRepository.findByName("ROLE_ADMIN"));
		return userRepository.save(user);
	}
	
	public void deleteUser(User user) {
		userRepository.delete(user);
	}
    
    public User findById(Long id) {
        Optional<User> potentialUser = userRepository.findById(id);
        if(potentialUser.isPresent()) {
            return potentialUser.get();
        }
        return null;
    }

    public FriendRequest findFriendRequestById(Long id) {
        Optional<FriendRequest> potentialFriendRequest = friendRequestRepository.findById(id);
        if (potentialFriendRequest.isPresent()) {
            return potentialFriendRequest.get();
        }
        return null;
    }

    public void sendFriendRequest(FriendRequest friendRequest) {
        friendRequestRepository.save(friendRequest);
    }

    public void addFriend(User user, User friend, FriendRequest request) {
        user.getFriends().add(friend);
        friend.getFriends().add(user);
        userRepository.save(user);
        userRepository.save(friend);
        friendRequestRepository.delete(request);
    }

    public void removeFriendRequest(FriendRequest request) {
        friendRequestRepository.delete(request);
    }

    public void removeFriend(User user, User friend) {
        user.getFriends().remove(friend);
        friend.getFriends().remove(user);
        userRepository.save(user);
    }

    public List<User> searchUsers(String searchQuery, User currentUser) {
        List<User> allUsers = userRepository.findAll();
        List<User> filteredUsers = new ArrayList<>();
        String queryLower = searchQuery.toLowerCase();
        for (User user : allUsers) {
            if (user.getId().equals(currentUser.getId())) {
                continue;
            }
            if (currentUser.getFriends().contains(user)) {
                continue;
            }
            if (user.getUsername().toLowerCase().contains(queryLower)) {
                filteredUsers.add(user);
                if (filteredUsers.size() == 10) {
                    break;
                }
            }
            else if (user.getFirstName().toLowerCase().contains(queryLower)) {
                filteredUsers.add(user);
                if (filteredUsers.size() == 10) {
                    break;
                }
            }
            else if (user.getLastName().toLowerCase().contains(queryLower)) {
                filteredUsers.add(user);
                if (filteredUsers.size() == 10) {
                    break;
                }
            }
        }
        return filteredUsers;
    }
}
