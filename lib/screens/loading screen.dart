import 'dart:convert';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    newData();
  }

  void newData() async {
    var weatherData = await WeatherModel().getLocationData();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LocationScreen(
              locationWeather: weatherData,
            )));
  }

  @override
  showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
          'No valid internet connection!\nrestart when there\'\'s internet connection'),
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDualRing(
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}
