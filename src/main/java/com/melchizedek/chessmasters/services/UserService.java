package com.melchizedek.chessmasters.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.melchizedek.chessmasters.models.User;
import com.melchizedek.chessmasters.repositories.RoleRepository;
import com.melchizedek.chessmasters.repositories.UserRepository;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public void newUser(User user, String role) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(roleRepository.findByName(role));
		userRepository.save(user);
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
}
