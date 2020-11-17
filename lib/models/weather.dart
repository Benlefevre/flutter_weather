class Weather {
  String name;
  String main;
  String description;
  var icon;
  var temp;
  var temp_min;
  var temp_max;
  var pressure;
  var humidity;

  Weather();

  void fromJSON(Map map) {
    this.name = map["name"];

    List weatherInfo = map["weather"];
    Map weatherMap = weatherInfo[0];
    this.main = weatherMap["main"];
    this.description = weatherMap["description"];
    this.icon = weatherMap["icon"];

    Map mainMap = map["main"];
    this.temp = mainMap["temp"];
    this.temp_min = mainMap["temp_min"];
    this.temp_max = mainMap["temp_max"];
    this.pressure = mainMap["pressure"];
    this.humidity = mainMap["humidity"];
  }
}
