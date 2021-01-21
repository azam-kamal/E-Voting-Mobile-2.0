import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/voterprovider.dart';
import '../widgets/voterdetail.dart';

class VoterDetailScreen extends StatefulWidget {
  static const routeName = '/VoterDetailScreen';
  @override
  _VoterDetailScreenState createState() => _VoterDetailScreenState();
}

bool isLoading = false;
var init = true;

class _VoterDetailScreenState extends State<VoterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                init = true;
                setState(() {
                  isLoading = true;
                });
                //We are initializing init = true because we can see that didchange dependecies functio run
                // multiple times so we init =true after user logout init will be true but when the user login
                // did change dependencies will not be run becase init will be false again

                await Provider.of<VoterProvider>(context).logoutVoterDetail();
                Future.delayed(Duration(seconds: 2)).then((value) {
                  setState(() {
                    isLoading = false;
                    Navigator.of(context).pop();
                  });
                });
                //Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
          title: Text(
            'Your Details',
            style: TextStyle(
              color: Colors.white,
              //fontFamily: 'satisfy',
              //fontWeight: FontWeight.w400,
              //fontSize: 25
            ),
          ),
          backgroundColor: Color.fromRGBO(24, 44, 37, 1),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(24, 44, 37, 1),
              ))
            : Consumer<VoterProvider>(
                builder: (ctx, voterDetails, _) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    //height: 800,
                    //alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(2)),
                    child: Card(
                      elevation: 3,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          print(voterDetails.voterItems[index].voterName);
                          return VoterDetail(
                              voterDetails.voterItems[index].voterId,
                              voterDetails.voterItems[index].voterName,
                              voterDetails.voterItems[index].voterNicNumber,
                              voterDetails.voterItems[index].voterMobileNumber,
                              voterDetails.voterItems[index].voterAddress,
                              voterDetails.voterItems[index].votercityName,
                              voterDetails.voterItems[index].voterProvince,
                              voterDetails.voterItems[index].voterHalkaNumber,
                              voterDetails.voterItems[index]
                                  .voterHalkaLocationLongitude,
                              voterDetails.voterItems[index]
                                  .voterHalkaLocationLatitude);
                        },
                        itemCount: voterDetails.voterItems.length,
                      ),
                    ),
                  );
                },
              ));
  }
}
