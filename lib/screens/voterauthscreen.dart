import 'package:E_Voting_System/screens/voterdetailscreen.dart';

import '../providers/voterprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'otpFirebase.dart';

class VoterAuthScreen extends StatefulWidget {
  static const routeName = '/VoterAuthScreen';
  @override
  _VoterAuthScreenState createState() => _VoterAuthScreenState();
}

bool isLoading = false;

class _VoterAuthScreenState extends State<VoterAuthScreen> {
  final cnicController1 = TextEditingController();
  final cnicController2 = TextEditingController();
  final cnicController3 = TextEditingController();
  final mobController1 = TextEditingController();
  final mobController2 = TextEditingController();
  var cnicFocus1 = FocusNode();
  var cnicFocus2 = FocusNode();
  var cnicFocus3 = FocusNode();
  var mobFocus1 = FocusNode();
  var mobFocus2 = FocusNode();

  String voterMobileNumber, voterNic;
  //RegExp nic = new RegExp(r'^[0-9+]{5}\-+[0-9+]{7}\-+[0-9]{1}$');
  RegExp nic1 = new RegExp(r'^[0-9]{5}$');
  RegExp nic2 = new RegExp(r'^[0-9]{7}$');
  RegExp nic3 = new RegExp(r'^[0-9]{1}$');
  //RegExp mob = new RegExp(r'^[0-9]{4}\-[0-9]{7}$');
  RegExp mob1 = new RegExp(r'^[0-9]{4}$');
  RegExp mob2 = new RegExp(r'^[0-9]{7}$');

  final formKey = GlobalKey<FormState>();

