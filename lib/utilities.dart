import 'package:flutter/material.dart';

class UtilFunctions {
  String getWeatherAnimation({required String condition}) {
    switch (condition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        //Todo : Add the json file that downloaed from lotty files
        return "asset/cloudy.json";

      case "rain":
      case "drizzle":
      case "shower rain":
        //Todo : Add the json file that downloaed from lotty files
        return "asset/rain.json";

      case "thunderstorm":
        return "asset/thunder.json";

      case "clear":
        return "asset/sunny.json";

      default:
        return "asset/sunny.json";
    }
  }
}
