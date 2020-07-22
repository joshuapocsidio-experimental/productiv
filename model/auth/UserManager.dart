import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:productiv/controller/service/FireStoreService.dart';
import 'package:productiv/controller/service/FirebaseAuthService.dart';
import 'package:productiv/model/auth/InvalidEmailException.dart';
import 'package:productiv/model/auth/InvalidPasswordException.dart';
import 'package:productiv/model/productivity/reminder/Reminder.dart';
import 'package:productiv/model/user/User.dart';

/// Layer to handle interaction between user-specific information from database and GUI
/// - handles validation of user input
class UserManager extends ChangeNotifier
{
  // Firebase services
  FireStoreService fireStoreService;
  FirebaseAuthService firebaseAuthService;
  // User currently logged in - null if no user is logged in
  User currentUser;
  // Status variables
  bool isSignedIn;
  bool isLoading;

  UserManager()
  {
    fireStoreService = new FireStoreService();
    firebaseAuthService = new FirebaseAuthService();
    currentUser = null;
    isSignedIn = false;
    isLoading = false;
  }

  /// Signs in user with email, password, and personal information
  Future<void> signUpWithEmailAndPass(String email, String password, String name, int age) async
  {
    // TODO: Validate fields
    try{
      User user = await firebaseAuthService.signUp(email: email, password: password);

      user.name = name;
      user.age = age;

      await fireStoreService.addUserToDatabase(user: user);

      this.signInWithEmailAndPass(email, password);
    }
    catch(signUpError)
    {
      switch(signUpError.code){
        case 'auth/email-already-in-use':
          throw new InvalidEmailException(errorMessage: "This email is already being used");
          break;
        case 'auth/invalid-email':
          throw new InvalidEmailException(errorMessage: "This email is not a valid email");
          break;
        case 'auth/weak-password':
          throw new InvalidPasswordException(errorMessage: "The password you entered is weak");
          break;
      }
    }
  }

  /// Signs in user with email and password
  Future<void> signInWithEmailAndPass(String email, String password) async
  {
    // TODO: Validate fields
    User attemptUser = await firebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
    await _signInUser(attemptUser);
  }

  /// Signs in user with google service
  Future<void> signInWithGoogle() async
  {
    User attemptUser = await firebaseAuthService.signInWithGoogle();
    await _signInUser(attemptUser);
  }

  /// Signs out user
  Future<void> signOutUser() async
  {
    await firebaseAuthService.signOut();
    this.currentUser = null;
    isSignedIn = false;
    notifyListeners();
  }

  /// Signs in user if User object passed is not null
  Future<void> _signInUser(User attemptUser) async
  {
    // TODO: Validate fields
    if(attemptUser != null){
      this.currentUser = attemptUser;
      await initUser();
      isSignedIn = true;
      notifyListeners();
    }
  }

  /// Updates if currently loading - used to show loading widget
  void updateLoadingStatus(bool status)
  {
    isLoading = status;
    notifyListeners();
  }

  /// Initialize User Manager if any user is currently signed in
  Future<void> initManager() async
  {
    User checkUser = await firebaseAuthService.currentUser();
    if(checkUser != null){
      currentUser = checkUser;
      await initUser();
      isSignedIn = true;
    }
  }

  /// Retrieves information from firestore database and adds information into user details
  Future<void> initUser() async
  {
    String uid = currentUser.uid;
    var userData = await fireStoreService.retrieveUserFromDatabase(uid: uid);

    String uName = userData["name"];
    int uAge = userData["age"];

    currentUser.name = uName;
    currentUser.age = uAge;

    print(currentUser.toString());
  }

  /// Retrieves all reminders from this user
  Future<List<Reminder>> fetchRemindersFromFirestore() async
  {
    print("Fetching reminders to firestore");
    List<Reminder> reminderList = new List();
    Map<String,DocumentSnapshot> reminderDataMap = await fireStoreService.retrieveRemindersFromDatabase(uid: currentUser.uid);

    reminderDataMap.forEach((docID, documentSnapshot) {
      Map<String,dynamic> reminderData = documentSnapshot.data;

      String title = reminderData["title"];
      String description = reminderData["description"];
      bool isDone = reminderData["isDone"];

      Reminder reminder = new Reminder(title: title, description: description, isDone: isDone);
      reminder.assignID(id: docID);
      reminderList.add(reminder);
    });

    return reminderList;
  }

  /// Adds a reminder to firestore database
  Future<String> addReminderToFirestore({Reminder reminder}) async
  {

    print("Adding reminder to firestore");
    return await fireStoreService
        .addReminderToDatabase(uid: currentUser.uid, title: reminder.title, description: reminder.description, isDone: reminder.isDone);
  }

  /// Removes reminder from firestore database
  Future<void> removeReminderFromFireStore({String docID}) async
  {
    print("Removing reminder to firestore");
    await fireStoreService.removeReminderFromDatabase(uid: currentUser.uid, docID: docID);
  }
}