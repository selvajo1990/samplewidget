import 'package:flutter/material.dart';
import 'package:widget_samples/screen/dashboard.dart';
import 'package:widget_samples/screen/dashboard1.dart';
// import 'package:widget_samples/screen/_stream.dart';
// import 'package:provider/provider.dart';
//import '_logindecider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<GetUserState>.value(
//         value: AuthService().onAuthStateChanged,
//         builder: (context, snapshot) {
//           return MaterialApp(
//             home: LoginDecider(),
//           );
//         });
//   }
// }
