import 'package:flutter/material.dart';

import 'dart:convert';


class Biomarker {
  final int? id;
  final String date;
  final String? info;
  final String? color;
  final String? value;
  final String? symbol;
  final String? insight;
  final String? category;

  Biomarker({
    required this.id,
    required this.date,
    required this.info,
    required this.color,
    required this.value,
    required this.symbol,
    required this.insight,
    required this.category,
  });
  factory Biomarker.fromJson(Map<String, dynamic> json) => Biomarker(
        id: json["id"],
        date: json["date"] ?? "",
        info: json["info"] ?? "",
        color: json["color"] ?? "#b74093",
        value: json["value"] ?? "",
        symbol: json["symbol"] ?? "",
        insight: json["insight"] ?? "",
        category: json["value"] ?? "",
      );
