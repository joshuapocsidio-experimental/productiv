import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:productiv/model/user/User.dart';

/// Used for communicating with the firebase auth services from Google Firebase
class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final _googleSignIn;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// Sign in without authentication
  Future<User> signInAnonymously() async
  {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  /// Sign in using email and password authentication
  Future<User> signInWithEmailAndPassword({String email, String password}) async
  {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    return _userFromFirebase(authResult.user);
  }

  /// Sign in using Google authentication service
  Future<User> signInWithGoogle() async
  {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken);

    final authResult = await _firebaseAuth.signInWithCredential(credential);

    return _userFromFirebase(authResult.user);
  }

  /// Sign up a user using email and password - also takes person's information
  Future<User> signUp({String email, String password, String name, int age}) async
  {
    try {
      AuthResult authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return _userFromFirebase(authResult.user);
    }
    catch(e)
    {
      rethrow;
    }
  }

  /// Sign out the user
  Future<void> signOut() async
  {
    return _firebaseAuth.signOut();
  }

  /// Returns the current User object currently signed in
  Future<User> currentUser() async
  {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  /// Returns a User object
  User _userFromFirebase(FirebaseUser user)
  {
    if(user == null){
      return null;
    }

    return User(uid: user.uid, email: user.email);
  }

  Stream<User> get onAuthStateChanged{
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }
}