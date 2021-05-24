import 'package:E_Voting_System/screens/voterauthscreen.dart';
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
            
                await Provider.of<VoterProvider>(context,listen: false).logoutVoterDetail();
                Future.delayed(Duration(seconds: 2)).then((value) {
                  setState(() {
                    isLoading = false;
                    Navigator.of(context).pushReplacementNamed(VoterAuthScreen.routeName);
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
                              voterDetails.voterItems[index].pollingStationId,
                              voterDetails.voterItems[index].voterName,
                              voterDetails.voterItems[index].voterNicNumber,
                              voterDetails.voterItems[index].voterMobileNumber,
                              voterDetails.voterItems[index].voterAddress,
                              voterDetails.voterItems[index].votercityName,
                              voterDetails.voterItems[index].voterProvince,
                              voterDetails.voterItems[index].voterPollingStationNumber,
                              voterDetails.voterItems[index]
                                  .voterPollingStationLocationLongitude,
                              voterDetails.voterItems[index]
                                  .voterPollingStationLocationLatitude);
                        },
                        itemCount: voterDetails.voterItems.length,
                      ),
                    ),
                  );
                },
              ));
  }
}
