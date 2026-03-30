import 'package:easy_wheather/Pages/search_weather.dart';
import 'package:easy_wheather/Services/weather_service.dart';
import 'package:easy_wheather/models/weather.dart';
import 'package:easy_wheather/widgets/display_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherService _weatherService = WeatherService(
    apiKey: dotenv.env['OPEN_WETHER_API_KEY']!,
  );
  Weather? _weather;

  //method to fetch the weather
  Future<void> _fetchWeather() async {
    try {
      Weather weather = await _weatherService.getWeatherFromLocation();
      setState(() {
        _weather = weather;
      });
      print(_weather);
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  @override
  void initState() {
    _fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Easy Weather',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.light_mode))],
      ),
      body: _weather != null
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DisplayWeather(weather: _weather!),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        226,
                        182,
                        24,
                      ).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchWeather(),
                          ),
                        );
                      },
                      child: Text(
                        "Search for another city",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
