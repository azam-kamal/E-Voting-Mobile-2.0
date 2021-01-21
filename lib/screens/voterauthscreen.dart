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
  final cnicController = TextEditingController();
  final mobController = TextEditingController();
  String voterMobileNumber, voterNic;
  RegExp nic = new RegExp(r'^[0-9+]{5}\-+[0-9+]{7}\-+[0-9]{1}$');
  RegExp mob = new RegExp(r'^[0-9]{4}\-[0-9]{7}$');

  final formKey = GlobalKey<FormState>();

  void saveForm() async {
    // print(mob.hasMatch('0301-2633416'));
    // print(exp.hasMatch('42101-0793793-9'));
    try {
      formKey.currentState.save();

      if (formKey.currentState.validate()) {
        setState(() {
          isLoading = true;
        });

        await Provider.of<VoterProvider>(context)
            .loginVoter(voterNic, voterMobileNumber);
        if (Provider.of<VoterProvider>(context).voterItems.length == 0) {
          return;
        } else
          Navigator.of(context)
              .pushReplacementNamed(OtpFirebaseScreen.routeName);
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
      // setState(() {
      //   isLoading = false;
      // });
    }
    // Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cnicController.dispose();
    mobController.dispose();
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
                        height: mediaquery.size.height * 0.6,
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
                                          controller: cnicController,
                                          validator: (value) {
                                            if (!nic.hasMatch(value)) {
                                              return 'Please Enter Valid Nic Number';
                                            }
                                          },

                                          //return value;

                                          maxLength: 15,
                                          // onChanged: (val) {
                                          //   if (val.length == 5) {
                                          //     var txt = val + '-';
                                          //     cnicController.text = txt;
                                          //     setState(() {
                                          //       cnicController.selection =
                                          //           TextSelection.fromPosition(
                                          //               TextPosition(
                                          //                   offset:
                                          //                       cnicController
                                          //                           .text
                                          //                           .length));
                                          //     });

                                          ///setState(() {});
                                          //   }
                                          //   if (val.length == 13) {
                                          //     var txt2 = val + '-';
                                          //     cnicController.text = txt2;
                                          //     setState(() {
                                          //       cnicController.selection =
                                          //           TextSelection.fromPosition(
                                          //               TextPosition(
                                          //                   offset:
                                          //                       cnicController
                                          //                           .text
                                          //                           .length));
                                          //     });
                                          //   }
                                          // },
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Your CNIC',
                                              hintStyle:
                                                  TextStyle(fontSize: 20)),
                                          onSaved: (value) {
                                            voterNic = value;
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (!mob.hasMatch(value)) {
                                              return 'Please Enter Valid Mobile Number';
                                            }
                                          },
                                          maxLength: 12,
                                          controller: mobController,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Enter Your Mobile Number',
                                              hintStyle:
                                                  TextStyle(fontSize: 20)),
                                          // onChanged: (val) {
                                          //   if (val.length == 4) {
                                          //     var txt3 = val + '-';
                                          //     mobController.text = txt3;
                                          //     setState(() {
                                          //       mobController.selection =
                                          //           TextSelection.fromPosition(
                                          //               TextPosition(
                                          //                   offset:
                                          //                       mobController
                                          //                           .text
                                          //                           .length));
                                          //     });
                                          //   }
                                          // },
                                          onSaved: (value) {
                                            voterMobileNumber = value;
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
                                                  //fontFamily: 'josefin',
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
