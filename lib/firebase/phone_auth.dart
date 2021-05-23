// import 'package:firebase_auth/firebase_auth.dart';


// User _firebaseUser;
// String _status;

//   AuthCredential _phoneAuthCredential;
//   String _verificationId;
//   int _code;

// // void _handleError(e) {
// //     print(e.message);
// //     setState(() {
// //       _status += e.message + '\n';
// //     });
// //   }

  
//   /// phoneAuthentication works this way:
//   ///     AuthCredential is the only thing that is used to authenticate the user
//   ///     OTP is only used to get AuthCrendential after which we need to authenticate with that AuthCredential
//   ///
//   /// 1. User gives the phoneNumber
//   /// 2. Firebase sends OTP if no errors occur
//   /// 3. If the phoneNumber is not in the device running the app
//   ///       We have to first ask the OTP and get `AuthCredential`(`_phoneAuthCredential`)
//   ///       Next we can use that `AuthCredential` to signIn
//   ///    Else if user provided SIM phoneNumber is in the device running the app,
//   ///       We can signIn without the OTP.
//   ///       because the `verificationCompleted` callback gives the `AuthCredential`(`_phoneAuthCredential`) needed to signIn
//   Future<void> _login() async {
//     /// This method is used to login the user
//     /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
//     /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)
//     try {
//       await FirebaseAuth.instance.signInWithCredential((_phoneAuthCredential)).
//           .then((UserCredential authRes) {
//         _firebaseUser = authRes.user;
//         print(_firebaseUser.toString());
//       }).catchError((e) => _handleError(e));
//       setState(() {
//         _status += 'Signed In\n';
//       });
//     } catch (e) {
//       _handleError(e);
//     }
//   }

//   Future<void> _logout() async {
//     /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
//     try {
//       // signout code
//       await FirebaseAuth.instance.signOut();
//       _firebaseUser = null;
//       setState(() {
//         _status += 'Signed out\n';
//       });
//     } catch (e) {
//       _handleError(e);
//     }
//   }

//   Future<void> _submitPhoneNumber() async {
//     /// NOTE: Either append your phone number country code or add in the code itself
//     /// Since I'm in India we use "+91 " as prefix `phoneNumber`
//     String phoneNumber = "+91 " + _phoneNumberController.text.toString().trim();
//     print(phoneNumber);

//     /// The below functions are the callbacks, separated so as to make code more redable
//     void verificationCompleted(AuthCredential phoneAuthCredential) {
//       print('verificationCompleted');
//       setState(() {
//         _status += 'verificationCompleted\n';
//       });
//       this._phoneAuthCredential = phoneAuthCredential;
//       print(phoneAuthCredential);
//     }

//     void verificationFailed(FirebaseAuthException error) {
//       print('verificationFailed');
//       _handleError(error);
//     }

//     void codeSent(String verificationId, [int code]) {
//       print('codeSent');
//       _verificationId = verificationId;
//       print(verificationId);
//       _code = code;
//       print(code.toString());
//       setState(() {
//         _status += 'Code Sent\n';
//       });
//     }

//     void codeAutoRetrievalTimeout(String verificationId) {
//       print('codeAutoRetrievalTimeout');
//       setState(() {
//         _status += 'codeAutoRetrievalTimeout\n';
//       });
//       print(verificationId);
//     }

//     await FirebaseAuth.instance.verifyPhoneNumber(
//       /// Make sure to prefix with your country code
//       phoneNumber: phoneNumber,

//       /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
//       timeout: Duration(milliseconds: 10000),

//       /// If the SIM (with phoneNumber) is in the current device this function is called.
//       /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
//       /// When this function is called there is no need to enter the OTP, you can click on Login button to sigin directly as the device is now verified
//       verificationCompleted: verificationCompleted,

//       /// Called when the verification is failed
//       verificationFailed: verificationFailed,

//       /// This is called after the OTP is sent. Gives a `verificationId` and `code`
//       codeSent: codeSent,

//       /// After automatic code retrival `tmeout` this function is called
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     ); // All the callbacks are above
//   }

//   void _submitOTP(otp) {
//     /// get the `smsCode` from the user
//     /// when used different phoneNumber other than the current (running) device
//     /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
//     _phoneAuthCredential = PhoneAuthProvider.credential(
//         verificationId: _verificationId, smsCode: otp);

//     _login();
//   }

//   // void _reset() {
//   //   _phoneNumberController.clear();
//   //   _otpController.clear();
//   //   setState(() {
//   //     _status = "";
//   //   });
//   // }

//   // void _displayUser() {
//   //   setState(() {
//   //     _status += _firebaseUser.toString() + '\n';
//   //   });
//   // }
