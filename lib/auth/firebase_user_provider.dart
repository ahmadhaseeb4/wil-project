import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class WilvcdnFirebaseUser {
  WilvcdnFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

WilvcdnFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<WilvcdnFirebaseUser> wilvcdnFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<WilvcdnFirebaseUser>(
        (user) => currentUser = WilvcdnFirebaseUser(user));
