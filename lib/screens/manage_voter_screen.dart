import 'package:flutter/material.dart';
import '../models/voter.dart';
import '../providers/voterprovider.dart';
import 'package:provider/provider.dart';
import '../providers/authprovider.dart';

class ManageVoterScreen extends StatefulWidget {
  @override
  _ManageVoterScreenState createState() => _ManageVoterScreenState();
  static const routeName = '/ManageVoterScreen';
}

class _ManageVoterScreenState extends State<ManageVoterScreen> {
  bool isLoading = false;
  var manageVoter = Voter(
      voterId: null,
      voterName: null,
      voterNicNumber: null,
      voterMobileNumber: null,
      voterAddress: null,
      voterHalkaNumber: null);
  final formKey = GlobalKey<FormState>();
  void saveForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      formKey.currentState.save();
      bool checkNic = await Provider.of<AuthProvider>(context, listen: false)
          .MatchNicExist(manageVoter.voterNicNumber);
      bool checkNumber =
          await await Provider.of<AuthProvider>(context, listen: false)
              .MatchMobileNumberExist(manageVoter.voterMobileNumber);
      print(checkNic);
      if (!checkNic&&!checkNumber) {
        await Provider.of<VoterProvider>(context, listen: false)
            .registerVoter(manageVoter);
      } else  {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content: Text('Nic & Mobile number already exist'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('Okay'))
                ],
              );
            });
      }
    
    } catch (error) {
      throw error;
    } finally {
      setState(() {
        isLoading = false;
      });
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  saveForm();
                  print('Voter Registered Successfully');
                })
          ],
          centerTitle: true,
          title: Text(
            'Managing Voter',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'satisfy',
                fontWeight: FontWeight.w400,
                fontSize: 25),
          ),
          backgroundColor: Colors.green[700],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : Container(
                height: double.infinity,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          height: 550,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Card(
                            elevation: 6,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter name',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterName: value,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter nic number',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber: value,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter mobile number',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber: value,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter address',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress: value,
                                          voterHalkaNumber:
                                              manageVoter.voterHalkaNumber);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Enter voter halka number',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    onSaved: (value) {
                                      manageVoter = Voter(
                                          voterId: manageVoter.voterId,
                                          voterName: manageVoter.voterName,
                                          voterNicNumber:
                                              manageVoter.voterNicNumber,
                                          voterMobileNumber:
                                              manageVoter.voterMobileNumber,
                                          voterAddress:
                                              manageVoter.voterAddress,
                                          voterHalkaNumber: value);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green[700],
                                    border: Border.all(
                                        style: BorderStyle.solid, width: 2.0),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: FlatButton(
                                      onPressed: () {
                                        saveForm();
                                        print('Voter Registered Successfully');
                                      },
                                      child: Text(
                                        'Register Voter',
                                        style: TextStyle(
                                            fontFamily: 'josefin',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 15),
                                      )),
                                ),
                              ],
                            ),
                          ))),
                ),
              ));
  }
}
