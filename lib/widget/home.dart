import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/models/shared_pref.dart';
import 'package:flutter_weather/models/weather.dart';
import 'package:flutter_weather/widget/custom_drawer.dart';
import 'package:flutter_weather/widget/text_perso.dart';
import 'package:flutter_weather/widget/weather_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

const String KEY = "";

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  final urlIcon = "https://openweathermap.org/img/wn/";
  SharedPrefs prefs = SharedPrefs();

  List<String> cities = [];
  String selectedCity;
  String currentCity;
  Weather currentWeather;
  Position position;

  callback(List<String> cities) {
    setState(() {
      this.cities = cities;
    });
  }

  callbackCity(String selectedCity) {
    setState(() {
      this.selectedCity = selectedCity;
      getWeather();
    });
  }

  @override
  initState() {
    getLocation();
    super.initState();
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    if (position != null) {
      print(
          "position latitude : ${position.latitude} / longitude : ${position.longitude}");
      List<Placemark> places =
          await GeocodingPlatform.instance.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (places.isNotEmpty) {
        setState(() {
          currentCity = places[0].locality;
          selectedCity = currentCity;
          getWeather();
        });
      }
    }
  }

  getWeather() async {
    String cityName;
    if (selectedCity == null) {
      cityName = currentCity;
    } else {
      cityName = selectedCity;
    }
    List<Location> coordinates =
        await GeocodingPlatform.instance.locationFromAddress(cityName);
    if (coordinates.isNotEmpty) {
      coordinates.forEach((element) {
        print(
            "latitude : ${element.latitude} \n longitude: ${element.longitude}");
      });
      final lat = coordinates.first.latitude;
      final long = coordinates.first.longitude;
      String lang = Localizations.localeOf(context).languageCode;

      String url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&lang=$lang&APPID=$KEY";

      Dio dio = Dio();
      final response = await dio.get(url);
      if (response != null && response.statusCode == 200) {
        print(response.data);
        Weather weather = Weather();
        Map map = Map<String, dynamic>.from(response.data);
        weather.fromJSON(map);
        setState(() {
          currentWeather = weather;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: Text("Flutter Weather"),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        drawer: CustomDrawer(
          currentCity,
          callback,
          callbackCity,
        ),
        body: currentWeather == null
            ? Center(
                child: Container(
                  child: TextPerso(
                    selectedCity != null && currentCity != null
                        ? selectedCity
                        : "Ville choisie",
                  ),
                ),
              )
            : WeatherScreen(currentWeather, selectedCity));
  }
}
