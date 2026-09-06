import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'language_service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription<User?>? _authSubscription;

  String? _name;
  String? _email;

  AuthService() {
    _loadCurrentUser();

    _authSubscription = _auth.authStateChanges().listen(
      _updateUser,
    );
  }

  bool get isLoggedIn => _auth.currentUser != null;

  String? get name => _name;

  String? get email => _email;

  User? get currentUser => _auth.currentUser;

  void _loadCurrentUser() {
    _updateUser(_auth.currentUser);
  }

  void _updateUser(User? user) {
    if (user == null) {
      _name = null;
      _email = null;
    } else {
      _name = user.displayName;
      _email = user.email;
    }

    notifyListeners();
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final User? user = credential.user;

      if (user == null) {
        return 'Registration failed.';
      }

      await user.updateDisplayName(name.trim());

      await user.reload();

      _updateUser(_auth.currentUser);

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthErrorMessage(e);
    } catch (e) {
      debugPrint('Registration error: $e');

      return 'Something went wrong. Please try again.';
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      _updateUser(_auth.currentUser);

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthErrorMessage(e);
    } catch (e) {
      debugPrint('Login error: $e');

      return 'Something went wrong. Please try again.';
    }
  }

  Future<String?> resetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthErrorMessage(e);
    } catch (e) {
      debugPrint('Password reset error: $e');

      return 'Something went wrong. Please try again.';
    }
  }

  Future<String?> logout() async {
    try {
      await _auth.signOut();

      _name = null;
      _email = null;

      notifyListeners();

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthErrorMessage(e);
    } catch (e) {
      debugPrint('Logout error: $e');

      return 'Something went wrong. Please try again.';
    }
  }

  Future<String?> updateProfile({
    required String name,
    required String email,
  }) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      return 'You must be logged in.';
    }

    try {
      final String newName = name.trim();
      final String newEmail = email.trim();

      if (newName.isEmpty || newEmail.isEmpty) {
        return 'Please fill in all fields.';
      }

      await user.updateDisplayName(newName);

      if (newEmail != user.email) {
        await user.verifyBeforeUpdateEmail(newEmail);
      }

      await user.reload();

      _updateUser(_auth.currentUser);

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthErrorMessage(e);
    } catch (e) {
      debugPrint('Profile update error: $e');

      return 'Something went wrong. Please try again.';
    }
  }

  String _getAuthErrorMessage(
      FirebaseAuthException e,
      ) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered.';

      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'weak-password':
        return 'Password is too weak.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'requires-recent-login':
        return 'Please log in again before changing your email.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'operation-not-allowed':
        return 'Email and password sign-in is not enabled.';

      default:
        return e.message ??
            'Authentication failed. Please try again.';
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}