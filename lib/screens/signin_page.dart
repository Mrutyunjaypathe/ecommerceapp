import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // Keeping Provider import for consistency, though not heavily used for static UI

// Assuming you have an AppDataProvider for general app state,
// though it might not be directly used on this page for now.
import '../providers/app_data_provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Controllers for text input fields
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State for password visibility
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access MediaQuery data for responsive sizing
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Access AppDataProvider (optional, for future state needs)
    // final appDataProvider = Provider.of<AppDataProvider>(context);

    return Scaffold(
      // AppBar with back button
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back using go_router
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03), // Spacing from app bar

            // Welcome message
            Text(
              'Welcome back to\nMega Mall',
              style: TextStyle(
                fontSize: screenWidth * 0.075 / textScaleFactor, // Responsive font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),

            Text(
              'Please enter your data to login',
              style: TextStyle(
                fontSize: screenWidth * 0.04 / textScaleFactor, // Responsive font size
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Email/Phone Input Field
            Text(
              'Email/ Phone',
              style: TextStyle(
                fontSize: screenWidth * 0.04 / textScaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: TextField(
                controller: _emailPhoneController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: screenWidth * 0.045 / textScaleFactor),
                decoration: InputDecoration(
                  hintText: 'matias@gmail.com',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Password Input Field
            Text(
              'Password',
              style: TextStyle(
                fontSize: screenWidth * 0.04 / textScaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Toggle visibility
                style: TextStyle(fontSize: screenWidth * 0.045 / textScaleFactor),
                decoration: InputDecoration(
                  hintText: '••••••••••',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                      size: screenWidth * 0.055, // Responsive icon size
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Sign In Button
            SizedBox(
              width: double.infinity, // Full width button
              height: screenHeight * 0.065, // Responsive button height
              child: ElevatedButton(
                onPressed: () {
                  // Handle Sign In logic here
                  // Example: print values, navigate
                  print('Email/Phone: ${_emailPhoneController.text}');
                  print('Password: ${_passwordController.text}');
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign In button pressed! Navigating to Home Page.')));
                  // Navigate to the HomePage
                  context.go('/home'); // <--- Navigates to the HomePage
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02), // Responsive border radius
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045 / textScaleFactor, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Forgot Password and Sign Up links
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to reset password screen
                      context.push('/resetpage');
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: screenWidth * 0.038 / textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: screenWidth * 0.038 / textScaleFactor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle Sign Up
                          print('Sign Up pressed');
                          // context.go('/signup'); // Example navigation
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: screenWidth * 0.038 / textScaleFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // Bottom padding
          ],
        ),
      ),
    );
  }
}
