import 'package:E_Voting_System/providers/authprovider.dart';
import 'package:E_Voting_System/widgets/voterdetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/admin_control_screen.dart';
import './screens/manage_voter_screen.dart';
import './providers/voterprovider.dart';
import './screens/voterauthscreen.dart';
import './providers/authprovider.dart';
import './screens/voterdetailscreen.dart';
import './screens/otpverficationscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider()),
          ChangeNotifierProxyProvider<AuthProvider, VoterProvider>(
              create: null,
              update: null,
              builder: (ctx, authData, previousData) {
                //  print(authData.isAuth);
                return VoterProvider(authData.authNic);
              }
              ),
        ],
        child: Consumer<AuthProvider>(
          builder: (ctx, authData, _) {
            return MaterialApp(
              routes: {
                ManageVoterScreen.routeName: (ctx) => ManageVoterScreen(),
                VoterAuthScreen.routeName: (ctx) => VoterAuthScreen(),
                VoterDetailScreen.routeName: (ctx) => VoterDetailScreen(),
                OtpVerificationScreen.routeName:(ctx)=>OtpVerificationScreen()
              },
              home:authData.checkauthNic?VoterDetailScreen(): AdminControlScreen(),
            );
          },
        ));
  }
}
