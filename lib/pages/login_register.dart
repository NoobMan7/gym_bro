// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call the authentication logic
                String? error = await authService.signInWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                );

                // Handle authentication result
                if (error == null) {
                  // Navigate to home page or perform any desired action
                  Navigator.pushReplacementNamed(context, '/bottomNavigation');
                  print('Login successful');
                } else {
                  // Display error message
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Login Error'),
                      content: Text(error),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
             SizedBox(height: 16),
          
          // Example button to navigate to the registration page
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registration');
            },
            child: Text('Register'),
          ),
          ],
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call the authentication logic
                String? error = await authService.registerWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                );

                // Handle authentication result
                if (error == null) {
                  // Navigate to home page or perform any desired action
                  Navigator.pushReplacementNamed(context, '/bottomNavigation');
                  print('Registration successful');
                } else {
                  // Display error message
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Registration Error'),
                      content: Text(error),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Register'),
            ),
             SizedBox(height: 16),
          
          // Example button to navigate to the registration page
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Go To Login'),
          ),
          ],
        ),
      ),
    );
  }
}
