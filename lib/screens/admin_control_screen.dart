import '../screens/manage_voter_screen.dart';
import 'package:flutter/material.dart';
import '../screens/voterauthscreen.dart';

class AdminControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey[800],
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.login),
                onPressed: () =>
                    Navigator.of(context).pushNamed(VoterAuthScreen.routeName))
          ],
          //centerTitle: true,
          title: Text(
            'Managing Voter & Candidate',
            style: TextStyle(
                color: Colors.white,
                //fontFamily: 'satisfy',
                fontWeight: FontWeight.w400,
                fontSize: 19),
          ),
          backgroundColor: Color.fromRGBO(24, 44, 37, 1),
        ),
        body: Center(
          child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              height: 350,
              child: Card(
                  elevation: 3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/Logo 1.0.png',
                            fit: BoxFit.cover,
                            height: 160,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(24, 44, 37, 1),
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ManageVoterScreen.routeName);
                                },
                                child: Text(
                                  'Manage Voters',
                                  style: TextStyle(
                                      //fontFamily: 'josefin',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 15),
                                )),
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(24, 44, 37, 1),
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: FlatButton(
                                onPressed: () {},
                                child: Text(
                                  'Manage Candidates',
                                  style: TextStyle(
                                      //fontFamily: 'josefin',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ))),
        ));
  }
}
