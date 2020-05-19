import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    print(currentUser.email + currentUser.uid);
    return currentUser != null;
  }

  Future<void> authenticate() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).displayName;
  }

  Future<String> getUserEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  @override
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<void> signInWithCredentials({String email, String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
