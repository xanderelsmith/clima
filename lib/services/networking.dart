import 'package:clima/services/location.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  final String url;
  NetworkHelper({required this.url});

  getData() async {
    print('getting jsondata....');
    //get information from apiweather
    final Connectivity _connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    Position position = await location.getCurrentLocation();

    if (connectivityResult != ConnectivityResult.none) {
      http.Response response = await http.get(Uri.parse(url));
      if (response.body != null) {
        print(response.statusCode);

        String data = response.body.toString();

        var decodedData = jsonDecode(data);
        if (response.statusCode == 200) {
          return decodedData;
        }
      }
    } else {
      print('json data fetching failed');
    }
  }
}
