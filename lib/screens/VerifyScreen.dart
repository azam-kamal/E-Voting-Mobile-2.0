import 'package:E_Voting_System/providers/voterprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth_device_credentials/auth_strings.dart';
import 'package:local_auth_device_credentials/error_codes.dart';
import 'package:local_auth_device_credentials/local_auth.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  static const routeName = '/verifyScreen';

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  bool _canCheckBiometrics;

  List<BiometricType> _availableBiometrics;

  String _authorized = 'Not Authorized';

  bool _isAuthenticating = false;

  bool _isSupported;
  String party1 = "loading...";
  String party2 = "loading...";
  String candidate1 = "loading...";
  String candidate2 = "loading...";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    auth
        .isDeviceSupported()
        .then((isSupported) => setState(() => _isSupported = isSupported));
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() => _canCheckBiometrics = canCheckBiometrics);
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() => _availableBiometrics = availableBiometrics);
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate with your Biometric to Cast Vote',
        useErrorDialogs: true,
        stickyAuth: true,
      );
      setState(() {
        isLoading = true;
        _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      });
      if (_authorized == 'Authorized') {
        await Provider.of<VoterProvider>(context, listen: false).voteToNational(
            candidate1,
            party1,
            Provider.of<VoterProvider>(context, listen: false).pollStation);
        if (Provider.of<VoterProvider>(context, listen: false).voterProvince ==
            "Sindh") {
          await Provider.of<VoterProvider>(context, listen: false).voteToSindh(
              candidate2,
              party2,
              Provider.of<VoterProvider>(context, listen: false).pollStation);
        }
        if (Provider.of<VoterProvider>(context, listen: false).voterProvince ==
            "Punjab") {
          await Provider.of<VoterProvider>(context, listen: false).voteToPunjab(
              candidate2,
              party2,
              Provider.of<VoterProvider>(context, listen: false).pollStation);
        }
        if (Provider.of<VoterProvider>(context, listen: false).voterProvince ==
            "Baluchistan") {
          await Provider.of<VoterProvider>(context, listen: false)
              .voteToBaluchistan(
                  candidate2,
                  party2,
                  Provider.of<VoterProvider>(context, listen: false)
                      .pollStation);
        }
        if (Provider.of<VoterProvider>(context, listen: false).voterProvince ==
            "KPK") {
          await Provider.of<VoterProvider>(context, listen: false).voteToKPK(
              candidate2,
              party2,
              Provider.of<VoterProvider>(context, listen: false).pollStation);
        }
      }
      if (_authorized == 'Not Authorized') {
        print("Error occurred while casting your vote");
      }
      setState(() {
        isLoading = false;
      });
    } on PlatformException catch (e) {
      setState(() => _authorized = e.message);
    } finally {
      setState(() => _isAuthenticating = false);
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Use biometrics to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      });
    } on PlatformException catch (e) {
      setState(() => _authorized = e.message);
    } finally {
      setState(() => _isAuthenticating = false);
    }
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Vote Cast"),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color.fromRGBO(24, 44, 37, 1),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Authenticate to Cast Your Vote!",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 60),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                          party1 =
                              Provider.of<VoterProvider>(context, listen: false)
                                  .party1;
                          print(party1);
                          party2 =
                              Provider.of<VoterProvider>(context, listen: false)
                                  .party2;
                          print(party2);
                          candidate1 =
                              Provider.of<VoterProvider>(context, listen: false)
                                  .candidate1;
                          print(candidate1);
                          candidate2 =
                              Provider.of<VoterProvider>(context, listen: false)
                                  .candidate2;
                          isLoading = false;
                        });

                        _authenticate();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 35,
                        child: FittedBox(
                            child: Image.asset('assets/images/finger.png')),
                      ),
                    ),
                    SizedBox(height: 30),
                    _authorized == "Authorized"
                        ? SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Vote has being casted!",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green[900]),
                                ),
                                Card(
                                    elevation: 6,
                                    child: Column(
                                      children: [
                                        Text(
                                          "National Assembly ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.green[900]),
                                        ),
                                        Text("Candidate: " + candidate1,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black)),
                                        Text('Party: ' + party1,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black))
                                      ],
                                    )),
                                Card(
                                    elevation: 6,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Provincial Assembly ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.green[900]),
                                        ),
                                        Text("Candidate: " + candidate2,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black)),
                                        Text('Party: ' + party2,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black))
                                      ],
                                    ))
                              ],
                            ),
                          )
                        : Container()
                  ],
                ))),
    );
  }
}
