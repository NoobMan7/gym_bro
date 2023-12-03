// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_bro/pages/auth.dart';
import 'package:gym_bro/pages/bmi.dart';
import 'package:gym_bro/pages/home.dart';
import 'package:gym_bro/pages/login_register.dart';
//import 'package:gym_bro/pages/home.dart';
import 'package:gym_bro/pages/sizes.dart';
import 'package:gym_bro/pages/workoutplan.dart'; 

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationWrapper(),
       routes: {
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
           '/bottomNavigation': (context) => MyBottomNavigationBar(),
      },
    );
  }
}


class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Home(),
    SizesPage(),
    BMIPage(),
    WorkoutPlans()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.amber,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sizes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'BMI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Plans',
          ),
        ],
      ),
    );
  }
}
 
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: authService.isAuthenticated,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // You can show a loading indicator while checking the authentication state
          return CircularProgressIndicator();
        } else {
          // Check the authentication status
          bool isAuthenticated = snapshot.data ?? false;

          if (isAuthenticated) {
            // If authenticated, show the main content
            return MyBottomNavigationBar();
          } else {
            // If not authenticated, navigate to the login page
            return LoginPage();
          }
        }
      },
    );
  }
}
