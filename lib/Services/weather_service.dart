import 'dart:convert';

import 'package:easy_wheather/Services/get_location.dart';
import 'package:easy_wheather/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService({required this.apiKey});
  //get weather from city name
  Future<Weather> getWeather(String cityName) async {
    final url = "$BASE_URL?q=$cityName&units=metric&appid=$apiKey";
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to load weather data: $e");
    }
  }

  //get weather from cuurrent location
  Future<Weather> getWeatherFromLocation() async {
    final String cityName = await GetLocation()
        .getCityNameFromCurrentLocation();
    final url = "$BASE_URL?q=$cityName&units=metric&appid=$apiKey";
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      print(  "Error: $e");
      throw Exception("Failed to load weather data: $e");
    }
  }
}
