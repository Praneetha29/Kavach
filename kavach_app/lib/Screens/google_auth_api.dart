import 'package:google_sign_in/google_sign_in.dart';
import 'package:kavach_app/Screens/testemailpage.dart';

class GoogleAuthApi{
  static final _googleSignIn = GoogleSignIn(scopes:['https://mail.google.com/']);

  static Future<GoogleSignInAccount?> signIn() async {
    if(await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    }else {
      return await _googleSignIn.signIn();
    }

  }

  static Future signOut() => _googleSignIn.signOut();
}