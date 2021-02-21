import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/voterauthscreen.dart';
import './screens/voterdetailscreen.dart';
import './screens/otpFirebase.dart';
import './providers/voterprovider.dart';
import './screens/pollingStationScreen.dart';
import './screens/selectOption.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: VoterProvider()),
        ],
        child: MaterialApp(
          title: 'E Voting',
          routes: {
            VoterAuthScreen.routeName: (ctx) => VoterAuthScreen(),
            VoterDetailScreen.routeName: (ctx) => VoterDetailScreen(),
            OtpFirebaseScreen.routeName: (ctx) => OtpFirebaseScreen(),
            PollingStationScreen.routeName: (ctx) => PollingStationScreen(),
            SelectOptionScreen.routeName: (ctx) => SelectOptionScreen()
          },
          home: VoterAuthScreen(),
        ));
  }
}
