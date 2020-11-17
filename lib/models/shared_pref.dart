import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  final String key ="CITIES";
  List<String> cities = [];

  Future<List<String>> getCitiesInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(key);
    if (list != null) {
      cities = list;
    }
    return cities;
  }

  addCityInSharedPreferences(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cities.add(cityName);
    prefs.setStringList(key, cities);
  }

  deleteCityInSharedPreferences(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cities.remove(cityName);
    prefs.setStringList(key, cities);
  }
}