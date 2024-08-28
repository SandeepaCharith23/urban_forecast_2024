import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urban_forecast_2024/models/weather.dart';
import 'package:urban_forecast_2024/services/weather_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //initialized api key
  final WeatherServices _weatherServices =
      WeatherServices(apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "");
  Weather? weatherobject;

  //method to fetch weather model
  void fetchWeather() async {
    try {
      final weather = _weatherServices.getWeatherForCityLocation();
      setState(() {
        weatherobject = weather as Weather?;
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error occured when fetch Weather process : $error");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Urban Forecast app 2024"),
      ),
    );
  }
}
