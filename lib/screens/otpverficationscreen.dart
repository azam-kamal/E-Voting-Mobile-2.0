import 'package:flutter/material.dart';
import 'package:flutter_otp/flutter_otp.dart';

class OtpVerificationScreen extends StatelessWidget {
  static const routeName = '/Otpscreen';
  FlutterOtp otp = FlutterOtp();
  final String mobileNumber;
  OtpVerificationScreen({this.mobileNumber});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Verfication',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'satisfy',
              fontWeight: FontWeight.w400,
              fontSize: 25),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
          child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/otplogo.jpg',
                  fit: BoxFit.cover,
                  height: 140,
                ),
              ),
            ),
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
                    otp.sendOtp('3343648579', '1 2 3 4 5');
                  },
                  child: Text(
                    'Send Otp',
                    style: TextStyle(
                        fontFamily: 'josefin',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 15),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
