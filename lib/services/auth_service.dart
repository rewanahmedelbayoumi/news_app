import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  String? _name;
  String? _email;
  String? _password;

  bool get isLoggedIn => _email != null;

  String? get name => _name;
  String? get email => _email;

  bool register({
    required String name,
    required String email,
    required String password,
  }) {
    _name = name;
    _email = email;
    _password = password;

    notifyListeners();
    return true;
  }

  bool login({
    required String email,
    required String password,
  }) {
    if (_email == email && _password == password) {
      notifyListeners();
      return true;
    }

    return false;
  }

  void logout() {
    _name = null;
    _email = null;
    _password = null;

    notifyListeners();
  }

  bool updateProfile({
    required String name,
    required String email,
  }) {
    if (!isLoggedIn) {
      return false;
    }

    _name = name;
    _email = email;

    notifyListeners();
    return true;
  }
}