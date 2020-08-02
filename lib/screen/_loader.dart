import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:widget_samples/screen/_stream.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoadingOverlay(
                  child: Center(
            child: Container(
              child: FlatButton.icon(
                  onPressed: () async {
                    dynamic _user = await _authService.signInAnanymous();
                    if (_user == null) {
                      print('error after trying sign in');
                    } else {
                      print('successfully signed in');
                      print(_user);
                    }
                  },
                  icon: Icon(Icons.access_time),
                  label: Text("Sign In")),
            ),
          ),
          isLoading: false,
          color: Colors.black.withOpacity(0.5),
          progressIndicator: loaderwithoutMA(),
        ),
      ),
    );
  }
}

Widget loaderwithoutMA() {
  return Center(
    child: Container(
      color: Colors.black.withOpacity(0.35),
      child: SpinKitWanderingCubes(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.yellowAccent : Colors.greenAccent,
            ),
          );
        },
        size: 50.0,
      ),
    ),
  );
}

Widget loader() {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: SpinKitFadingCircle(
            itemBuilder: (_, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color:
                      index.isEven ? Colors.yellowAccent : Colors.greenAccent,
                ),
              );
            },
            size: 50.0,
          ),
        ),
      ),
    ),
  );
}
