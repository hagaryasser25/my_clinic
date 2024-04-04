import 'package:flutter/cupertino.dart';

class Donation {
  Donation({
    String? id,
    String? name,
    String? type,
    String? nationalId,
    String? phoneNumber,
    String? date,
  }) {
    _id = id;
    _name = name;
    _type = type;
    _nationalId = nationalId;
    _phoneNumber = phoneNumber;
    _date = date;
  }

  Donation.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nationalId = json['nationalId'];
    _type = json['type'];
    _phoneNumber = json['phoneNumber'];
    _date = json['date'];
  }

  String? _id;
  String? _name;
  String? _nationalId;
  String? _type;
  String? _phoneNumber;
  String? _date;


  String? get id => _id;
  String? get name => _name;
  String? get nationalId => _nationalId;
  String? get type => _type;
  String? get phoneNumber => _phoneNumber;
  String? get date => _date;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['nationalId'] = _nationalId;
    map['type'] = _type;
    map['phoneNumber'] = _phoneNumber;
    map['date'] = _date;
 
    return map;
  }
}