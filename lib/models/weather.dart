class Weather {
  final String cityName, cityWeatherCondition, cityWeatherDescription;
  final double cityWeatherTempreature,
      cityWeatherPressure,
      cityWeatherHumidity,
      citySealevel,
      cityWeatherWindSpeed,
      cityLongtitude,
      cityLatitude;

  Weather({
    required this.cityName,
    required this.cityWeatherCondition,
    required this.cityWeatherDescription,
    required this.cityWeatherTempreature,
    required this.cityWeatherPressure,
    required this.cityWeatherHumidity,
    required this.citySealevel,
    required this.cityWeatherWindSpeed,
    required this.cityLongtitude,
    required this.cityLatitude,
  });

  //convert json data to weather dart object
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"],
      cityWeatherCondition: json["weather"][0]["main"],
      cityWeatherDescription: json["weather"][0]["description"],
      cityWeatherTempreature: json["main"]["temp"].toDouble(),
      cityWeatherPressure: json["main"]["pressure"].toDouble(),
      cityWeatherHumidity: json["main"]["humidity"].toDouble(),
      citySealevel: json["main"]["sea_level"].toDouble(),
      cityWeatherWindSpeed: json["wind"]["speed"].toDouble(),
      cityLongtitude: json["coord"]["lon"].toDouble(),
      cityLatitude: json["coord"]["lat"].toDouble(),
    );
  }
}
