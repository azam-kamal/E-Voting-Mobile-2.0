import 'package:flutter/foundation.dart';

class Voter {
  final int voterId;
  final String voterHalkaLocationMarkerId;
  final String voterName;
  final String voterNicNumber;
  final String voterMobileNumber;
  final String voterAddress;
  final String voterHalkaNumber;
  final String votercityName;
  final String voterProvince;
  final double voterHalkaLocationLongitude;
  final double voterHalkaLocationLatitude;

  bool provincialAssemblyVoteCast;
  bool nationalAssemblyVoteCast;
  Voter(
      {@required this.voterId,
      @required this.voterHalkaLocationMarkerId,
      @required this.voterName,
      @required this.voterNicNumber,
      @required this.voterMobileNumber,
      @required this.voterAddress,
      @required this.voterHalkaNumber,
      @required this.votercityName,
      @required this.voterProvince,
      @required this.voterHalkaLocationLongitude,
      @required this.voterHalkaLocationLatitude,
      this.provincialAssemblyVoteCast = false,
      this.nationalAssemblyVoteCast = false});
}
