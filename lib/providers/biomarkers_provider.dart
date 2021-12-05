import 'dart:io';

import 'package:biomarker_app/Model/biomarker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BioMarkerProvider with ChangeNotifier {
  List<Biomarker> bioMarkers = [];

  bool isOnline = true;

  void toggelIsOnline() {
    isOnline = !isOnline;
    notifyListeners();
  }

  Future<void> fetchBioMarkers() async {
    final url = "https://retoolapi.dev/hZZ5j8/biomarkers";
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        String jsonString = res.body;
        var jsonData = jsonDecode(jsonString);
        List<Biomarker> loadedData = [];
        for (var item in jsonData) {
          loadedData.add(Biomarker.fromJson(item));
        }
        isOnline = true;
        bioMarkers = loadedData;
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }
}
