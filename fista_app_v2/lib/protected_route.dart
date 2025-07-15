import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/user_state.dart';

/// A simple wrapper that displays [child] if the user is logged-in,
/// otherwise shows [fallback].
class ProtectedRoute extends StatelessWidget {
  final Widget child;
  final Widget fallback;

  const ProtectedRoute({
    super.key,
    required this.child,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<UserState>().isLoggedIn;
    return isLoggedIn ? child : fallback;
  }
}