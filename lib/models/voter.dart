import 'package:flutter/foundation.dart';

class Voter {
  final int voterId;
  final int pollingStationId;
  final String voterName;
  final String voterNicNumber;
  final String voterMobileNumber;
  final String voterAddress;
  final String voterPollingStationNumber;
  final String votercityName;
  final String voterProvince;
  final double voterPollingStationLocationLongitude;
  final double voterPollingStationLocationLatitude;
  final int provincialAssemblyVoteCast;
  final int  nationalAssemblyVoteCast;
  Voter(
      {@required this.voterId,
      @required this.pollingStationId,
      @required this.voterName,
      @required this.voterNicNumber,
      @required this.voterMobileNumber,
      @required this.voterAddress,
      @required this.voterPollingStationNumber,
      @required this.votercityName,
      @required this.voterProvince,
      @required this.voterPollingStationLocationLongitude,
      @required this.voterPollingStationLocationLatitude,
      @required  this.provincialAssemblyVoteCast ,
      @required  this.nationalAssemblyVoteCast });
}
