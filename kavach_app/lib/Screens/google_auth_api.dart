import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthApi {
  static final _googleSignIn = GoogleSignIn(scopes: ['email']);

  static Future<GoogleSignInAccount?> signIn() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isSignedIn = prefs.getBool('isSignedIn');

    if (isSignedIn ?? false) {
      return _googleSignIn.currentUser;
    } else {
      try {
        final GoogleSignInAccount? account = await _googleSignIn.signIn();
        if (account != null) {
          prefs.setBool('isSignedIn', true);
          return account;
        }
      } catch (error) {
        print('Google Sign In failed: $error');
      }
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false);
  }
}