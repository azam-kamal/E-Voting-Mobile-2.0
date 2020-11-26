import 'package:E_Voting_System/providers/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/admin_control_screen.dart';
import './screens/manage_voter_screen.dart';
import './providers/voterprovider.dart';
import './screens/voterauthscreen.dart';
import './providers/authprovider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: VoterProvider()),
        ChangeNotifierProvider.value(value: AuthProvider()
        )],
        child: MaterialApp(
          routes: {
            ManageVoterScreen.routeName: (ctx) => ManageVoterScreen(),
            VoterAuthScreen.routeName: (ctx) => VoterAuthScreen()
          },
          home: AdminControlScreen(),
        ));
  }
}
