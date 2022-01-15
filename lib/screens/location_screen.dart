import 'package:clima/screens/city_screens.dart';
import 'package:clima/services/weather.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/services.dart';

// ignore: use_key_in_widget_constructors
class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? cityName;
  String? weatherIcon;
  int? condition;
  int temp = 0;
  String? weatherMessage;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    print(widget.locationWeather);
    var decodedData = widget.locationWeather;

    update_ui(decodedData);
    //print(widget.locationWeather);
  }

  void update_ui(weatherdata) async {
    final Connectivity _connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        double temperature = weatherdata['main']['temp'];
        temp = temperature.toInt();
        int condition = weatherdata['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        cityName = weatherdata['name'];
        String weatherMessage = weatherModel.getMessage(temp);
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text('Exit'),
                  ),
                ],
                title: Text(
                    'There seem to be no internet connection,pls restart the app when there\'\s an active internet connection'),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/11machin-illo-jumbo-v3.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      var weatherData = await weatherModel.getLocationData();
                      update_ui(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var cityname = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      print(cityname);
                      if (cityName != null) {
                        var weatherData =
                            await weatherModel.getNewWeather(cityname);
                        update_ui(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp.toInt()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
