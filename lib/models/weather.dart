class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double humidity;
  final double windSpeed;
  final double pressure;
  final String condition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.condition,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}