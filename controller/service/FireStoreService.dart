import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productiv/model/user/User.dart';

/// Used for communicating with the firebase firestore services from Google Firebase
class FireStoreService
{
  final fireStoreInstance = Firestore.instance;

  /// Adds user information to firestore database
  Future<void> addUserToDatabase({User user}) async
  {
    String uid = user.uid;
    String name = user.name;
    int age = user.age;
    String email = user.email;

    await fireStoreInstance
        .collection("users")
        .document(uid)
        .setData({'name':name, 'age':age, 'email':email});
  }

  /// Removes user information from firestore database
  Future<void> removeUserFromDatabase({User user}) async
  {
    // TODO : Add function to remove user
  }

  /// Retrieves user information from firestore database
  Future<Map<String,dynamic>> retrieveUserFromDatabase({String uid}) async
  {
    Map<String,dynamic> data;

    await fireStoreInstance
        .collection("users")
        .document(uid)
        .get()
        .then((userData) => data = userData.data);

    return data;
  }

  /// Adds reminder to firestore database
  Future<String> addReminderToDatabase({String docID, String uid, String title, String description, bool isDone}) async
  {
    DocumentReference ref = fireStoreInstance
        .collection("users")
        .document(uid)
        .collection("reminders")
        .document(docID);

    await ref.setData({'title': title, 'description': description, 'isDone': isDone});

    return ref.documentID;
  }

  /// Removes reminder from firestore database
  Future<void> removeReminderFromDatabase({String uid, String docID}) async
  {
    DocumentReference ref = fireStoreInstance.collection("users").document(uid).collection("reminders").document(docID);
    await ref.delete();
  }

  /// Retrieves reminder from database
  Future<Map<String,DocumentSnapshot>> retrieveRemindersFromDatabase({String uid}) async
  {
    Map<String, DocumentSnapshot> reminderMap = new Map();

    await fireStoreInstance
        .collection("users")
        .document(uid)
        .collection("reminders")
        .getDocuments()
        .then((reminderDataSet){
          reminderDataSet
              .documents
              .forEach((reminderData){
                reminderMap[reminderData.documentID] = reminderData;
          });
        });

    return reminderMap;
  }
}