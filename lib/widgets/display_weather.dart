import 'package:easy_wheather/models/weather.dart';
import 'package:easy_wheather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DisplayWeather extends StatelessWidget {
  final Weather weather;
  const DisplayWeather({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(
                UtilFunctions().getWeatherAnimation(
                  condition: weather.condition,
                ),
                width: 400,
                height: 400,
              ),
            ),
            Text(
              weather.cityName,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              "${weather.temperature.toStringAsFixed(1)}°C",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              weather.description,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Humidity",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                        ),
                      ),
                      Text(
                        "${weather.humidity.toStringAsFixed(2)}%",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Pressure",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                        ),
                      ),
                      Text(
                        "${weather.pressure.toStringAsFixed(2)}Hgmm",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Wind Speed",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                        ),
                      ),
                      Text(
                        "${weather.windSpeed.toStringAsFixed(2)}km/h",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
