import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../_stream.dart';

class UserListDrawer extends StatefulWidget {
  UserListDrawer({Key key}) : super(key: key);
  static const String routeName = '/UserListDrawer';
  final AuthService _authService = AuthService();
  @override
  _UserListDrawerState createState() => _UserListDrawerState();
}

class _UserListDrawerState extends State<UserListDrawer> {
  @override
  Widget build(BuildContext context) {
    var _streamBuilder = StreamBuilder(
      stream: widget._authService.userAccountList,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Text('Loading'),
            );
          default:
            if (snapshot.hasError) {
              return Text('error in loading:' + snapshot.error);
            } else {
              return createListView(context, snapshot);
            }
        }
      },
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User List'),
        ),
        body: _streamBuilder,
      ),
    );
  }
}

createListView(BuildContext context, AsyncSnapshot asyncSnapshot) {
  List<DocumentSnapshot> userList = [];
  userList = asyncSnapshot.data.documents;
  return ListView.builder(
    itemCount: userList.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        child: Container(
          child: ListTile(
            onTap: () {
              _showBottomSheet(context, userList[index]);
            },
            title: Text(
              userList[index].data['username'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              'User Verified: ' + userList[index].data['isverified'].toString(),
              style: TextStyle(fontSize: 16),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
              radius: 30,
              child: Text(
                userList[index].data['username'][0],
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      );
    },
  );
}

_showBottomSheet(context, DocumentSnapshot userList) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
              ]),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: UserDetailForm(
            userList: userList,
          ),
        );
      });
}

class UserDetailForm extends StatefulWidget {
  final DocumentSnapshot userList;
  UserDetailForm({this.userList});
  @override
  _UserDetailFormState createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  final formkey = GlobalKey<FormState>();
  bool _isSuperUser;
  bool _isUserVerified;
  final AuthService _authService = AuthService();
  void initState() {
    _isUserVerified = widget.userList.data['isverified'];
    _isSuperUser = widget.userList.data['isSuperUser'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Text(
              'Update User Info',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.userList.data['username'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Verify User:',
                  style: TextStyle(fontSize: 15),
                ),
                Switch(
                  value: _isUserVerified,
                  onChanged: (value) {
                    setState(() {
                      _isUserVerified = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Super User:',
                  style: TextStyle(fontSize: 15),
                ),
                Switch(
                  value: _isSuperUser,
                  onChanged: (value) {
                    setState(() {
                      _isSuperUser = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
            RaisedButton(
              onPressed: () async {
                dynamic isUpdated = await _authService.updateUserAccountInfo(
                  widget.userList.documentID,
                  _isUserVerified,
                  _isSuperUser,
                );
                if (isUpdated == null) {
                  print('updated successfully');
                } else {
                  print('failed bhai');
                }
              },
              color: Colors.greenAccent,
              child: Text(
                'Update',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class UserListDrawer extends StatefulWidget {
//   UserListDrawer({Key key}) : super(key: key);
//   static const String routeName = '/UserListDrawer';
//   final AuthService _authService = AuthService();
//   @override
//   _UserListDrawerState createState() => _UserListDrawerState();
// }

// class _UserListDrawerState extends State<UserListDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     var futureBuilder = new FutureBuilder(
//       future: widget._authService.getUserInformationList(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return Center(
//               child: Text('Loading'),
//             );
//           default:
//             if (snapshot.hasError) {
//               return Text('error in loading:' + snapshot.error);
//             } else {
//               return createListView(context, snapshot);
//             }
//         }
//       },
//     );

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('User List'),
//         ),
//         body: futureBuilder,
//       ),
//     );
//   }
// }
