import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLoactionService {
  //A method for getting the city name from lat and long
  Future<String> getCityNameFromCurrentLocation() async {
    //get the permission for location
    LocationPermission locationPermission =
        await Geolocator.requestPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    //  else if (locationPermission == LocationPermission.deniedForever) {
    //   return Future.error('Location services are disabled.');
    // } else {}
    //get the current loaction
    Position position = await Geolocator.getCurrentPosition(
        // desiredAccuracy: LocationAccuracy.high,
        );

    if (kDebugMode) {
      print(position.latitude);
      print(position.longitude);
    }

    //get the place using placemarkfromCoordinates
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //get the city name
    String cityname = placeMarks[0].locality!;

    if (kDebugMode) {
      print("city name is : $cityname");
    }

    return cityname;
  }
}
