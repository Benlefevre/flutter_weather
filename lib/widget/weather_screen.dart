import 'package:flutter/material.dart';
import 'package:flutter_weather/custom_icons/custom_icons.dart';
import 'package:flutter_weather/models/weather.dart';
import 'package:flutter_weather/widget/text_deco.dart';
import 'package:flutter_weather/widget/text_perso.dart';

class WeatherScreen extends StatefulWidget {
  final Weather currentWeather;
  final String selectedCity;

  WeatherScreen(this.currentWeather, this.selectedCity);

  @override
  State<StatefulWidget> createState() {
    return _WeatherScreen();
  }
}

class _WeatherScreen extends State<WeatherScreen> {
  var currentWeather;
  var selectedCity;

  List<Color> getColors() {
    List<Color> colors = [];
    if (currentWeather != null) {
      if (currentWeather.icon.contains("d")) {
        colors = [
          Colors.lightBlue[300].withOpacity(0.6),
          Colors.blue[900].withOpacity(0.6)
        ];
      } else {
        colors = [Colors.blue[900].withOpacity(0.6), Colors.black54];
      }
    }
    return colors;
  }

  String getAssetBackground() {
    if (currentWeather.icon.contains("01d")) {
      return "assets/sunny.jpg";
    } else if (currentWeather.icon.contains("01n")) {
      return "assets/sunny_night.jpg";
    } else if (currentWeather.icon.contains("02d")) {
      return "assets/few_clouds.jpg";
    } else if (currentWeather.icon.contains("03d")) {
      return "assets/thinning.jpg";
    } else if (currentWeather.icon.contains("04d")) {
      return "assets/cloudy.jpg";
    } else if (currentWeather.icon.contains("02n") ||
        currentWeather.icon.contains("03n") ||
        currentWeather.icon.contains("04n")) {
      return "assets/cloud_night.jpg";
    } else if (currentWeather.icon.contains("09d") ||
        currentWeather.icon.contains("10d")) {
      return "assets/rain_day.jpg";
    } else if (currentWeather.icon.contains("09n") ||
        currentWeather.icon.contains("10n")) {
      return "assets/rainy.jpg";
    } else if (currentWeather.icon.contains("11")) {
      return "assets/thunderstorm1.jpg";
    } else if (currentWeather.icon.contains("13")) {
      return "assets/snow.jpg";
    } else {}
  }

  IconData getIcons() {
    if (currentWeather.icon.contains("01d")) {
      return CustomIcons.sun;
    } else if (currentWeather.icon.contains("01n")) {
      return CustomIcons.moon;
    } else if (currentWeather.icon.contains("02d")) {
      return CustomIcons.cloud_sun;
    } else if (currentWeather.icon.contains("03d") || currentWeather.icon.contains("04d")) {
      return CustomIcons.clouds;
    } else if (currentWeather.icon.contains("02n") ||
        currentWeather.icon.contains("03n") ||
        currentWeather.icon.contains("04n")) {
      return CustomIcons.cloud_moon;
    } else if (currentWeather.icon.contains("09") ||
        currentWeather.icon.contains("10")) {
      return CustomIcons.rain;
    } else if (currentWeather.icon.contains("11")) {
      return CustomIcons.cloud_flash;
    } else if (currentWeather.icon.contains("13")) {
      return CustomIcons.snow_heavy;
    } else {
      return CustomIcons.fog_cloud;
    }
  }

  @override
  Widget build(BuildContext context) {
    this.currentWeather = widget.currentWeather;
    this.selectedCity = widget.selectedCity;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(getAssetBackground()), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            getIcons(),
            color: Colors.white,
            size: 75,
          ),
          TextDeco(
            TextPerso(
              selectedCity,
              fontSize: 20.0,
            ),
            colors: getColors(),
          ),
          TextDeco(
            TextPerso(
              "${currentWeather.temp}°C",
              fontSize: 20.0,
            ),
            colors: getColors(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextDeco(
                TextPerso(
                  "Min : \n ${currentWeather.temp_min}°C",
                ),
                colors: getColors(),
              ),
              TextDeco(
                TextPerso(
                  "Max : \n ${currentWeather.temp_max}°C",
                ),
                colors: getColors(),
              ),
            ],
          ),
          TextDeco(
            TextPerso(
              currentWeather.description,
            ),
            colors: getColors(),
          ),
        ],
      ),
    );
  }
}
