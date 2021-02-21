import 'package:flutter/material.dart';
import '../providers/voterprovider.dart';
import 'package:provider/provider.dart';
import '../widgets/pollingStationMap.dart';

class PollingStationScreen extends StatefulWidget {
  static const routeName = '/pollinStationScreen';
  @override
  _PollingStationScreenState createState() => _PollingStationScreenState();
}

bool init = true;

class _PollingStationScreenState extends State<PollingStationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Polling Station',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Color.fromRGBO(24, 44, 37, 1),
      ),
      body: Consumer<VoterProvider>(builder: (ctx, voterDetail, _) {
        return PollingStationMap(
          id: voterDetail.voterItems[0].voterId,
          address: voterDetail.voterItems[0].voterAddress,
          longitude:
              voterDetail.voterItems[0].voterPollingStationLocationLongitude,
          latitude:
              voterDetail.voterItems[0].voterPollingStationLocationLatitude,
        );
      }),
    );
  }
}
