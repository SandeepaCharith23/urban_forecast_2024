import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urban_forecast_2024/models/weather.dart';
import 'package:urban_forecast_2024/services/weather_services.dart';
import 'package:urban_forecast_2024/widgets/weather_display_card.dart';

class SerarchScreen extends StatefulWidget {
  const SerarchScreen({super.key});

  @override
  State<SerarchScreen> createState() => _SerarchScreenState();
}

class _SerarchScreenState extends State<SerarchScreen> {
  //initialized api key
  final WeatherServices _weatherServices =
      WeatherServices(apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "");
  Weather? _weatherobject;
  String? _error;

  final TextEditingController searchTextController = TextEditingController();

  void _searchWeather() async {
    final String enteredCityName = searchTextController.text.trim();
    if (enteredCityName.isEmpty) {
      setState(() {
        _error = "Please enter the city name";
      });
      return;
    }

    try {
      final searchCityWeather =
          await _weatherServices.getWeatherForCityName(enteredCityName);
      setState(() {
        _weatherobject = searchCityWeather;
        _error = null;
      });
    } catch (error) {
      setState(() {
        _error =
            "Could not find a weather report for this city $enteredCityName";
      });
      throw Exception("Something Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serach weather"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //search bar
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    labelText: "Search what you want",
                    hintText: "City name",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: _searchWeather,
                      icon: const Icon(Icons.search),
                    ),
                  ),
                  onChanged: (value) => _searchWeather(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //display weather details
            _error != null
                ? Text("error is $_error!")
                : _weatherobject != null
                    ? WeatherDisplayCard(selectedWeather: _weatherobject!)
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
