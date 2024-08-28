import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:urban_forecast_2024/models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:urban_forecast_2024/services/get_loaction_service.dart';

class WeatherServices {
  //https://api.openweathermap.org/data/2.5/weather?q=london&appid=fae9486bb0b4a5b27817fa3adfa5571e&units=metric
  final String apiKey;
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  WeatherServices({required this.apiKey});
  //A method for return a Weather object for given city name
  Future<Weather> getWeatherForCityName(String cityName) async {
    try {
      final urlforgivencity = '$baseUrl?q=$cityName&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(urlforgivencity));
      if (response.statusCode == 200) {
        //response is successfull
        final jsonobject = jsonDecode(response.body);
        return Weather.fromJson(jsonobject);
      } else {
        throw Exception(
            "Failed to load weather data for given city-returning not succesfull");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      throw Exception("Failed to load weather data for given city");
    }
  }

  // A method for return a Weather object for choosen city lat and lon details
  Future<Weather> getWeatherForCityLocation() async {
    String selectedcityname =
        await GetLoactionService().getCityNameFromCurrentLocation();

    try {
      final urlforgivencity =
          '$baseUrl?q=$selectedcityname&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(urlforgivencity));
      if (response.statusCode == 200) {
        //response is successfull
        final jsonobject = jsonDecode(response.body);
        return Weather.fromJson(jsonobject);
      } else {
        if (kDebugMode) {
          print(
              "Failed to load weather data for given city-returning not succesfull");
        }
        throw Exception(
            "Failed to load weather data for given city-returning not succesfull");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      throw Exception("Failed to load weather data for given city");
    }
  }
}
