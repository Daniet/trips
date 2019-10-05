
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';

class UserBloc implements Bloc {

  final _auth_repository = AuthRepository();

//  fujo de datso - streams -firebase
  Stream streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream get authStatus => streamFirebase;

  Future singIn() => _auth_repository.signInFirebase();

  signOut() => _auth_repository.signOut();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}