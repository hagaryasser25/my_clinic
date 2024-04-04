import 'package:flutter/cupertino.dart';

class Pharmacy {
  Pharmacy({
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? available,
    String? imageUrl,
  }) {
    _id = id;
    _name = name;
    _phoneNumber = phoneNumber;
    _address = address;
    _available = available;
    _imageUrl = imageUrl;
  }

  Pharmacy.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    _address = json['address'];
    _available = json['available'];
    _imageUrl = json['imageUrl'];
  }

  String? _id;
  String? _name;
  String? _phoneNumber;
  String? _address;
  String? _available;
  String? _imageUrl;

  String? get id => _id;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get available => _available;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['available'] = _available;
    map['address'] = _address;
    map['imageUrl'] = _imageUrl;

    return map;
  }
}