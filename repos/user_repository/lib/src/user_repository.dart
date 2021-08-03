import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:uuid/uuid.dart';
import './models/models.dart';

List<User> _users = [
  User(username: 'aldy1', password: 'aldy123', id: Uuid().v4()),
  User(username: 'aldy2', password: 'aldy321', id: Uuid().v4())
];

class UserRepository {
  User? _user;

  void setUser(String username) {
    _user = _users.where((element) => element.username == username).first;
  }

  Future<User?> getUser() async {
    if (_user != null) {
      return _user;
    }

    return Future.delayed(
        Duration(milliseconds: 100), () => _user = _users.first);
  }
}
