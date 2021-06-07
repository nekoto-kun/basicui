import 'package:flutter/material.dart';

String? cardLogoPath(String? type) {
  switch (type) {
    case 'visa':
      return 'assets/icons/visa.png';
    case 'mastercard':
      return 'assets/icons/mastercard-logo.png';
  }
}

Color cardColor(String color) {
  switch (color) {
    case 'dark':
      return Colors.grey[800]!;
    case 'white':
      return Colors.white;
    case 'blue':
      return Colors.blue[900]!;
    default:
      return Colors.white;
  }
}

TextStyle cardTextStyle(String color, {double opacity = 1.0}) {
  switch (color) {
    case 'dark':
      return TextStyle(color: Colors.white.withOpacity(opacity));
    case 'white':
      return TextStyle(color: Color(0xFF2E2A2A).withOpacity(opacity));
    case 'blue':
      return TextStyle(color: Colors.white.withOpacity(opacity));
    default:
      return TextStyle(color: Color(0xFF2E2A2A).withOpacity(opacity));
  }
}
