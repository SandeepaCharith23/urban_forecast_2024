import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urban_forecast_2024/models/weather.dart';
import 'package:urban_forecast_2024/pages/serarch_screen.dart';
import 'package:urban_forecast_2024/services/weather_services.dart';
import 'package:urban_forecast_2024/widgets/weather_display_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //initialized api key
  final WeatherServices _weatherServices =
      WeatherServices(apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "");
  Weather? _weatherobject;

  //method to fetch weather model
  void fetchWeather() async {
    try {
      final weather = await _weatherServices.getWeatherForCityLocation();
      setState(() {
        _weatherobject = weather;
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
        title: const Text(
          "Urban Forecast app 2024",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.light_mode),
          )
        ],
      ),
      body: _weatherobject != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Display weather
                WeatherDisplayCard(
                  selectedWeather: _weatherobject!,
                ),

                const SizedBox(
                  height: 20,
                ),

                //search button
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SerarchScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Search here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
