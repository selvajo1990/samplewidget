import 'package:flutter/material.dart';

import '../_stream.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Drawer(
      child: ListView(
        children: [
          _drawerHeader(context),
          _drawerbody(
            icon: Icons.people,
            name: 'Users',
            onTap: () {},
          ),
          _drawerbody(
            icon: Icons.exit_to_app,
            name: 'Log Out',
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                child: AlertDialog(
                  title: Text('Do you want to Sign Out ?'),
                  elevation: 24.0,
                  actions: [
                    RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () async {
                        dynamic result = await _authService.signOut();
                        if (result == null) {
                          print('sign out');
                        }
                        Navigator.pop(context);
                      },
                      child: Text("Sign Out"),
                    ),
                    Spacer(),
                    RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              );
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
        color: Theme.of(context).primaryColor,
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
                          'https://images.unsplash.com/photo-1595840635571-5d6abc7d584b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=687&q=80',
                        ),
                        fit: BoxFit.cover)),
              ),
              Text(
                'SelvaKumar Thangavelu',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              textbadge('Super User'),
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

Widget textbadge(String badgeName) {
  return Card(
      margin: EdgeInsets.all(2),
      elevation: 4.0,
      color: Colors.yellowAccent[400],
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            badgeName,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ));
}
