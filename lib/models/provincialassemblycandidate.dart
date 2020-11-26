import 'package:flutter/foundation.dart';

class NationalAssemblyCandidate {
  final String candidateId;
  final String candidateName;
  final String candidatePartyName;
  final String constituency;
  NationalAssemblyCandidate(
      {@required this.candidateId,
      @required this.candidateName,
      @required this.candidatePartyName,
      @required this.constituency});
}
