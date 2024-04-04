import 'package:flutter/cupertino.dart';

class DBooking {
  DBooking({
    String? id,
    String? name,
    String? complain,
    String? status,
    String? phoneNumber,
    String? date,
  }) {
    _id = id;
    _name = name;
    _complain = complain;
    _status = status;
    _phoneNumber = phoneNumber;
    _date = date;
  }

  DBooking.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _complain = json['complain'];
    _phoneNumber = json['phoneNumber'];
    _date = json['date'];
  }

  String? _id;
  String? _name;
  String? _status;
  String? _complain;
  String? _phoneNumber;
  String? _date;


  String? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get complain => _complain;
  String? get phoneNumber => _phoneNumber;
  String? get date => _date;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['complain'] = _complain;
    map['phoneNumber'] = _phoneNumber;
    map['date'] = _date;
 
    return map;
  }
}