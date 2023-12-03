import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Successful registration, no error
    } catch (error) {
      return error.toString(); // Return error message if registration fails
    }
  }
    Stream<bool> get isAuthenticated {
    return _auth.authStateChanges().map((user) => user != null);
  }
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Successful login, no error
    } catch (error) {
      return error.toString(); // Return error message if login fails
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

// Create an instance of the AuthService
final AuthService authService = AuthService();
