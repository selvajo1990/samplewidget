import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference useraccount =
      Firestore.instance.collection('accountinfo');

  // Auth change user stream
  Stream<GetUserState> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged
        .map((FirebaseUser user) => _convert2AccountInfo(user));
  }

  GetUserState _convert2AccountInfo(FirebaseUser firebaseUser) {
    if (firebaseUser != null) {
      return GetUserState(uid: firebaseUser.uid);
    } else {
      return GetUserState(uid: null);
    }
  }

  Future<AccountInfo> getUserAccountInfoByID(String uid) async {
    DocumentSnapshot _documentSnapshot;
    if (uid != null) {
      _documentSnapshot = await useraccount.document(uid).get();
      return _convert2UserAccountDetail(_documentSnapshot, uid);
    } else {
      return _convert2UserAccountDetail(
          _documentSnapshot, uid); // TECH check with karthi
    }
  }

  AccountInfo _convert2UserAccountDetail(
      DocumentSnapshot _documentSnapshot, String uid) {
    if (_documentSnapshot != null) {
      return AccountInfo(
          uid: uid,
          username: _documentSnapshot.data['username'] ?? null,
          isuserverified: _documentSnapshot.data['isUserVerified'] ?? false);
    } else {
      return AccountInfo();
    }
  }

  Future signInWithFirebase(String email, String password) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      print('sign in');
      print(firebaseUser.email);
      return firebaseUser;
    } catch (e) {
      print('sign in failed');
      return null;
    }
  }

  Future signOut() async {
    return await _firebaseAuth.signOut();
  }

  // to sign in as unknown to firebase
  Future signInAnanymous() async {
    try {
      AuthResult authResult = await _firebaseAuth.signInAnonymously();
      FirebaseUser firebaseUser = authResult.user;
      DocumentSnapshot _document =
          await useraccount.document('2LpHJh0eUUXN400I8bWK4MtYXsN2').get();
      return _convert2UserModel(
          firebaseUser,
          AccountInfo(
              username: _document.data['username'] ?? null,
              isuserverified: _document.data['isverified'] ?? false));
    } catch (e) {
      print('error in sign in ' + e);
    }
  }

  UserModel _convert2UserModel(
      FirebaseUser firebaseUser, AccountInfo accountInfo) {
    print(accountInfo.username + 'printed in class');
    return firebaseUser != null ? UserModel(uid: firebaseUser.uid) : null;
  }
}

class UserModel {
  final String uid;
  UserModel({this.uid});
}

class AccountInfo {
  final String username;
  final bool isuserverified;
  final String uid;
  AccountInfo({this.username, this.isuserverified, this.uid});
}

class GetUserState {
  final String uid;
  GetUserState({this.uid});
}
