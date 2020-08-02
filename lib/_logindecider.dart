import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_samples/screen/_stream.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:widget_samples/screen/_loader.dart';

class LoginDecider extends StatefulWidget {
  @override
  _LoginDeciderState createState() => _LoginDeciderState();
}

class _LoginDeciderState extends State<LoginDecider> {
  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<GetUserState>(context);
    final AuthService _authService = AuthService();
    return FutureBuilder<DocumentSnapshot>(
      future: _authService
          .getUserAccountInfoByID(_userState != null ? _userState.uid : null),
      builder: (context, documentSnapshot) {
        if (documentSnapshot.data?.exists ?? false) {
          print(documentSnapshot.data["username"]);
          if (documentSnapshot.data["isverified"] == true) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Container(
                    child: FlatButton.icon(
                        onPressed: () async {
                          dynamic result = await _authService.signOut();
                          if (result == null) {
                            print('sign out');
                          }
                        },
                        icon: Icon(Icons.remove_circle_outline),
                        label: Text('Sign out')),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Container(
                  child: FlatButton.icon(
                      onPressed: () {
                        dynamic result = _authService.signInWithFirebase(
                            'selvajo1990@gmail.com', '123456');
                        if (result == null) {
                          print('sign in failed after validation');
                        } else {
                          print('sign in success after validation');
                        }
                      },
                      icon: Icon(Icons.accessibility_new),
                      label: Text('Sign In with Email')),
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                child: FlatButton.icon(
                    onPressed: () {
                      dynamic result = _authService.signInWithFirebase(
                          'selvajo1990@gmail.com', '123456');
                      if (result == null) {
                        print('sign in failed after validation');
                      } else {
                        print('sign in success after validation');
                      }
                    },
                    icon: Icon(Icons.accessibility_new),
                    label: Text('Sign In with Email')),
              ),
            ),
          );
        }
      },
    );
  }
}

// Widget build(BuildContext context) {
//     final _userState = Provider.of<GetUserState>(context);
//     final AuthService _authService = AuthService();
//     // Receive information from Firebase stream
//     if (_userState != null) {
//       print('stream is working');
//       print(_userState.uid);
//       return MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: Container(
//               child: FlatButton.icon(
//                   onPressed: () {
//                     dynamic result = _authService.signOut();
//                     if (result == null) {
//                       print('sign out');
//                     }
//                   },
//                   icon: Icon(Icons.remove_circle_outline),
//                   label: Text('Sign out')),
//             ),
//           ),
//         ),
//       );
//     } else {
//       print('inside else');
//       return Scaffold(
//         body: Center(
//           child: Container(
//             child: FlatButton.icon(
//                 onPressed: () {
//                   dynamic result = _authService.signInWithFirebase(
//                       'selvajo1990@gmail.com', '123456');
//                   if (result == null) {
//                     print('sign in failed after validation');
//                   } else {
//                     print('sign in success after validation');
//                   }
//                 },
//                 icon: Icon(Icons.accessibility_new),
//                 label: Text('Sign In with Email')),
//           ),
//         ),
//       );
//     }
//   }
