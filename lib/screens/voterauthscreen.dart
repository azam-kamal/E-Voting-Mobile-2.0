import 'package:E_Voting_System/providers/voterprovider.dart';
import 'package:flutter/material.dart';
import '../models/auth.dart';
import '../providers/authprovider.dart';
import 'package:provider/provider.dart';

class VoterAuthScreen extends StatefulWidget {
  static const routeName = '/VoterAuthScreen';
  @override
  _VoterAuthScreenState createState() => _VoterAuthScreenState();
}

bool isLoading = false;

class _VoterAuthScreenState extends State<VoterAuthScreen> {
  var loginVoter =
      Auth(uId: null, nic: null, phoneNumber: null, expiryDate: null);
  final formKey = GlobalKey<FormState>();
  void saveForm() async {
    try {
      setState(() {
        isLoading = true;
      });
      formKey.currentState.save();
      await Provider.of<AuthProvider>(context)
          .loginVoter(loginVoter.nic, loginVoter.phoneNumber);
      // await Provider.of<VoterProvider>(context).fetchVoter();
      Navigator.of(context).pop();
    } catch (error) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: Text('Invalid Nic number & mobile number'),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2.0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text(
                        'Okay',
                        style: TextStyle(
                            fontFamily: 'josefin',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      )),
                ),
              ],
            );
          });
      print(error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor:
            isLoading ? Colors.white : Color.fromRGBO(24, 44, 37, 1),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color.fromRGBO(24, 44, 37, 1),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/Logo 3.0.png',
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        alignment: Alignment.center,
                        child: Text(
                          'السلام عليكم',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'satisfy',
                              fontWeight: FontWeight.w400,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Please Login to Vote',
                          style: TextStyle(
                              color: Colors.white,
                              //fontFamily: 'satisfy',
                              fontWeight: FontWeight.w400,
                              fontSize: 22),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        //height: 490,
                        height: mediaquery.size.height *0.6,
                        child: Center(
                            child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              // color: Colors.green,
                              margin: EdgeInsets.symmetric(vertical: 18),
                              child: IconButton(
                                  color: Color.fromRGBO(24, 44, 37, 1),
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.of(context).pop('/');
                                  }),
                            ),
                            Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Nic is null';
                                            }
                                            return value;
                                          },
                                          maxLength: 15,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Your CNIC',
                                              hintStyle:
                                                  TextStyle(fontSize: 20)),
                                          onSaved: (value) {
                                            loginVoter = Auth(
                                                uId: loginVoter.uId,
                                                nic: value,
                                                phoneNumber:
                                                    loginVoter.phoneNumber,
                                                expiryDate:
                                                    loginVoter.expiryDate);
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Nic is null';
                                            }
                                            return value;
                                          },
                                          maxLength: 11,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Your Mobile Number',
                                              hintStyle:
                                                  TextStyle(fontSize: 20)),
                                          onSaved: (value) {
                                            loginVoter = Auth(
                                                uId: loginVoter.uId,
                                                nic: loginVoter.nic,
                                                phoneNumber: value,
                                                expiryDate:
                                                    loginVoter.expiryDate);
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(24, 44, 37, 1),
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: FlatButton(
                                            onPressed: () {
                                              saveForm();
                                            },
                                            child: Text(
                                              'login',
                                              style: TextStyle(
                                                  fontFamily: 'josefin',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15),
                                            )),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ))),
                  ],
                ),
              ));
  }
}
