import 'VerifyScreen.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../providers/voterprovider.dart';
import 'package:provider/provider.dart';
import '../screens/voterauthscreen.dart';
class SelectOptionScreen extends StatefulWidget {
  static const routeName = '/selectOptionScreen';

  @override
  _SelectOptionScreenState createState() => _SelectOptionScreenState();
}

String value = 'National Assembly';
List<S2Choice<String>> options = [
  S2Choice<String>(value: 'PTI', title: 'PTI'),
  S2Choice<String>(value: 'PML(N)', title: 'PML(N)'),
  S2Choice<String>(value: 'PPP', title: 'PPP'),
  S2Choice<String>(value: 'MQM', title: 'MQM'),
  S2Choice<String>(value: 'PSP', title: 'PSP'),
  S2Choice<String>(value: 'Independent', title: 'Independent Candidate'),
];

String value2 = 'Provincial Assembly';
List<S2Choice<String>> options2 = [
  S2Choice<String>(value: 'PTI', title: 'PTI'),
  S2Choice<String>(value: 'PML(N)', title: 'PML(N)'),
  S2Choice<String>(value: 'PPP', title: 'PPP'),
  S2Choice<String>(value: 'MQM', title: 'MQM'),
  S2Choice<String>(value: 'PSP', title: 'PSP'),
  S2Choice<String>(value: 'Independent', title: 'Independent Candidate'),
];
bool isLoading=false;
class _SelectOptionScreenState extends State<SelectOptionScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
         actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
               
                setState(() {
                  isLoading = true;
                });
            
                await Provider.of<VoterProvider>(context).logoutVoterDetail();
                Future.delayed(Duration(seconds: 2)).then((value) {
           
                    isLoading = false;
                    Navigator.of(context).pushReplacementNamed(VoterAuthScreen.routeName);
                  
                });
                //Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        title: Text('Vote Selection'),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(24, 44, 37, 1),
      ),
      body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(24, 44, 37, 1),
              ))
            : Container(
        margin: EdgeInsets.only(right: 10, left: 10),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //height: mediaquery.size.height * 0.3,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: FittedBox(
                        child: Image.asset('assets/images/national.jpg')),
                  ),
                  Text('National Assembly',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SmartSelect<String>.single(
                      title: 'Select Party',
                      value: value,
                      choiceItems: options,
                      onChange: (state) => setState(() => value = state.value)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Candidate ', style: TextStyle(fontSize: 16)),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text('NAME',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              // height: mediaquery.size.height * 0.2,
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 40,
                      child: FittedBox(
                          child: Image.asset('assets/images/provincial.png'))),
                  Text('Provincial Assembly',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SmartSelect<String>.single(
                      title: 'Select Party',
                      value: value,
                      choiceItems: options2,
                      onChange: (state) => setState(() => value = state.value)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Candidate ', style: TextStyle(fontSize: 16)),
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text('NAME',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(24, 44, 37, 1),
                      border: Border.all(style: BorderStyle.solid, width: 2.0),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(VerifyScreen.routeName);
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
            ),
          ],
        ),
      ),
    ));
  }
}
