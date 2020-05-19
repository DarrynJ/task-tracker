import 'package:firebase_database/firebase_database.dart';

class ServiceBase {
  DatabaseReference _databaseReference;

  ServiceBase(String reference) {
    _databaseReference.child(reference);
  }

  DatabaseReference getReference() => this._databaseReference;
}
