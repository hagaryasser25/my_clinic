import 'package:flutter/cupertino.dart';

class Centers {
  Centers({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? uid,
    String? address,
    String? available,
    String? imageUrl,
  }) {
    _id = id;
    _email = email;
    _name = name;
    _password = password;
    _phoneNumber = phoneNumber;
    _uid = uid;
    _address = address;
    _available = available;
    _imageUrl = imageUrl;
  }

  Centers.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _name = json['name'];
    _password = json['password'];
    _phoneNumber = json['phoneNumber'];
    _uid = json['uid'];
    _address = json['address'];
    _available = json['available'];
    _imageUrl = json['imageUrl'];
  }

  String? _id;
  String? _email;
  String? _name;
  String? _password;
  String? _phoneNumber;
  String? _uid;
  String? _address;
  String? _available;
  String? _imageUrl;

  String? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get password => _password;
  String? get phoneNumber => _phoneNumber;
  String? get uid => _uid;
  String? get address => _address;
  String? get available => _available;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['password'] = _password;
    map['phoneNumber'] = _phoneNumber;
    map['uid'] = _uid;
    map['available'] = _available;
    map['address'] = _address;
    map['imageUrl'] = _imageUrl;

    return map;
  }
}