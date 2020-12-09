import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class RouteProviders with ChangeNotifier {
  User _user;

  Future<void> fetchAndSetUser() async {
    var url = "https://inaclick.online/mtc/account/checkCredentials";
    try {
      final response = await http.post(url,
          body: {"name": "bola_d", "password": "1234", "deviceToken": ""},
          headers: {"Accept": "application/json"});
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      _user = User.fromJson(responseData["InnerData"]["user"]);
      print("------------------------------------------");
    } catch (error) {
      print(error.toString());
    }
  }

  Polyline getRoute() {
    List<LatLng> route = [];
    _user.bus.route.routePath.forEach((element) {
      route.add(LatLng(element.lat, element.lng));
    });
    final polyline = Polyline(
      polylineId: PolylineId("polyline_id"),
      points: route,
      consumeTapEvents: true,
      color: Colors.black,
      width: 6,
    );
    return polyline;
  }

  Future<String> fetchAboutData() async {
    String content = "";
    var url = "https://inaclick.online/mtc/aboutus/aboutUs";
    try {
      final response =
          await http.get(url, headers: {"Accept": "application/json"});
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      content = responseData["InnerData"][0]["content"];
    } catch (error) {
      return "error";
    }
    return content;
  }
}
