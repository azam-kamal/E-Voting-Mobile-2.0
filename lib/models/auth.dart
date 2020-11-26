import 'package:flutter/foundation.dart';

class Auth {
  final String uId;
  final String nic;
  final String phoneNumber;
  final DateTime expiryDate;
  Auth(
      {@required this.uId,
      @required this.nic,
      @required this.phoneNumber,
      @required this.expiryDate});
}
