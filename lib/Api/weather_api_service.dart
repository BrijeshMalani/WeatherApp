import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_learn_api/Api/forcast_weather_api_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Forecast?> getcurrentWeather(String? location) async {
    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=2e9714911e1deb0a2ee62104c0b5928b&units=metric"));
    if (response.statusCode == 200) {
      print('${jsonDecode(response.body)}');
      print(jsonDecode(response.body));
      // var body = jsonDecode(response.body);
      return forecastFromJson(response.body);
    } else {
      return null;
    }
  }
}
