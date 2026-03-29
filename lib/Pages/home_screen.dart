import 'package:flutter/material.dart';
import 'package:easy_wheather/Services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weather;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final weatherData = await _weatherService.getWeatherByLocation();
      setState(() {
        _weather = weatherData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Weather'),
        centerTitle: true,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _errorMessage != null
                ? Text(
                    'Error: $_errorMessage',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  )
                : _weather != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weather!['name'] ?? 'Unknown Location',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${_weather!['main']['temp'].round()}°C',
                            style: const TextStyle(fontSize: 48),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _weather!['weather'][0]['main'],
                            style: const TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                        ],
                      )
                    : const Text('No weather data available'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
            _errorMessage = null;
          });
          _fetchWeather();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}