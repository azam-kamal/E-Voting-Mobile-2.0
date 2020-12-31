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
    _voterData = [];
    notifyListeners();
  }

  Future<void> fetchVoter() async {
    print('we get voter id' + nicNumber);
    // final url =
    //     'https://election-system-database.firebaseio.com/voters/$voterId.json';
    final url =
        'https://election-system-database.firebaseio.com/voters.json?&orderBy="VoterNicNumber"&equalTo="$nicNumber"';
    try {
      final responseData = await http.get(url);
      final extractedData =
          await json.decode(responseData.body) as Map<String, dynamic>;

      print(json.decode(responseData.body));
      // final List<Voter> loadData = [];
      extractedData.forEach((key, value) {
        _voterData.add(Voter(
            voterId: key,
            voterHalkaLocationMarkerId: value['VoterHalkaLocationMarkerId'],
            votercityName: value['VoterCity'],
            voterProvince: value['VoterProvince'],
            voterNicNumber: value['VoterNicNumber'],
            voterName: value['VoterName'],
            voterMobileNumber: value['VoterMobileNumber'],
            voterAddress: value['VoterAddress'],
            voterHalkaNumber: value['VoterHalkaNumber'],
            nationalAssemblyVoteCast: value['NationalAssemblyVoteCast'],
            provincialAssemblyVoteCast: value['ProvincialAssemblyVoteCast'],
            voterHalkaLocationLongitude: double.parse(value['Longitude']),
            voterHalkaLocationLatitude: double.parse(value['Latitude'])));
      });
      // voterData = loadData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> registerVoter(
      Voter voter, String markerID, String longitude, String latitude) async {
    const url = 'https://election-system-database.firebaseio.com/voters.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'VoterName': voter.voterName,
            'VoterHalkaLocationMarkerId': markerID,
            'VoterCity': voter.votercityName,
            'VoterProvince': voter.voterProvince,
            'VoterNicNumber': voter.voterNicNumber,
            'VoterMobileNumber': voter.voterMobileNumber,
            'VoterAddress': voter.voterAddress,
            'VoterHalkaNumber': voter.voterHalkaNumber,
            'ProvincialAssemblyVoteCast': voter.provincialAssemblyVoteCast,
            'NationalAssemblyVoterCast': voter.nationalAssemblyVoteCast,
            'Longitude': longitude,
            'Latitude': latitude
          }));
      await signupVoter(voter.voterNicNumber, voter.voterMobileNumber,
          json.decode(response.body)['name'], DateTime.now().toIso8601String());
      _voterData.add(Voter(
          voterId: json.decode(response.body)['name'],
          voterHalkaLocationMarkerId: markerID,
          votercityName: voter.votercityName,
          voterProvince: voter.voterProvince,
          voterName: voter.voterName,
          voterNicNumber: voter.voterNicNumber,
          voterMobileNumber: voter.voterMobileNumber,
          voterAddress: voter.voterAddress,
          voterHalkaNumber: voter.voterHalkaNumber,
          voterHalkaLocationLongitude: double.parse(longitude),
          voterHalkaLocationLatitude: double.parse(latitude)));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
