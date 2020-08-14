import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            cardinDashboard(context),
            Text('data'),
          ],
        ),
      ),
    );
  }
}

Widget cardinDashboard(context) {
  return ListView(
    padding: EdgeInsets.all(0),
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.width - 30) * (8 / 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: <Widget>[
                  creditCard(
                      amount: '12565.23',
                      cardHolder: 'Bibash Adhikari',
                      cardNumber: '4545',
                      expiringDate: '02/21',
                      bankEnding: 'X',
                      backgroundColor: Colors.deepOrangeAccent,
                      context: context),
                  creditCard(
                      amount: '1778.23',
                      cardHolder: 'Ram Adhikari',
                      cardNumber: '5045',
                      expiringDate: '02/21',
                      bankEnding: 'Y',
                      backgroundColor: Colors.blueAccent,
                      context: context),
                  creditCard(
                      amount: '15689556.23',
                      cardHolder: 'Bibash Adhikari',
                      cardNumber: '0545',
                      expiringDate: '02/21',
                      bankEnding: 'PAGAL',
                      backgroundColor: Colors.redAccent,
                      context: context),
                  creditCard(
                      amount: '1203456.23',
                      cardHolder: 'Bibash Adhikari',
                      cardNumber: '5405',
                      expiringDate: '02/21',
                      bankEnding: 'ONE',
                      backgroundColor: Colors.greenAccent,
                      context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget creditCard(
    {String amount,
    String cardNumber,
    String cardHolder,
    String expiringDate,
    String bankEnding,
    Color backgroundColor,
    context}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
    ),
    width: MediaQuery.of(context).size.width - 30,
    child: Stack(
      children: <Widget>[
        ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          children: <Widget>[
            Text(
              'Current Balance',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            Text(
              '\$$amount',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '**** **** **** $cardNumber',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
                letterSpacing: 1.3,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Card Holder',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$cardHolder',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Expires',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$expiringDate',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          right: 25,
          top: 25,
          child: SizedBox(
            // width: 90,
            child: Row(
              children: <Widget>[
                Text(
                  'Bank',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$bankEnding',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 25,
          bottom: 25,
          child: Container(
            child: Icon(
              Icons.credit_card,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTile(Widget child, {Function() onTap}) {
  return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell(
          // Do onTap() if it isn't null, otherwise do print()
          onTap: onTap != null
              ? () => onTap()
              : () {
                  print('Not set yet');
                },
          child: child));
}
