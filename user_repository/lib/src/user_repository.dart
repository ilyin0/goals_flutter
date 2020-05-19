import 'package:meta/meta.dart';

abstract class UserRepository {
  Future<bool> isSignedIn();

  Future<void> authenticate();

  Future<String> getUserId();

  Future<void> signUp({String email, String password});

  Future<void> signOut();

  Future<String> getUser();

  Future<void> signInWithCredentials(
      {@required String email, @required String password});
}
