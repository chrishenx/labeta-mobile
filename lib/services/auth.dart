import 'package:labeta/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  static Stream<User?> get userStream => _firebaseAuth.authStateChanges();

  static Future<User?> signInAnonymously() async {
    try {
      Logger.log('Logging in anonymously...');
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      Logger.log('Successfully logging in: $userCredential');
      return userCredential.user;
    } catch (error) {
      Logger.error('Error signing in anonymously: $error');
      return null;
    }
  }

  static Future signOut() async {
    return _firebaseAuth.signOut();
  }
}
