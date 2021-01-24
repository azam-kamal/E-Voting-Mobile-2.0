import '../screens/voterdetailscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/voterprovider.dart';

class OtpFirebaseScreen extends StatefulWidget {
  static const routeName = '/OtpFirebasescreen';

  @override
  _OtpFirebaseScreenState createState() => _OtpFirebaseScreenState();
}

class _OtpFirebaseScreenState extends State<OtpFirebaseScreen> {
  var _codeController =TextEditingController();
  String smsCode;

  var authCredential;


  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
//code for signing in                          authCredential

          _auth.signInWithCredential(authCredential).then((AuthResult result) {
            Navigator.of(context)
                .pushReplacementNamed(VoterDetailScreen.routeName);
          }).catchError((e) {
            print(e);
          });
        },
        verificationFailed: null,
        codeSent: (String verificationId, [int forceResendingToken]) {
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: Text("Enter the Code Sent to Your Mobile",style: TextStyle(fontSize: 16),),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _codeController,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Done"),
                        textColor: Colors.white,
                        color: Color.fromRGBO(24, 44, 37, 1),
                        onPressed: () {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          smsCode = _codeController.text.trim();

                          authCredential = PhoneAuthProvider.getCredential(
                              verificationId: verificationId, smsCode: smsCode);
                          auth
                              .signInWithCredential(authCredential)
                              .then((AuthResult result) {
                            Navigator.of(context).pushReplacementNamed(
                                VoterDetailScreen.routeName);
                          }).catchError((e) {
                            print(e);
                          });
                        },
                      )
                    ],
                  ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }

  String mobNum = '';

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VoterProvider>(context).voterItems.length != 0) {
      mobNum =
          Provider.of<VoterProvider>(context).voterItems[0].voterMobileNumber;
      String altNum1 = mobNum.substring(1);
      String altNum2 = altNum1.substring(0, 3);
      String removeDash = altNum1.substring(4);
      mobNum = '+92' + altNum2 + removeDash;
      print(mobNum);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Verfication',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Color.fromRGBO(24, 44, 37, 1),
      ),
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/otplogo.jpg',
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            ),
            Container(
                child: Column(
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Please ',style: TextStyle(fontSize: 16),),
                        Text('"CONFIRM" ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        Text('that you are having Mobile',style: TextStyle(fontSize: 16)),
                        
                      ],
                    ),
                    Text(' Number right now registered with E Voting',style: TextStyle(fontSize: 16))
                  ],
                )),
            Container(),
            Container(
              margin: EdgeInsets.only(bottom:20),
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromRGBO(24, 44, 37, 1),
                border: Border.all(style: BorderStyle.solid, width: 2.0),
                borderRadius: BorderRadius.circular(40),
              ),
              child: FlatButton(
                  onPressed: () {
                    mobNum = '+923456019354';
                    registerUser(mobNum, context);
                  },
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(
                        //fontFamily: 'josefin',
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
