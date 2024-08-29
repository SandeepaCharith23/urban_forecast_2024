import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:urban_forecast_2024/models/weather.dart';
import 'package:urban_forecast_2024/utils/utils_functions.dart';

class WeatherDisplayCard extends StatelessWidget {
  final Weather selectedWeather;
  const WeatherDisplayCard({super.key, required this.selectedWeather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Weather Details"),
                Center(
                  child: Lottie.asset(
                    UtilsFunctions().getWeatherConditionAnimation(
                      weatherCondition: selectedWeather.cityWeatherCondition,
                    ),
                    width: 200,
                    height: 200,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/city.png",
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      selectedWeather.cityName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      selectedWeather.cityWeatherDescription,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/temperature.png",
                      width: 50,
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Current Temperature ",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${selectedWeather.cityWeatherTempreature.toStringAsFixed(1)}°C",
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WeatherConditionSubDetailsTile(
                      lable: 'Pressure',
                      value:
                          "${selectedWeather.cityWeatherPressure.toStringAsFixed(0)} hPa",
                      iconpath: 'assets/air_pressure.png',
                    ),
                    WeatherConditionSubDetailsTile(
                      lable: 'Humidity',
                      value:
                          "${selectedWeather.cityWeatherHumidity.toStringAsFixed(0)} %RH",
                      iconpath: 'assets/humidity.png',
                    ),
                    WeatherConditionSubDetailsTile(
                      lable: 'Sea Level',
                      value:
                          "${selectedWeather.citySealevel.toStringAsFixed(0)} m ",
                      iconpath: "assets/sea_level.png",
                    ),
                    WeatherConditionSubDetailsTile(
                      lable: 'Wind Speed',
                      value:
                          "${selectedWeather.cityWeatherWindSpeed.toStringAsFixed(0)} km/h ",
                      iconpath: "assets/wind_speed.png",
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherConditionSubDetailsTile extends StatelessWidget {
  final String lable, value, iconpath;
  const WeatherConditionSubDetailsTile({
    super.key,
    required this.lable,
    required this.value,
    required this.iconpath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lable,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Image.asset(
                iconpath,
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
