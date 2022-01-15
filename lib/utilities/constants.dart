import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/loading screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'YanoneKaffeesatz',
  fontSize: 100.0,
);
const kMessageTextStyle = TextStyle(
  fontFamily: 'YanoneKaffeesatz',
  fontSize: 60.0,
);
const kButtonTextStyle = TextStyle(
  fontSize: 40.0,
  fontFamily: 'YanoneKaffeesatz',
);
const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const String kapiKey = 'ce35b4e381eef03cba95e49e42c1e227';

Location location = Location();
const spinkit = SpinKitWave(
  color: Colors.red,
  duration: Duration(milliseconds: 400),
);

const kTextFieldInputDecoration = InputDecoration(
    hintText: 'Enter city name',
    hintStyle: TextStyle(fontSize: 20),
    contentPadding: EdgeInsets.all(5),
    icon: Icon(Icons.location_city),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: InputBorder.none);
var openweathermapsurl = 'http://api.openweathermap.org/data/2.5/weather';
