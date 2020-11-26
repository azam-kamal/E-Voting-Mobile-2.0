import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/voter.dart';
import '../models/auth.dart';
import '../providers/authprovider.dart';
import 'package:provider/provider.dart';

class VoterProvider with ChangeNotifier {
  List<Voter> voterData = [];
  List<Voter> get voterItems {
    return [...voterData];
  }

  Future<void> signupVoter(String nicNumber, String mobileNumber, String userId,
      var date) async {
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

  Future<void> registerVoter(Voter voter) async {
    const url = 'https://election-system-database.firebaseio.com/voters.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'Voter Name': voter.voterName,
            'Voter Nic Number': voter.voterNicNumber,
            'Voter Mobile Number': voter.voterMobileNumber,
            'Voter Address': voter.voterAddress,
            'Voter Halka Number': voter.voterHalkaNumber,
            'Provincial Assembly Vote Cast': voter.provincialAssemblyVoteCast,
            'National Assembly Voter Cast': voter.nationalAssemblyVoteCast
          }));
      await signupVoter(voter.voterNicNumber, voter.voterMobileNumber,
          json.decode(response.body)['name'], DateTime.now().toIso8601String());
      voterData.add(Voter(
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
