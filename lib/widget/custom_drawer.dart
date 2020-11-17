import 'package:flutter/material.dart';
import 'package:flutter_weather/models/shared_pref.dart';
import 'package:flutter_weather/widget/text_perso.dart';

class CustomDrawer extends StatefulWidget{

  final String currentCity;
  final Function(List<String>) callback;
  final Function(String) callbackCity;


  CustomDrawer(this.currentCity, this.callback,this.callbackCity);

  @override
  State<StatefulWidget> createState() {
    return _CustomDrawer();
  }

}

class _CustomDrawer extends State<CustomDrawer>{

  SharedPrefs prefs = SharedPrefs();
  var cities = [];
  var selectedCity;
  var currentCity;

  @override
  void initState() {
      getCities();
      super.initState();
  }

  getCities() async {
    List<String> fetchedCities = await prefs.getCitiesInSharedPreferences();
    setState(() {
      cities = fetchedCities;
    });
    widget.callback(cities);
  }

  addCities(String cityName) {
    prefs.addCityInSharedPreferences(cityName);
    getCities();
  }

  deleteCity(String cityName) {
    prefs.deleteCityInSharedPreferences(cityName);
    getCities();
  }

  Future<Null> addCity() async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(20.0),
            title: TextPerso(
              "Add a city",
              fontSize: 20.0,
              color: Colors.black87,
            ),
            elevation: 10.0,
            children: [
              TextField(
                  decoration: InputDecoration(labelText: "City"),
                  onSubmitted: (String cityName) {
                    if (cityName.isNotEmpty) {
                      addCities(cityName);
                      selectedCity = cityName;
                      widget.callbackCity(selectedCity);
                      // getWeather();
                    }
                    Navigator.pop(buildContext);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var currentCity = widget.currentCity;
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.grey[850],
        child: ListView.builder(
          itemCount: cities.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextPerso(
                      "Cities",
                    ),
                    RaisedButton(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      color: Colors.grey[700],
                      elevation: 10,
                      onPressed: () {
                        addCity();
                      },
                      child: TextPerso(
                        "Add a new City",
                      ),
                    )
                  ],
                ),
              );
            } else if (index == 1) {
              return ListTile(
                onTap: () {
                  setState(() {
                    currentCity != null
                        ? selectedCity = currentCity
                        : selectedCity = null;
                  });
                  widget.callbackCity(selectedCity);
                  Navigator.pop(context);
                },
                title: TextPerso(
                  currentCity != null ? currentCity : "Ma ville actuelle",
                  fontSize: 14.0,
                ),
              );
            } else {
              return ListTile(
                onTap: () {
                  setState(() {
                    selectedCity = cities[index - 2];
                    Navigator.pop(context);
                  });
                  widget.callbackCity(selectedCity);
                },
                title: TextPerso(
                  cities[index - 2],
                  fontSize: 14.0,
                ),
                trailing: IconButton(
                  onPressed: () {
                    deleteCity(cities[index - 2]);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}