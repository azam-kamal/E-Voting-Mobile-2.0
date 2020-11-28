import 'package:flutter/material.dart';
import '../screens/otpverficationscreen.dart';

class VoterDetail extends StatelessWidget {
  final String id;
  final String name;
  final String nicNumber;
  final String mobileNumber;
  final String address;
  final String halkaNumber;
  VoterDetail(this.id, this.name, this.nicNumber, this.mobileNumber,
      this.address, this.halkaNumber);

  @override
  Widget build(BuildContext context) {
    print(name);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ClipOval(
            child: Image.asset(
              'assets/images/Logo 1.0.jpg',
              fit: BoxFit.cover,
              height: 140,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: Card(
              elevation: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Colors.green[700],
                  ),
                  Text(name,
                      style: TextStyle(
                        fontFamily: 'josefin',
                        fontWeight: FontWeight.w700,
                        color: Colors.green[700],
                        fontSize: 20,
                      ))
                ],
              )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: Card(
            elevation: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.call,
                  size: 30,
                  color: Colors.green[700],
                ),
                Text(mobileNumber,
                    style: TextStyle(
                      fontFamily: 'josefin',
                      fontWeight: FontWeight.w700,
                      color: Colors.green[700],
                      fontSize: 20,
                    ))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: Card(
            elevation: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.beenhere,
                  size: 30,
                  color: Colors.green[700],
                ),
                Text(nicNumber,
                    style: TextStyle(
                      fontFamily: 'josefin',
                      fontWeight: FontWeight.w700,
                      color: Colors.green[700],
                      fontSize: 20,
                    ))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: Card(
            elevation: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.green[700],
                ),
                Text(address,
                    style: TextStyle(
                      fontFamily: 'josefin',
                      fontWeight: FontWeight.w700,
                      color: Colors.green[700],
                      fontSize: 20,
                    ))
              ],
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: Card(
              elevation: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.how_to_vote,
                    size: 30,
                    color: Colors.green[700],
                  ),
                  Text(halkaNumber,
                      style: TextStyle(
                        fontFamily: 'josefin',
                        fontWeight: FontWeight.w700,
                        color: Colors.green[700],
                        fontSize: 20,
                      ))
                ],
              ),
            )),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green[700],
            border: Border.all(style: BorderStyle.solid, width: 2.0),
            borderRadius: BorderRadius.circular(40),
          ),
          child: FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(OtpVerificationScreen.routeName);
              },
              child: Text(
                'Next',
                style: TextStyle(
                    fontFamily: 'josefin',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 15),
              )),
        ),
      ],
    );
  }
}
