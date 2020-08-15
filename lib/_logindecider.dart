import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_samples/screen/_stream.dart';
import 'package:widget_samples/screen/dashboard.dart';
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
    return FutureBuilder<AccountInfo>(
        initialData: AccountInfo(uid: null),
        future: _authService
            .getUserAccountInfoByID(_userState != null ? _userState.uid : null),
        builder: (context, AsyncSnapshot<AccountInfo> _accountInfo) {
          if (_accountInfo.data.uid == null) {
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
          } else if (_accountInfo.data.isuserverified == true) {
            return Dashboard(accountInfo: _accountInfo);
          } else {
            return Scaffold(
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('User is not verified'),
                    FlatButton.icon(
                        onPressed: () async {
                          dynamic result = await _authService.signOut();
                          if (result == null) {
                            print('sign out');
                          }
                        },
                        icon: Icon(Icons.remove_circle_outline),
                        label: Text('Sign out')),
                  ],
                ),
              ),
            );
          }
        });
  }
}
