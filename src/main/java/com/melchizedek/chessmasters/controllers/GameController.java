package com.melchizedek.chessmasters.controllers;

import java.io.IOException;
import java.security.Principal;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.melchizedek.chessmasters.models.User;
import com.melchizedek.chessmasters.services.UserService;
import com.melchizedek.chessmasters.stockfish.StockfishWrapper;

@Controller
public class GameController {
    @Autowired
    private UserService userService;

    @Autowired
    private StockfishWrapper stockfishWrapper;
    
    @GetMapping("/play/computer")
    public String playComputer(Principal principal, Model model) {
        if(principal==null) {
			return "redirect:/login";
		}
        String email = principal.getName();
        User user = userService.findByEmail(email);
        model.addAttribute("user", user);
		byte[] profilePicture = user.getProfilePicture();
		String base64ProfilePicture = Base64.getEncoder().encodeToString(profilePicture);
		model.addAttribute("base64ProfilePicture", base64ProfilePicture);
        return "chessboard.jsp";
    }

    @GetMapping("/play/getBestMove")
    @ResponseBody
    public Map<String, String> getBestMove(@RequestParam String fenPosition, @RequestParam int searchDepth) {
        Map<String, String> response = new HashMap<>();
        int time = 5000;

        String bestMove = null;

        try {
            bestMove = stockfishWrapper.getBestMove(fenPosition, searchDepth, time);
            System.out.println("Received best move from Stockfish: " + bestMove);
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error while getting the best move from Stockfish: " + e.getMessage());
            bestMove = "Error: " + e.getMessage();
        }
        response.put("bestMove", bestMove);
        System.out.println("Sending best move response to the client: " + bestMove);
        return response;
    }
}
