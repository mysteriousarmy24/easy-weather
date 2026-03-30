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
 final TextEditingController _cityName = TextEditingController();
  String cityName = "";
  Weather? newWeather;
  @override
  void dispose() {
    _cityName.dispose();
    super.dispose();
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
                  width: 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    //color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: TextField(
                    controller: _cityName,
                    decoration: InputDecoration(
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
                Container(
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
                        WeatherService(apiKey: dotenv.env['OPEN_WEATHER_API_KEY']!)
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
                ),
              ],
            ),
            SizedBox(height: 20),
            if (newWeather != null)
             DisplayWeather(weather: newWeather!)
            else
               Center(child: Text("Search City name")),
          ],
        ),
      ),
    );
  }
}
