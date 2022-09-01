import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weitherapp/constans/api.dart';
import 'package:weitherapp/pages/city_page.dart';
import 'package:http/http.dart' as http;
import 'package:weitherapp/utilt/weather_page.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _cityName = "";
  String _celcius = "";
  String _description = "";
  String _icon = "";
  bool _isLoading = false;
  @override
  void initState() {
    showWeatherloc();
    super.initState();
  }

  Future<void> showWeatherloc() async {
    final position = await getLocation();
    // print("posit latitude ===> ${position.latitude}");
    // print("posit longitude ===> ${position.longitude}");

    await getCurrentWeather(position);
    setState(() {
      _isLoading = false;
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getCurrentWeather(Position coorentposition) async {
    final client = http.Client();
    try {
      // Uri uri = Uri.parse(
      //     'https://api.openweathermap.org/data/2.5/weather?lat=40.549896235&lon=72.7928652139&appid=bd48042502f8117a5c374a42be4ca80a');

      Uri uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${coorentposition.latitude}35&lon=${coorentposition.longitude}139&appid=$api');
      final response = await client.get(uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        final _data = jsonDecode(body) as Map<String, dynamic>;
        _cityName = _data["name"];
        final kelvin = _data['main']['temp'] as double;
        _celcius = WeatherappUtilts.calculateWeather(kelvin);

        _description = WeatherappUtilts.getDescription(int.parse(_celcius));
        _icon = WeatherappUtilts.getWeatherIcon(kelvin);

        log('cityName===>  $_cityName');
        log('celvin===>  $kelvin');
        log('celsuis===>  $_celcius');
      }
      setState(() {});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getCityWeather(String cityName) async {
    final client = http.Client();

    try {
      Uri uri = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$api");
      final joop = await client.get(uri);

      if (joop.statusCode == 200 || joop.statusCode == 201) {
        final _datata = jsonDecode(joop.body) as Map<String, dynamic>;
        _cityName = _datata['name'];
        final kelvin = _datata['main']['temp'] as double;

        _celcius = WeatherappUtilts.calculateWeather(kelvin);
        _description = WeatherappUtilts.getDescription(int.parse(_celcius));
        _icon = WeatherappUtilts.getWeatherIcon(kelvin);
        log('joop ===> ${joop.body}');
      }
      setState(() {
        _isLoading = false;
      });
    } catch (katany) {
      setState(() {
        _isLoading = false;
      });
      throw Exception(katany);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Icon(
            Icons.navigation_rounded,
            size: 60,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CityPage()),
                  );
                  getCityWeather(result);
                  setState(() {});
                },
                child: const Icon(Icons.location_city, size: 60)),
          )
        ],
      ),
      body: Stack(children: [
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpeg'),
                    fit: BoxFit.cover)),
            child: null),
        Container(
          decoration: const BoxDecoration(color: Colors.black38),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 190),
                child: Text(
                  '$_celcius\u00B0 $_icon',
                  style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Text(
                _description,
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
              Text(
                _cityName,
                style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
