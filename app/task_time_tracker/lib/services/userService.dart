import 'package:firebase_database/firebase_database.dart';
import 'package:task_time_tracker/services/serviceBase.dart';
import '../models/user.dart';

//
//  This class handles everything related to the user.
//
class UserService extends ServiceBase {
  DatabaseReference _db;

  UserService() : super('users') {
    _db = super.getReference();
  }

  List<User> getUsers() => null;

  User getUserByUsername(String username) => null;

  User getUserByEmail(String email) => null;

  void addUser(User user) {}

  void updateUser(User user) {}

  void deleteUser(User user) {}
}
