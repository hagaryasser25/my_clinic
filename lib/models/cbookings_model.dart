import 'package:flutter/cupertino.dart';

class CBooking {
  CBooking({
    String? id,
    String? name,
    String? type,
    String? status,
    String? phoneNumber,
    String? date,
  }) {
    _id = id;
    _name = name;
    _type = type;
    _status = status;
    _phoneNumber = phoneNumber;
    _date = date;
  }

  CBooking.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _type = json['type'];
    _phoneNumber = json['phoneNumber'];
    _date = json['date'];
  }

  String? _id;
  String? _name;
  String? _status;
  String? _type;
  String? _phoneNumber;
  String? _date;


  String? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get type => _type;
  String? get phoneNumber => _phoneNumber;
  String? get date => _date;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['type'] = _type;
    map['phoneNumber'] = _phoneNumber;
    map['date'] = _date;
 
    return map;
  }
}