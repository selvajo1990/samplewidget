import 'package:flutter/material.dart';
import 'package:widget_samples/screen/drawer/userlistdrawer.dart';
import '../_stream.dart';

AsyncSnapshot<AccountInfo> globalAccountInfo;

class MainDrawer extends StatefulWidget {
  final AsyncSnapshot<AccountInfo> accountInfo;
  MainDrawer({@required this.accountInfo});
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    globalAccountInfo = widget.accountInfo;
    return Drawer(
      child: ListView(
        children: [
          _drawerHeader(context),
          Visibility(
            visible: widget.accountInfo.data.isSuperUser,
            child: _drawerbody(
              icon: Icons.people,
              name: 'Users',
              onTap: () {
                Navigator.of(context).pushNamed(UserListDrawer.routeName);
              },
            ),
          ),
          _drawerbody(
            icon: Icons.exit_to_app,
            name: 'Log Out',
            onTap: () {
              _signOutConfirmation(context);
            },
          )
        ],
      ),
    );
  }
}

Widget _drawerHeader(context) {
  return Container(
    height: 210,
    child: DrawerHeader(
      padding: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        color: Colors.greenAccent,
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 6,
                  bottom: 6,
                ),
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1529335764857-3f1164d1cb24?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=635&q=80',
                        ),
                        fit: BoxFit.cover)),
              ),
              Text(
                globalAccountInfo.data.username,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              textbadge(globalAccountInfo.data.isSuperUser
                  ? 'Admin Role'
                  : 'Normal Role'),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _drawerbody({IconData icon, String name, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}

_signOutConfirmation(BuildContext context) {
  final AuthService _authService = AuthService();
  showDialog(
    context: context,
    barrierDismissible: false,
    child: AlertDialog(
      content: Text('Do you want to Log Out ?'),
      elevation: 4.0,
      actions: [
        RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.green,
          onPressed: () async {
            dynamic result = await _authService.signOut();
            if (result != null) {
              print('sign out failed');
            }
            Navigator.of(context).pop();
          },
          child: Text("Sign Out"),
        ),
        RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
      ],
    ),
  );
}

Widget textbadge(String badgeName) {
  return Card(
      margin: EdgeInsets.all(2),
      elevation: 5.0,
      color: Colors.yellowAccent[400],
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            badgeName,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ));
}
