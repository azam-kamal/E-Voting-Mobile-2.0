import 'package:E_Voting_System/screens/VerifyScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/voterauthscreen.dart';
import './screens/voterdetailscreen.dart';
import './screens/otpFirebase.dart';
import './providers/voterprovider.dart';
import './screens/pollingStationScreen.dart';
import './screens/selectOption.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
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
          debugShowCheckedModeBanner: false,
          routes: {
            VoterAuthScreen.routeName: (ctx) => VoterAuthScreen(),
            VoterDetailScreen.routeName: (ctx) => VoterDetailScreen(),
            OtpFirebaseScreen.routeName: (ctx) => OtpFirebaseScreen(),
            PollingStationScreen.routeName: (ctx) => PollingStationScreen(),
            SelectOptionScreen.routeName: (ctx) => SelectOptionScreen(),
            VerifyScreen.routeName: (ctx) => VerifyScreen()
          },
          home: VoterAuthScreen(),
        ));
  }
}
