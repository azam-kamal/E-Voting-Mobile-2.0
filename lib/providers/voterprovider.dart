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
          .post('https://a570b23061dd.ngrok.io/voters/register', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'voter_name': voter.voterName,
        'voter_nic': voter.voterNicNumber,
        'voter_mobile_number': voter.voterMobileNumber,
        'voter_province': voter.voterProvince,
        'voter_city': voter.votercityName,
        'voter_address': voter.voterAddress,
        'voter_halka_number': voter.voterPollingStationNumber,
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
          .post('https://a570b23061dd.ngrok.io/voters/login', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'voter_nic': voterNic,
        'voter_mobile_number': voterEmail
      });
      print(response.body);
      // print( json.decode(response.body)['voterId']);
      _voterData.add(Voter(
          voterId: json.decode(response.body)['voterId'],
          pollingStationId: json.decode(response.body)['pollingStationId'],
          voterName: json.decode(response.body)['voterName'],
          voterNicNumber: json.decode(response.body)['voterNic'],
          voterMobileNumber: json.decode(response.body)['voterMobileNumber'],
          voterAddress: json.decode(response.body)['voterProvince'],
          voterPollingStationNumber: json.decode(response.body)['voterCity'],
          votercityName: json.decode(response.body)['voterHalkaNumber'],
          voterProvince: json.decode(response.body)['voterProvince'],
          nationalAssemblyVoteCast:
              json.decode(response.body)['voter_national_assembly_vote_cast'],
          provincialAssemblyVoteCast:
              json.decode(response.body)['voter_provincial_assembly_vote_cast'],
          voterPollingStationLocationLongitude:
              double.parse(json.decode(response.body)['longitude']),
          voterPollingStationLocationLatitude:
              double.parse(json.decode(response.body)['latitude'])));
      // print(json.decode(response.body));
      // print(data);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }
}
