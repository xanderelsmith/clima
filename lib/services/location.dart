import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    getNewPosition() async {
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        permission = await Geolocator.requestPermission();
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          SystemNavigator.pop();
          if (permission == LocationPermission.denied) {
            do {
              permission = await Geolocator.requestPermission();
            } while (permission == LocationPermission.denied);
            // Permissions are denied, next time you could try
            // requesting permissions again (this is also where
            // Android's shouldShowRequestPermissionRationale
            // returned true. According to Android guidelines
            // your App should show an explanatory UI now.
            // return Future.error('Location permissions are denied');
          }
          if (permission == LocationPermission.deniedForever) {
            // Permissions are denied forever, handle appropriately.
            // return Future.error(
            //     'Location permissions are permanently denied, we cannot request permissions.');
            SystemNavigator.pop();
          }
        }

        // return Future.error('Location services are disabled.');
      }
      // permission = await Geolocator.checkPermission();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
// When we reach here, permissions are granted and we can
// // continue accessing the position of the device.

      return position;
    }

    var position = await getNewPosition();
    return position;
  }

// 6b653f39e64ebbb23aa5c2cfa9e3f360  my api key
// 'api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}'
}
