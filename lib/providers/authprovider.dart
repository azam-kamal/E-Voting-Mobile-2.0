import 'package:flutter/cupertino.dart';

import '../models/auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var voterNic;

class AuthProvider with ChangeNotifier {
  List<Auth> _authItems = [];

  List<Auth> get items {
    return [..._authItems];
  }

  String get authNic {
    print(voterNic);
    if (voterNic != null) {
      return voterNic;
    } else {
      return null;
    }
  }
  bool get checkauthNic{
    
    if(voterNic!=null){
      print('true');
      return true;
    }
    else{
      print('false');
      return false;
    }
  }

  Future<void> loginVoter(String nicNumber, String mobileNumber) async {
    print(nicNumber);
    print(mobileNumber);
    try {
      final firstUrl =
          'https://election-system-database.firebaseio.com/auth.json?&orderBy="VoterNicNumber"&equalTo="$nicNumber"';
      final secondUrl =
          'https://election-system-database.firebaseio.com/auth.json?&orderBy="VoterMobileNumber"&equalTo="$mobileNumber"';
      final getVoterDataByValidatingNic = await http.get(firstUrl);
      final getVoterNumberByValidatingNumber = await http.get(secondUrl);
      final extractDataByValidatingNic =
          json.decode(getVoterDataByValidatingNic.body);
      final extractDataByValidatingNumber =
          json.decode(getVoterNumberByValidatingNumber.body);
      var voterIdByNic;
      var voterIdByNumber;
      if (extractDataByValidatingNic != null) {
        extractDataByValidatingNic.forEach((key, value) {
          voterIdByNic = key;
        });
      }
      if (extractDataByValidatingNumber != null) {
        extractDataByValidatingNumber.forEach((key, value) {
          voterIdByNumber = key;
        });
      }
      

      if (voterIdByNic == voterIdByNumber) {
          print('Voter id by nic'+voterIdByNic);
        print('voter id by number'+voterIdByNumber);
        final getVoterData = getVoterDataByValidatingNic;
        final voterData =
            await json.decode(getVoterData.body) as Map<String, dynamic>;
        final List<Auth> auth = [];
        voterData.forEach((key, value) {
          voterNic = value['VoterNicNumber'];
          auth.add(Auth(
              uId: key,
              nic: value['VoterNicNumber'],
              phoneNumber: value['VoterMobileNumber'],
              expiryDate: DateTime.now()));
        });
        _authItems = auth;
        notifyListeners();
      } else {
        throw Exception('Invalid Nic number & Mobile Number');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<bool> MatchNicExist(String nicNumber) async {
    final url =
        'https://election-system-database.firebaseio.com/auth.json?&orderBy="VoterNicNumber"&equalTo="$nicNumber"';
    final responseData = await http.get(url);
    final loadData = json.decode(responseData.body) as Map<String, dynamic>;
    var extractNic;
    if (loadData != null) {
      loadData.forEach((key, value) {
        extractNic = value['VoterNicNumber'];
      });
      print(extractNic);
      if (extractNic != null) {
        return true;
      }
    }
    return false;
  }

  Future<bool> MatchMobileNumberExist(String mobileNumber) async {
    final url =
        'https://election-system-database.firebaseio.com/auth.json?&orderBy="VoterMobileNumber"&equalTo="$mobileNumber"';
    final responseData = await http.get(url);
    final loadData = json.decode(responseData.body) as Map<String, dynamic>;
    var extractNumber;
    if (loadData != null) {
      loadData.forEach((key, value) {
        extractNumber = value['VoterMobileNumber'];
      });
      print(extractNumber);
      if (extractNumber != null) {
        return true;
      }
    }
    return false;
  }
}
