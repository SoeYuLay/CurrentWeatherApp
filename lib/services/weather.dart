import 'dart:io';

import 'package:current_weather/services/location.dart';
import 'package:current_weather/services/network.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../main.dart';

// const APIkey = '81b25695c37b4cf7e7ddccdf086f997f';
// const openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCurrentLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    var url = Uri.parse(
        '${dotenv.env['openWeatherURL']}?lat=${location.latitude}&lon=${location.longitude}&appid=${dotenv.env['APIKey']}&units=metric');
    NetworkHelper networkHelper = NetworkHelper(url);
    return await networkHelper.getWeatherData();

  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        Uri.parse('${dotenv.env['openWeatherURL']}?q=$cityName&appid=${dotenv.env['APIKey']}&units=metric');

    NetworkHelper networkHelper = NetworkHelper(url);
    return await networkHelper.getWeatherData();
  }

  String getWeatherIcon(int condition) {
    if (condition == 1000){
      return '🥵';
    }else if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp == 200) {
      return 'Hot Girlfriend Alert 🚨';
    } else if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
