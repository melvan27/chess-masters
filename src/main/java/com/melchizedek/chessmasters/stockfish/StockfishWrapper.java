package com.melchizedek.chessmasters.stockfish;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

import org.springframework.stereotype.Component;

@Component
public class StockfishWrapper {
    private Process stockfishProcess;
    private BufferedReader stockfishOutput;

    public StockfishWrapper() throws IOException {
        File stockfishFile = new File("stockfish_x86-64-vnni256");
        String stockfishPath = stockfishFile.getAbsolutePath();
        System.out.println("Stockfish Path: " + stockfishPath);

        try {
            stockfishProcess = new ProcessBuilder(stockfishPath).start();
            stockfishOutput = new BufferedReader(new InputStreamReader(stockfishProcess.getInputStream()));
            System.out.println("Stockfish process started successfully.");
        } catch (IOException e) {
            System.err.println("Failed to start Stockfish process: " + e.getMessage());
            throw e;
        }
    }

    public String getBestMove(String fenPosition, int searchDepth, int timeoutMillis) throws IOException {
        try {
            stockfishProcess.getOutputStream().write(("position fen " + fenPosition + "\n").getBytes());
            stockfishProcess.getOutputStream().write(("go depth " + searchDepth + "\n").getBytes());
            stockfishProcess.getOutputStream().flush();
            System.out.println("Sent position and go commands to Stockfish.");
    
            long startTime = System.currentTimeMillis();
            String response = null;
    
            while (System.currentTimeMillis() - startTime < timeoutMillis) {
                response = stockfishOutput.readLine();
                if (response != null) {
                    System.out.println("Received response from Stockfish: " + response);
                    if (response.startsWith("bestmove")) {
                        return response.split(" ")[1];
                    }
                }
                // Optionally, you can add a short delay here to avoid busy-waiting
                Thread.sleep(100);
            }
    
            System.err.println("Failed to get the best move from Stockfish engine within the timeout.");
            throw new RuntimeException("Failed to get best move from Stockfish engine within the timeout");
        } catch (IOException e) {
            System.err.println("Error while communicating with Stockfish: " + e.getMessage());
            throw e;
        } catch (InterruptedException e) {
            System.err.println("Thread sleep interrupted: " + e.getMessage());
            return "error";
        }
    }
    

    public void close() {
        stockfishProcess.destroy();
        System.out.println("Stockfish process closed.");
    }
}
