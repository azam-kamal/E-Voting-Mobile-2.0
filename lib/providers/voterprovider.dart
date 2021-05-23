import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/voter.dart';
import '../firebase/database.dart';

class VoterProvider with ChangeNotifier {
  String baseIp;
  String party1;
  String party2;
  String candidate1;
  String candidate2;
  String pollStation;
  String voteCast;
  String voterProvince;

  List<Voter> _voterData = [];
  List<Voter> get voterItems {
    return [..._voterData];
  }
  /////Valuess uthani hen!!!!!!!!

  dataForNational(String val, String cand) {
    //String poll = pollStation;
    party1 = val;
    candidate1 = cand;
  }

  dataForProvincial(String val, String cand) {
    //String poll = pollStation;
    party2 = val;
    candidate2 = cand;
  }

  Future<String> getIp() async {
    DocumentSnapshot sp = await DatabaseMethods().getIP();
    baseIp = sp.data["ip"];
    return baseIp;
  }

  Future<void> logoutVoterDetail() async {
    _voterData = [];
    notifyListeners();
  }

  Future<void> registerVoter(
      Voter voter, String markerID, String longitude, String latitude) async {
    baseIp = await getIp();
    try {
      final response = await http.post('$baseIp/voters/register', headers: {
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
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> loginVoter(String voterNic, String voterEmail) async {
    baseIp = await getIp();
    try {
      final response = await http.post('$baseIp/voters/login', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'voter_nic': voterNic,
        'voter_mobile_number': voterEmail
      });
      print(response.body);
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

      pollStation =
          json.decode(response.body)['voterPollingStationNumber'].toString();
      voteCast = json
          .decode(response.body)['voterNationalAssemblyVoteCast']
          .toString();
      voterProvince = json.decode(response.body)['voterProvince'].toString();
      print(pollStation);
      print(voteCast);
      //voteCast = int.parse(voteCast);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  Future<String> getCandidate1(String poll, String party, String rep) async {
    print(poll);
    print(party);
    print(rep);
    print("CHECKKKK");
    baseIp = await getIp();
    try {
      final response =
          await http.post('$baseIp/voters/voteNationalAssembly', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'pollingStationNumber': poll,
        'party': party,
        'representation': rep
      });
      print(response.body);

      return json.decode(response.body)['candidate_name'].toString();
      //voteCast = int.parse(voteCast);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  Future<String> getCandidate2(String poll, String party, String rep) async {
    print(poll);
    print(party);
    print(rep);
    print("CHECKKKK");
    baseIp = await getIp();
    try {
      final response =
          await http.post('$baseIp/voters/voteProvincialAssembly', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'pollingStationNumber': poll,
        'party': party,
        'representation': rep
      });
      print(response.body);

      return json.decode(response.body)['candidate_name'].toString();
      //voteCast = int.parse(voteCast);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }

////////////////////////////////////////////////////////////////////////////
  Future<String> voteToNational(String cand, String party, String poll) async {
  
    baseIp = await getIp();
    try {
      final response =
          await http.post('$baseIp/voters/NationalAssemlyCandidateVoteRegistered', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'candidateName': cand,
        'party': party,
        'pollingStationNumber': poll
      });
      print(response.body);

      return json.decode(response.body)['candidate_name'].toString();
      //voteCast = int.parse(voteCast);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }
  Future<String> voteToSindh(String cand, String party, String poll) async {
  
    baseIp = await getIp();
    try {
      final response =
          await http.post('$baseIp/voters/voteForSindhProvince', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'candidateName': cand,
        'party': party,
        'pollingStationNumber': poll
      });
      print(response.body);

      return json.decode(response.body)['candidate_name'].toString();
      //voteCast = int.parse(voteCast);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }
  Future<String> voteToPunjab(String cand, String party, String poll) async {
  
    baseIp = await getIp();
    try {
      final response =
          await http.post('$baseIp/voters/voteForPunjabProvince', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'candidateName': cand,
        'party': party,
        'pollingStationNumber': poll
      });
      print(response.body);

      return json.decode(response.body)['candidate_name'].toString();
      //voteCast = int.parse(voteCast);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }

Future<String> voteToBaluchistan(String cand, String party, String poll) async {
  
    baseIp = await getIp();
    try {
      final response =
          await http.post('$baseIp/voters/voteForBaluchistanProvince', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'candidateName': cand,
        'party': party,
        'pollingStationNumber': poll
      });
      print(response.body);

      return json.decode(response.body)['candidate_name'].toString();
      //voteCast = int.parse(voteCast);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }
Future<String> voteToKPK(String cand, String party, String poll) async {
  
    baseIp = await getIp();
    try {
      final response =
          await http.post('$baseIp/voters/voteForKPKProvince', headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'candidateName': cand,
        'party': party,
        'pollingStationNumber': poll
      });
      print(response.body);

      return json.decode(response.body)['candidate_name'].toString();
      //voteCast = int.parse(voteCast);
    } catch (error) {
      print(error);
      throw Exception('Voter Not Exist');
    }
  }


}
