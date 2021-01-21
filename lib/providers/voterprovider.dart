import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/voter.dart';

class VoterProvider with ChangeNotifier {
  List<Voter> _voterData = [];
  List<Voter> get voterItems {
    return [..._voterData];
  }

  // final String nicNumber;
  // VoterProvider(this.nicNumber);
  // Future<void> signupVoter(
  //     String nicNumber, String mobileNumber, String userId, var date) async {
  //   const url = 'https://election-system-database.firebaseio.com/auth.json';
  //   try {
  //     final reponseData = await http.post(url,
  //         body: json.encode({
  //           'VoterId': userId,
  //           'VoterNicNumber': nicNumber,
  //           'VoterMobileNumber': mobileNumber,
  //           'VoterExpiryDate': date
  //         }));
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<void> logoutVoterDetail() async {
    _voterData = [];
    notifyListeners();
  }

  // Future<void> fetchVoter() async {
  //   print('we get voter id' + nicNumber);
  //   // final url =
  //   //     'https://election-system-database.firebaseio.com/voters/$voterId.json';
  //   final url =
  //       'https://election-system-database.firebaseio.com/voters.json?&orderBy="VoterNicNumber"&equalTo="$nicNumber"';
  //   try {
  //     final responseData = await http.get(url);
  //     final extractedData =
  //         await json.decode(responseData.body) as Map<String, dynamic>;

  //     print(json.decode(responseData.body));
  //     // final List<Voter> loadData = [];
  //     extractedData.forEach((key, value) {
  //       _voterData.add(Voter(
  //           voterId: key,
  //           voterHalkaLocationMarkerId: value['VoterHalkaLocationMarkerId'],
  //           votercityName: value['VoterCity'],
  //           voterProvince: value['VoterProvince'],
  //           voterNicNumber: value['VoterNicNumber'],
  //           voterName: value['VoterName'],
  //           voterMobileNumber: value['VoterMobileNumber'],
  //           voterAddress: value['VoterAddress'],
  //           voterHalkaNumber: value['VoterHalkaNumber'],
  //           nationalAssemblyVoteCast: value['NationalAssemblyVoteCast'],
  //           provincialAssemblyVoteCast: value['ProvincialAssemblyVoteCast'],
  //           voterHalkaLocationLongitude: double.parse(value['Longitude']),
  //           voterHalkaLocationLatitude: double.parse(value['Latitude'])));
  //     });
  //     // voterData = loadData;
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<void> registerVoter(
      Voter voter, String markerID, String longitude, String latitude) async {
    try {
      final response = await http
          .post('http://192.168.1.105:3000/voters/register', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'voter_name': voter.voterName,
        'voter_nic': voter.voterNicNumber,
        'voter_mobile_number': voter.voterMobileNumber,
        'voter_province': voter.voterProvince,
        'voter_city': voter.votercityName,
        'voter_address': voter.voterAddress,
        'voter_halka_number': voter.voterHalkaNumber,
        'voter_national_assembly_vote_cast': '0',
        'voter_provincial_assembly_vote_cast': '0',
        'longitude': longitude,
        'latitude': latitude
      });

      // _voterData.add(Voter(
      //     voterId: json.decode(response.body)['name'],
      //     voterHalkaLocationMarkerId: markerID,
      //     votercityName: voter.votercityName,
      //     voterProvince: voter.voterProvince,
      //     voterName: voter.voterName,
      //     voterNicNumber: voter.voterNicNumber,
      //     voterMobileNumber: voter.voterMobileNumber,
      //     voterAddress: voter.voterAddress,
      //     voterHalkaNumber: voter.voterHalkaNumber,
      //     voterHalkaLocationLongitude: double.parse(longitude),
      //     voterHalkaLocationLatitude: double.parse(latitude)));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> loginVoter(String voterNic, String voterEmail) async {
    try {
      final response = await http
          .post('http://192.168.1.105:3000/voters/login', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'voter_nic': voterNic,
        'voter_mobile_number': voterEmail
      });
      _voterData.add(Voter(
          voterId: json.decode(response.body)['voterData']['voterId'],
          voterHalkaLocationMarkerId: 'M1',
          voterName: json.decode(response.body)['voterData']['voterName'],
          voterNicNumber: json.decode(response.body)['voterData']['voterNic'],
          voterMobileNumber: json.decode(response.body)['voterData']
              ['voterMobileNumber'],
          voterAddress: json.decode(response.body)['voterData']
              ['voterProvince'],
          voterHalkaNumber: json.decode(response.body)['voterData']
              ['voterCity'],
          votercityName: json.decode(response.body)['voterData']
              ['voterHalkaNumber'],
          voterProvince: json.decode(response.body)['voterData']
              ['voterProvince'],
          nationalAssemblyVoteCast: false,
          provincialAssemblyVoteCast: false,
          voterHalkaLocationLongitude: double.parse(
              json.decode(response.body)['voterData']['longitude']),
          voterHalkaLocationLatitude: double.parse(
              json.decode(response.body)['voterData']['latitude'])));
       print(json.decode(response.body));
      // print(data);
    } catch (error) {
      print(error);
    }
  }
}
