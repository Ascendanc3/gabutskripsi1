import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HukumBitungWebFirebaseUser {
  HukumBitungWebFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

HukumBitungWebFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HukumBitungWebFirebaseUser> hukumBitungWebFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<HukumBitungWebFirebaseUser>(
            (user) => currentUser = HukumBitungWebFirebaseUser(user));
