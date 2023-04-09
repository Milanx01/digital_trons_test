import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const Color scaffoldColor = Colors.black;
final TextStyle normalText = GoogleFonts.poppins(
    textStyle: const TextStyle(fontSize: 16, letterSpacing: 0.8));
final TextStyle heading = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
);

String imageBasePath = 'https://image.tmdb.org/t/p/original';

String monthgenrater(String date) {
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  switch (date) {
    case "01":
      return months[0];
    case "02":
      return months[1];
    case "03":
      return months[2];
    case "04":
      return months[3];
    case "05":
      return months[4];
    case "06":
      return months[5];
    case "07":
      return months[6];
    case "08":
      return months[7];
    case "09":
      return months[8];
    case "10":
      return months[9];
    case "11":
      return months[10];
    case "12":
      return months[11];
    default:
      return date + ",";
  }
}
