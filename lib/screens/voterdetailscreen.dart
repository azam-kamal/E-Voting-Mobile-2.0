import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/voterprovider.dart';
import '../widgets/voterdetail.dart';
import 'package:provider/provider.dart';

class VoterDetailScreen extends StatefulWidget {
  static const routeName = '/VoterDetailScreen';
  @override
  _VoterDetailScreenState createState() => _VoterDetailScreenState();
}
var init=true;
class _VoterDetailScreenState extends State<VoterDetailScreen> {
  @override
  void didChangeDependencies() {
    if(init){
      Provider.of<VoterProvider>(context).fetchVoter();
      init=false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Voter Detail'),
          backgroundColor: Colors.green[700],
        ),
        body: Consumer<VoterProvider>(
          builder: (ctx, voterDetails, _) {
            return Container(
              margin: EdgeInsets.all(20),
              height: 500,
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
