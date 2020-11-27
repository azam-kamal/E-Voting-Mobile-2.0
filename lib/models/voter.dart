import 'package:flutter/foundation.dart';

class Voter {
  final String voterId;
  final String voterName;
  final String voterNicNumber;
  final String voterMobileNumber;
  final String voterAddress;
  final String voterHalkaNumber;
  bool provincialAssemblyVoteCast;
  bool nationalAssemblyVoteCast;
  Voter(
      {@required this.voterId,
      @required this.voterName,
      @required this.voterNicNumber,
      @required this.voterMobileNumber,
      @required this.voterAddress,
      @required this.voterHalkaNumber,
      this.provincialAssemblyVoteCast = false,
      this.nationalAssemblyVoteCast = false});
}
