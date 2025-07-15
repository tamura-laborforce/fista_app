import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  bool _loggedIn = false;

  bool get isLoggedIn => _loggedIn;

  void signIn() {
    _loggedIn = true;
    notifyListeners();
  }

  void signOut() {
    _loggedIn = false;
    notifyListeners();
  }
}