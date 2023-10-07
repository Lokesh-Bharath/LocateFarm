import 'package:flutter/material.dart';

class L10n {

  static final all = [
    const Locale('en'),
    const Locale('te'),
    const Locale('hi')
  ];


  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return 'English';
      case 'hi':
        return 'हिंदी';
      case 'te':
        return 'తెలుగు';
      default:
        return 'English';
    }
  }
}