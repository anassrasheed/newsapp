import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/models/user.dart';

class DatabaseAuthService {
  static DatabaseAuthService _instance = DatabaseAuthService._internal();
  factory DatabaseAuthService() => _instance;
  DatabaseAuthService._internal();
  // Collection Reference
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future addUserData(User user) async {
    print('updating ' +user.uid.toString());
     return await _usersCollection.doc().set({
      'username': user.displayName,
      'phoneNumber': user.mobileNumber,
      'email': user.email,
    });
  }
}
