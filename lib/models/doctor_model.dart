import 'package:flutter/cupertino.dart';

class Doctor {
  Doctor({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? uid,
    String? degree,
    String? speciality,
    String? fees,
  }) {
    _id = id;
    _email = email;
    _name = name;
    _password = password;
    _phoneNumber = phoneNumber;
    _uid = uid;
    _degree = degree;
    _speciality = speciality;
    _fees = fees;
  }

  Doctor.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _name = json['name'];
    _password = json['password'];
    _phoneNumber = json['phoneNumber'];
    _uid = json['uid'];
    _degree = json['degree'];
    _speciality = json['speciality'];
    _fees = json['fees'];
  }

  String? _id;
  String? _email;
  String? _name;
  String? _password;
  String? _phoneNumber;
  String? _uid;
  String? _degree;
  String? _speciality;
  String? _fees;

  String? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get password => _password;
  String? get phoneNumber => _phoneNumber;
  String? get uid => _uid;
  String? get degree => _degree;
  String? get speciality => _speciality;
  String? get fees => _fees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['password'] = _password;
    map['phoneNumber'] = _phoneNumber;
    map['uid'] = _uid;
    map['speciality'] = _speciality;
    map['degree'] = _degree;
    map['fees'] = _fees;

    return map;
  }
}
