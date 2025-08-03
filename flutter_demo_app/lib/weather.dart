import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:weather_icons/weather_icons.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherTabState createState() => _WeatherTabState();
}

class _WeatherTabState extends State<Weather> {
  String city = "Casablanca";
  List<dynamic>? forecast;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final apiKey = kIsWeb
        ? ''
        : dotenv.env['OPENWEATHER_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = "API key not found. Please check .env file or provide a key.";
      });
      return;
    }

    final url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception("Failed to load weather: ${response.body}");
      }
      final data = json.decode(response.body);
      setState(() {
        forecast = data["list"];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Error fetching weather: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherIcons.day_sunny;
      case 'clouds':
        return WeatherIcons.cloud;
      case 'rain':
        return WeatherIcons.rain;
      case 'drizzle':
        return WeatherIcons.sprinkle;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'snow':
        return WeatherIcons.snow;
      case 'mist':
      case 'fog':
      case 'haze':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.na;
    }
  }

  Color _getWeatherColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Colors.orange.shade600;
      case 'clouds':
        return Colors.grey.shade600;
      case 'rain':
        return Colors.blue.shade700;
      case 'drizzle':
        return Colors.lightBlue.shade600;
      case 'thunderstorm':
        return Colors.purple.shade700;
      case 'snow':
        return Colors.blueGrey.shade300;
      case 'mist':
      case 'fog':
      case 'haze':
        return Colors.grey.shade500;
      default:
        return Colors.teal.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Weather Forecast",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter city name...",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.location_city, color: Colors.blueAccent),
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
              onChanged: (value) => city = value,
              onSubmitted: (value) {
                city = value;
                fetchWeather();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : fetchWeather,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 4,
              ),
              child: isLoading
                  ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : Text(
                "Get Weather",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: errorMessage != null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                  SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: fetchWeather,
                    child: Text("Try Again"),
                  ),
                ],
              ),
            )
                : forecast == null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Loading weather data...",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: forecast!.length,
              itemBuilder: (context, index) {
                final item = forecast![index];
                final date = DateTime.fromMillisecondsSinceEpoch(
                    item["dt"] * 1000);
                final weatherCondition = item["weather"][0]["main"].toLowerCase();
                final temp = item["main"]["temp"];
                final desc = item["weather"][0]["description"];
                final humidity = item["main"]["humidity"];
                final windSpeed = item["wind"]["speed"];

                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getWeatherColor(weatherCondition),
                        _getWeatherColor(weatherCondition).withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _getWeatherColor(weatherCondition).withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: BoxedIcon(
                        _getWeatherIcon(weatherCondition),
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    title: Text(
                      "${DateFormat('EEEE, MMM dd').format(date)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          "${DateFormat('HH:mm').format(date)}",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          desc.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: Colors.white.withOpacity(0.8),
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "$humidity%",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 16),
                            Icon(
                              Icons.air,
                              color: Colors.white.withOpacity(0.8),
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${windSpeed.toStringAsFixed(1)} m/s",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${temp.round()}°",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "C",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}