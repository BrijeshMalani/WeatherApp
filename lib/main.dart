import 'package:flutter/material.dart';
import 'package:weather_learn_api/views/weather_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wheather Detail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherDetailScreen(),
    );
  }
}