  void saveForm() async {
    try {
      formKey.currentState.save();

      if (formKey.currentState.validate()) {
        setState(() {
          isLoading = true;
        });

        await Provider.of<VoterProvider>(context, listen: false)
            .loginVoter(voterNic, voterMobileNumber);
        if (Provider.of<VoterProvider>(context, listen: false)
                .voterItems
                .length ==
            0) {
          return;
        } else
          isLoading = false;
        //Navigator.of(context).pushReplacementNamed(OtpFirebaseScreen.routeName);
        Navigator.of(context).pushReplacementNamed(VoterDetailScreen.routeName);
      }
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
                        setState(() {
                          isLoading = false;
                        });
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
  void dispose() {
    // TODO: implement dispose
    cnicController1.dispose();
    mobController1.dispose();
    cnicController2.dispose();
    mobController2.dispose();
    cnicController3.dispose();
    cnicFocus1.dispose();
    cnicFocus2.dispose();
    cnicFocus3.dispose();
    mobFocus1.dispose();
    mobFocus2.dispose();
    super.dispose();
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
            : LayoutBuilder(
                builder: (ctx, constraints) {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.2,
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
                            height: constraints.maxHeight * 0.08,
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
                            height: constraints.maxHeight * 0.08,
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
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.top) *
                                0.58,
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            //height: 490,
                            // height: mediaquery.size.height * 0.6,
                            child: Center(
                                child: Column(
                              children: <Widget>[
                                Container(
                                  height: constraints.maxHeight * 0.1,
                                  alignment: Alignment.topLeft,
                                  // color: Colors.green,
                                  margin: EdgeInsets.only(top: 10),
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
                                              alignment: Alignment.centerLeft,
                                              height:
                                                  constraints.maxHeight * 0.05,
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text(
                                                'CNIC:',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                          Row(
                                            children: [
                                              Container(
                                                height:
                                                    constraints.maxHeight * 0.1,
                                                width:
                                                    constraints.maxWidth * 0.2,
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: TextFormField(
                                                  controller: cnicController1,
                                                  autofocus: true,
                                                  validator: (value) {
                                                    if (!nic1.hasMatch(value)) {
                                                      return 'Please Enter Valid CNIC Number';
                                                    }
                                                  },
                                                  maxLength: 5,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                  ),
                                                  onChanged: (val) {
                                                    if (val.length == 5) {
                                                      cnicFocus2.requestFocus();
                                                    }
                                                  },
                                                  onSaved: (value) {
                                                    voterNic = value + '-';
                                                  },
                                                ),
                                              ),
                                              Container(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.1,
                                                  width: constraints.maxWidth *
                                                      0.1,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '-',
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  )),
                                              Container(
                                                height:
                                                    constraints.maxHeight * 0.1,
                                                width:
                                                    constraints.maxWidth * 0.4,
                                                child: TextFormField(
                                                  focusNode: cnicFocus2,
                                                  controller: cnicController2,
                                                  validator: (value) {
                                                    if (!nic2.hasMatch(value)) {
                                                      return 'Please Enter Valid CNIC Number';
                                                    }
                                                  },
                                                  onChanged: (val) {
                                                    if (val.length == 7) {
                                                      cnicFocus3.requestFocus();
                                                    }
                                                  },
                                                  maxLength: 7,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                  ),
                                                  onSaved: (value) {
                                                    voterNic =
                                                        voterNic + value + '-';
                                                  },
                                                ),
                                              ),
                                              Container(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.1,
                                                  width: constraints.maxWidth *
                                                      0.1,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '-',
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  )),
                                              Container(
                                                height:
                                                    constraints.maxHeight * 0.1,
                                                width:
                                                    constraints.maxWidth * 0.1,
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: TextFormField(
                                                    focusNode: cnicFocus3,
                                                    controller: cnicController3,
                                                    validator: (value) {
                                                      if (!nic3
                                                          .hasMatch(value)) {
                                                        return 'Please Enter Valid CNIC Number';
                                                      }
                                                    },
                                                    maxLength: 1,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    decoration: InputDecoration(
                                                      counterText: "",
                                                    ),
                                                    onSaved: (value) {
                                                      voterNic =
                                                          voterNic + value;
                                                      print(voterNic);
                                                    },
                                                    onChanged: (val) {
                                                      if (val.length == 1) {
                                                        mobFocus1
                                                            .requestFocus();
                                                      }
                                                    }),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              height:
                                                  constraints.maxHeight * 0.04,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(
                                                  left: 5, top: 15),
                                              child: Text(
                                                'Mobile Number:',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                          Row(
                                            children: [
                                              Container(
                                                height:
                                                    constraints.maxHeight * 0.1,
                                                width:
                                                    constraints.maxWidth * 0.2,
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: TextFormField(
                                                    focusNode: mobFocus1,
                                                    validator: (value) {
                                                      if (!mob1
                                                          .hasMatch(value)) {
                                                        return 'Please Enter Valid Mobile Number';
                                                      }
                                                    },
                                                    maxLength: 4,
                                                    controller: mobController1,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    decoration: InputDecoration(
                                                      counterText: "",
                                                    ),
                                                    onSaved: (value) {
                                                      voterMobileNumber =
                                                          value + '-';
                                                    },
                                                    onChanged: (val) {
                                                      if (val.length == 4) {
                                                        mobFocus2
                                                            .requestFocus();
                                                      }
                                                    }),
                                              ),
                                              Container(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.1,
                                                  width: constraints.maxWidth *
                                                      0.1,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '-',
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  )),
                                              Container(
                                                height:
                                                    constraints.maxHeight * 0.1,
                                                width:
                                                    constraints.maxWidth * 0.65,
                                                //margin: EdgeInsets.only(right: 5),
                                                child: TextFormField(
                                                  focusNode: mobFocus2,
                                                  validator: (value) {
                                                    if (!mob2.hasMatch(value)) {
                                                      return 'Please Enter Valid Mobile Number';
                                                    }
                                                  },
                                                  maxLength: 7,
                                                  controller: mobController2,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                  ),
                                                  onSaved: (value) {
                                                    voterMobileNumber =
                                                        voterMobileNumber +
                                                            value;
                                                    print(voterMobileNumber);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            height:
                                                constraints.maxHeight * 0.08,
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(24, 44, 37, 1),
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
                                                      //fontFamily: 'josefin',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                  );
                },
              ));
  }
}
