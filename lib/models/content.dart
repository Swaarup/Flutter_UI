import 'package:flutter/material.dart';

class Content {
  String _title;
  String _subtitle;
  String _subtitle2;

  set title(String value) {
    _title = value;
  }

  String get title => _title;
  bool isSelected = false;

  Content(String title, String subtitle, String subtitle2) {
    this._title = title;
    this._subtitle2 = subtitle2;
    this._subtitle = subtitle;
  }

  String get subtitle => _subtitle;

  String get subtitle2 => _subtitle2;

  set subtitle(String value) {
    _subtitle = value;
  }

  set subtitle2(String value) {
    _subtitle2 = value;
  }
}
