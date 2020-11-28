import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/voterprovider.dart';
import '../widgets/voterdetail.dart';
import 'package:provider/provider.dart';
import '../providers/authprovider.dart';

class VoterDetailScreen extends StatefulWidget {
  static const routeName = '/VoterDetailScreen';
  @override
  _VoterDetailScreenState createState() => _VoterDetailScreenState();
}

var init = true;
bool isLoading = true;

class _VoterDetailScreenState extends State<VoterDetailScreen> {
  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<VoterProvider>(context).fetchVoter().then((_) {
        setState(() {
          isLoading = false;
        });
      });
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await Provider.of<AuthProvider>(context).logoutVoter();
                await Provider.of<VoterProvider>(context).logoutVoterDetail();
                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
          title: Text(
            'Voter Detail',
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
                  backgroundColor: Colors.green[700],
                ),
              )
            : Consumer<VoterProvider>(
                builder: (ctx, voterDetails, _) {
                  return Container(
                    margin: EdgeInsets.all(20),
                    height: 520,
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Card(
                      elevation: 6,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          print(voterDetails.voterItems[index].voterName);
                          return VoterDetail(
                              voterDetails.voterItems[index].voterId,
                              voterDetails.voterItems[index].voterName,
                              voterDetails.voterItems[index].voterNicNumber,
                              voterDetails.voterItems[index].voterMobileNumber,
                              voterDetails.voterItems[index].voterAddress,
                              voterDetails.voterItems[index].voterHalkaNumber);
                        },
                        itemCount: voterDetails.voterItems.length,
                      ),
                    ),
                  );
                },
              ));
  }
}
