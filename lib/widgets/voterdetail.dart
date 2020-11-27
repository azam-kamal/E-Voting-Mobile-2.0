import 'package:flutter/material.dart';

class VoterDetail extends StatelessWidget {
  final String id;
  final String name;
  final String nicNumber;
  final String mobileNumber;
  final String address;
  final String halkaNumber;
  VoterDetail(this.id,this.name, this.nicNumber, this.mobileNumber, this.address,
      this.halkaNumber);
      
  @override
  Widget build(BuildContext context) {
  print(name);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.account_circle,
              color: Colors.green[700],
            ),
            Text(name)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.call,
              color: Colors.green[700],
            ),
            Text(mobileNumber)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.beenhere,
              color: Colors.green[700],
            ),
            Text(nicNumber)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.home,
              color: Colors.green[700],
            ),
            Text(address)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.how_to_vote,
              color: Colors.green[700],
            ),
            Text(halkaNumber)
          ],
        ),
      ],
    );
  }
}
