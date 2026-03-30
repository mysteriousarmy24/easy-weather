import 'package:easy_wheather/Services/weather_service.dart';
import 'package:easy_wheather/models/weather.dart';
import 'package:easy_wheather/widgets/display_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchWeather extends StatefulWidget {
  const SearchWeather({super.key});

  @override
  State<SearchWeather> createState() => _SearchWeatherState();
}

class _SearchWeatherState extends State<SearchWeather> {
  WeatherService _weatherService = WeatherService(
    apiKey: dotenv.env['OPEN_WETHER_API_KEY'] ??  " ",
  );
  Weather? _weather;
  String? error;
  final TextEditingController _controller = TextEditingController();
  // String cityName = "";
  // Weather? newWeather;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _searchWeather() async{
    final city = _controller.text.trim();
    try {
  if(city.isEmpty){
    setState(() {
      error = "Please enter a city";
    });
    return;
  }
  final newWeather = await _weatherService.getWeather(city);
  setState(() {
    _weather = newWeather;
    error= null;
  });
}  catch (e) {
  error = "Failed to load weather data: $city";
  print('error in fetching weather: $e');
  setState(() {
    _weather = null;
  });
  
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search A City",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 400,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    //color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value) => _searchWeather(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _searchWeather,
                        icon: Icon(Icons.search),
                      ),
                      hintText: "Enter city name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                /*Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        cityName = _cityName.text;
                        WeatherService(
                              apiKey: dotenv.env['OPEN_WEATHER_API_KEY']!,
                            )
                            .getWeather(cityName)
                            .then((weather) {
                              setState(() {
                                newWeather = weather;
                              });
                            })
                            .catchError((error) {
                              print("Error fetching weather: $error");
                            });
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),*/
              ],
            ),
            SizedBox(height: 5),
            if (error != null)
              Text(
                error!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              )
            else if (_weather != null)
              DisplayWeather(weather: _weather!)
            else
              Center(child: Text("Search City name")),
            // if (newWeather != null)
            //   DisplayWeather(weather: newWeather!)
            // else
            //   Center(child: Text("Search City name")),
          ],
        ),
      ),
    );
  }
}
