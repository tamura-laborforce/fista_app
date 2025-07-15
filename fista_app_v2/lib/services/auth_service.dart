class AuthService {
  static final AuthService instance = AuthService._();
  AuthService._();

  Future<bool> signIn(String email, String password) async {
    // TODO: integrate FirebaseAuth
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}