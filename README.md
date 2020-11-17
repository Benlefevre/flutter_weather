# Flutter Weather  

A Flutter Weather app to learn more about Flutter

## Description

A simple Flutter App that gives the weather forecast for a selected locality.

Training to use :

    - SharedPreferences
    - Json
    - Geocoding & Location
    - Http request & Dio
    - Custom Icons
    - BoxDecoration
    - Drawer

## Run on :

    - Android
    - IOS

## How to use

When you download or clone the project, before running a build for Android or IOS you have to add an API KEY for OpenWeatherMap in the const String named KEY:

    - lib/widget/home.dart
      - const String KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxx"
  
Log in or create an account on [OpenWeatherMap.com](https://openweathermap.org/api) and generate an APIKEY  

## Screenshots

Request permission to locate the user
![Screenshot Permission](assets/docs/Screen1.png)

Home Page after geolocation of the user Android
![Screenshot HomePage](assets/docs/Screen2.png)

Home Page after geolocation of the user IOS
![ScreenShot HomePage IOS](assets/docs/Screen6.png)

Drawer allows you to add cities
![Screenshot drawer](assets/docs/Screen3.png)

Selection of cities added by the user
![Screenshot drawer2](assets/docs/Screen4.png)

Home Page for the user's selected city
![Screenshot Home Page for Paris](assets/docs/Screen5.png)
