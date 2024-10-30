import 'package:flutter/material.dart';
import 'create_account_screen.dart'; // Import the CreateAccountScreen
import 'login_screen.dart'; // Import the LoginScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo and App Name
            Column(
              children: [
                const SizedBox(height: 60), // Add spacing at the top
                Image.asset(
                  'assets/images/logo.png', // Replace with your logo image path
                  height: 350,
                  width: 350,
                ),
                const SizedBox(height: 20),
              ],
            ),
            // Login and Create Account Buttons
            Column(
              children: [
                // Login Button with Gradient Border Only
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: 250,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Login Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2), // Border width
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade400, Colors.blue.shade700],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white, // Fill color inside border
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blueAccent, // Text color matching border
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Create Account Button with Solid Gradient Fill
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: 250,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to CreateAccountScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateAccountScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade400, Colors.blue.shade700],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Bottom Wave Image
            Image.asset(
              'assets/images/bottom_wave.png', // Replace with your bottom wave image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
