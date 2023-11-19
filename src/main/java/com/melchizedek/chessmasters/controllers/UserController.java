package com.melchizedek.chessmasters.controllers;

import java.io.IOException;
import java.security.Principal;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.melchizedek.chessmasters.models.FriendRequest;
import com.melchizedek.chessmasters.models.User;
import com.melchizedek.chessmasters.services.UserService;
import com.melchizedek.chessmasters.validator.UserValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping("/register")
	public String registration(
			@Valid @ModelAttribute("user") User user, 
			BindingResult result, 
			Model model, 
			HttpSession session,
			HttpServletRequest request) {
		userValidator.validate(user, result);
		// Store the password before it is encrypted
		String password = user.getPassword();
		if(result.hasErrors()) {
			return "loginPage.jsp";
		}
		// Make first user SUPER ADMIN
		if(userService.allUsers().size()==0) {
			userService.newUser(user, "ROLE_SUPER_ADMIN");
		}else {
			userService.newUser(user, "ROLE_USER");
		}
		
		// Log in new user with the password we stored before encrypting it
		authWithHttpServletRequest(request, user.getEmail(), password);
		return "redirect:/";
	}
	
	// We will call this method to automatically log in newly registered users
	public void authWithHttpServletRequest(HttpServletRequest request, String email, String password) {
        try {
            request.login(email, password);
        } catch (ServletException e) {
            System.out.println("Error while login: " + e);
        }
	}
	
	@RequestMapping("/admin/{id}")
	public String makeAdmin(Principal principal, @PathVariable("id") Long id, Model model) {
		if(principal==null) {
			return "redirect:/login";
		}
		
		User user = userService.findById(id);
		userService.upgradeUser(user);
		
		model.addAttribute("users", userService.allUsers());
		
		return "redirect:/home";
	}
    
    @RequestMapping("/login")
    public String login(@ModelAttribute("user") User user, @RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model) {
        if(error != null) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if(logout != null) {
            model.addAttribute("logoutMessage", "Logout Successful!");
        }
        return "loginPage.jsp";
    }

    @RequestMapping(value={"/", "/home"})
	public String home(Principal principal, Model model) {
		if(principal==null) {
			return "redirect:/login";
		}
		String email = principal.getName();
		User user = userService.findByEmail(email);
		model.addAttribute("user", user);
		byte[] profilePicture = user.getProfilePicture();
		String base64ProfilePicture = Base64.getEncoder().encodeToString(profilePicture);
		model.addAttribute("base64ProfilePicture", base64ProfilePicture);
		List<FriendRequest> friendRequests = user.getReceivedFriendRequests();
		int count = friendRequests.size();
		model.addAttribute("requestCount", count);
		
		if(user!=null) {
			user.setLastLogin(new Date());
			userService.updateUser(user);
			// If the user is an ADMIN or SUPER_ADMIN they will be redirected to the admin page
			if(user.getRoles().get(0).getName().contains("ROLE_SUPER_ADMIN")||user.getRoles().get(0).getName().contains("ROLE_ADMIN")) {
				model.addAttribute("currentUser", userService.findByEmail(email));
				model.addAttribute("users", userService.allUsers());
				return "adminPage.jsp";
			}
			// All other users are redirected to the home page
		}
		
		return "homePage.jsp";
	}
	
	@RequestMapping("/delete/{id}")
	public String deleteUser(Principal principal, @PathVariable("id") Long id, HttpSession session, Model model) {	
		if(principal==null) {
			return "redirect:/login";
		}
		User user = userService.findById(id);
		userService.deleteUser(user);
		
		model.addAttribute("users", userService.allUsers());
		
		return "redirect:/home";
	}

	@RequestMapping("/profile")
	public String editProfile(Principal principal, Model model) {
		if(principal==null) {
			return "redirect:/login";
		}
		User user = userService.findByEmail(principal.getName());
		String username = user.getUsername();
		model.addAttribute("user", user);
		model.addAttribute("username", username);
		byte[] profilePicture = user.getProfilePicture();
		String base64ProfilePicture = Base64.getEncoder().encodeToString(profilePicture);
		model.addAttribute("base64ProfilePicture", base64ProfilePicture);
		return "profilePage.jsp";
	}

	@PutMapping("/profile")
	public String saveProfile(@Valid @ModelAttribute User user, BindingResult result, Model model, Principal principal, HttpSession session) throws IOException {
		if(principal==null) {
			return "redirect:/login";
		}
		if(result.hasErrors()) {
			String username = userService.findByEmail(principal.getName()).getUsername();
			model.addAttribute("username", username);
			byte[] picture = userService.findByEmail(principal.getName()).getProfilePicture();
			String base64ProfilePicture = Base64.getEncoder().encodeToString(picture);
			model.addAttribute("base64ProfilePicture", base64ProfilePicture);
			return "profilePage.jsp";
		}
		User currentUser = userService.findByEmail(principal.getName());
		currentUser.setFirstName(user.getFirstName());
		currentUser.setLastName(user.getLastName());
		currentUser.setUsername(user.getUsername());
		currentUser.setEmail(user.getEmail());
		
		MultipartFile profilePictureFile = user.getPictureFile();
		if (profilePictureFile != null) {
			currentUser.setProfilePicture(profilePictureFile.getBytes());
		}
		userService.updateUser(currentUser);
		return "redirect:/home";
	}

	@RequestMapping("/friends")
	public String friends(@ModelAttribute("friendRequest") FriendRequest friendRequest, Principal principal, Model model, RedirectAttributes redirectAttributes) {
		if(principal==null) {
			return "redirect:/login";
		}
		User user = userService.findByEmail(principal.getName());
		model.addAttribute("user", user);
		byte[] profilePicture = user.getProfilePicture();
		String base64ProfilePicture = Base64.getEncoder().encodeToString(profilePicture);
		model.addAttribute("base64ProfilePicture", base64ProfilePicture);
		List<User> friends = user.getFriends();
		model.addAttribute("friends", friends);
		List<FriendRequest> friendRequests = user.getReceivedFriendRequests();
		model.addAttribute("friendRequests", friendRequests);
		int count = friendRequests.size();
		model.addAttribute("requestCount", count);
		List<User> searchResults = (List<User>) redirectAttributes.getFlashAttributes().get("searchResults");
		Boolean noResults = (Boolean) redirectAttributes.getFlashAttributes().get("noResults");
		if (searchResults != null) {
			model.addAttribute("searchResults", searchResults);
		} else {
			model.addAttribute("noResultsValue", noResults);
		}
		return "friendsPage.jsp";
	}

	@PostMapping("/friends/request/{friendId}")
	public String sendFriendRequest(@Valid @ModelAttribute("friendRequest") FriendRequest friendRequest, BindingResult result, Principal principal, Model model, @PathVariable("friendId") Long friendId) {
		if (principal == null) {
			return "redirect:/login";
		}
		userService.sendFriendRequest(friendRequest);
		return "redirect:/friends";
	}

	@PutMapping("/friends/accept/{requestId}/{friendId}")
	public String addFriend(Principal principal, @PathVariable("requestId") Long requestId, @PathVariable("friendId") Long friendId, Model model) {
		if(principal==null) {
			return "redirect:/login";
		}
		User user = userService.findByEmail(principal.getName());
		User friend = userService.findById(friendId);
		FriendRequest request = userService.findFriendRequestById(requestId);
		userService.addFriend(user, friend, request);
		return "redirect:/friends";
	}

	@PutMapping("/friends/decline/{requestId}")
	public String removeFriendRequest(Principal principal, @PathVariable("requestId") Long requestId, Model model) {
		if(principal==null) {
			return "redirect:/login";
		}
		FriendRequest request = userService.findFriendRequestById(requestId);
		userService.removeFriendRequest(request);
		return "redirect:/friends";
	}

	@PutMapping("/friends/remove/{friendId}")
	public String removeFriend(Principal principal, @PathVariable("friendId") Long friendId, Model model) {
		if(principal==null) {
			return "redirect:/login";
		}
		User user = userService.findByEmail(principal.getName());
		User friend = userService.findById(friendId);
		userService.removeFriend(user, friend);
		return "redirect:/friends";
	}

	@GetMapping("/friends/search")
	public String searchUsers(@RequestParam("search") String searchQuery, Principal principal, Model model, RedirectAttributes redirectAttributes) {
		if(principal==null) {
			return "redirect:/login";
		}
		User user = userService.findByEmail(principal.getName());
		if(searchQuery == null || searchQuery.trim().isEmpty()) {
			model.addAttribute("user", user);
			byte[] profilePicture = user.getProfilePicture();
			String base64ProfilePicture = Base64.getEncoder().encodeToString(profilePicture);
			model.addAttribute("base64ProfilePicture", base64ProfilePicture);
			List<User> friends = user.getFriends();
			model.addAttribute("friends", friends);
			List<FriendRequest> friendRequests = user.getReceivedFriendRequests();
			model.addAttribute("friendRequests", friendRequests);
			int count = friendRequests.size();
			model.addAttribute("requestCount", count);
			model.addAttribute("searchError", "Search query cannot be empty");
			return "friendsPage.jsp";
		}
		List<User> users = userService.searchUsers(searchQuery, user);
		redirectAttributes.addFlashAttribute("searchResults", users);
		if (users.size() == 0) {
			redirectAttributes.addFlashAttribute("noResults", true);
		}
		return "redirect:/friends";
	}

    // @RequestMapping("/admin")
    // public String adminPage(Principal principal, Model model) {
    //     String username = principal.getName();
    //     model.addAttribute("currentUser", userService.findByUsername(username));
    //     return "adminPage.jsp";
    // }
}
