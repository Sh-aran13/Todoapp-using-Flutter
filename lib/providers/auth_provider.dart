
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  // Mock Login/Register logic
  Future<bool> login(String username, String password, {bool notify = true}) async {
    // Simple mock check
    if (username.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      if (notify) {
        notifyListeners();
      }
      return true;
    }
    return false;
  }

  void notifyAuthListeners() {
    notifyListeners();
  }

  Future<bool> register(String fullName, String username, String email, String password) async {
    if (fullName.isNotEmpty && username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Do not automatically log the user in after successful registration
      return true;
    }
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}