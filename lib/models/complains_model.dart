import 'package:flutter/cupertino.dart';

class Complains {
  Complains({
    String? id,
    String? userUid,
    String? description,
    String? userName,
    int? date,
  }) {
    _id = id;
    _userUid = userUid;
    _description = description;
    _userName = userName;
    _date = date;
  }

  Complains.fromJson(dynamic json) {
    _id = json['id'];
    _userUid = json['userUid'];
    _description = json['description'];
    _userName = json['userName'];
    _date = json['date'];
  }

  String? _id;
  String? _userUid;
  String? _description;
  String? _userName;
  int? _date;

  String? get id => _id;
  String? get userUid => _userUid;
  String? get description => _description;
  String? get userName => _userName;
  int? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userUid'] = _userUid;
    map['description'] = _description;
    map['userName'] = _userName;
    map['date'] = _date;

    return map;
  }
}