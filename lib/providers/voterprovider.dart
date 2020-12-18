import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/voter.dart';
import '../providers/authprovider.dart';

class VoterProvider with ChangeNotifier {
  List<Voter> _voterData = [];
  List<Voter> get voterItems {
    return [..._voterData];
  }

  final String nicNumber;
  VoterProvider(this.nicNumber);
  Future<void> signupVoter(
      String nicNumber, String mobileNumber, String userId, var date) async {
    const url = 'https://election-system-database.firebaseio.com/auth.json';
    try {
      final reponseData = await http.post(url,
          body: json.encode({
            'VoterId': userId,
            'VoterNicNumber': nicNumber,
            'VoterMobileNumber': mobileNumber,
            'VoterExpiryDate': date
          }));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> logoutVoterDetail() async {
    // _voterData = [];
    notifyListeners();
  }

  Future<void> fetchVoter() async {
    print('we get voter id ' + nicNumber);
    // final url =
    //     'https://election-system-database.firebaseio.com/voters/$voterId.json';
    final url =
        'https://election-system-database.firebaseio.com/voters.json?&orderBy="VoterNicNumber"&equalTo="$nicNumber"';
    try {
      final responseData = await http.get(url);
      final extractedData =await json.decode(responseData.body) as Map<String, dynamic>;
      print(json.decode(responseData.body));
      print(extractedData);
      // final List<Voter> loadData = [];
      extractedData.forEach((key, value) {
        _voterData.add(Voter(
            voterId: key,
            voterNicNumber: value['VoterNicNumber'],
            voterName: value['VoterName'],
            voterMobileNumber: value['VoterMobileNumber'],
            voterAddress: value['VoterAddress'],
            voterHalkaNumber: value['VoterHalkaNumber'],
            nationalAssemblyVoteCast: value['NationalAssemblyVoterCast'],
            provincialAssemblyVoteCast: value['ProvincialAssemblyVoterCast']));
      });
      print("hhhhhhhhhh");
      print(_voterData);
      // voterData = loadData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> registerVoter(Voter voter) async {
    const url = 'https://election-system-database.firebaseio.com/voters.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'VoterName': voter.voterName,
            'VoterNicNumber': voter.voterNicNumber,
            'VoterMobileNumber': voter.voterMobileNumber,
            'VoterAddress': voter.voterAddress,
            'VoterHalkaNumber': voter.voterHalkaNumber,
            'ProvincialAssemblyVoteCast': voter.provincialAssemblyVoteCast,
            'NationalAssemblyVoterCast': voter.nationalAssemblyVoteCast
          }));
      await signupVoter(voter.voterNicNumber, voter.voterMobileNumber,
          json.decode(response.body)['name'], DateTime.now().toIso8601String());
      _voterData.add(Voter(
          voterId: json.decode(response.body)['name'],
          voterName: voter.voterName,
          voterNicNumber: voter.voterNicNumber,
          voterMobileNumber: voter.voterMobileNumber,
          voterAddress: voter.voterAddress,
          voterHalkaNumber: voter.voterHalkaNumber));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
