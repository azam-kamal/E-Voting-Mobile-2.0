import 'package:flutter/foundation.dart';

class ProvincialAssemblyCandidate {
  final String candidateId;
  final String candidateName;
  final String candidatePartyName;
  final String constituency;
  ProvincialAssemblyCandidate(
      {@required this.candidateId,
      @required this.candidateName,
      @required this.candidatePartyName,
      @required this.constituency});
}
