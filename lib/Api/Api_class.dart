import 'package:flutter/material.dart';
import 'package:weather_learn_api/Api/weather_api_service.dart';

import 'forcast_weather_api_model.dart';

class ApiClass extends StatefulWidget {
  var city;

  ApiClass({Key? key, required this.city}) : super(key: key);

  @override
  State<ApiClass> createState() => _ApiClassState();
}

class _ApiClassState extends State<ApiClass> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().getcurrentWeather(widget.city),
      builder: (BuildContext context, AsyncSnapshot<Forecast?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 160,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Color(0xFFBBDEFB),
                    Color(0xFF90CAF9),
                    Color(0xFF64B5F6),
                    Color(0xFF42A5F5),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent,
                    blurRadius: 10.0,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "${snapshot.data!.name}",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontFamily: "Popins",
                            letterSpacing: 2),
                      ),
                    ),
                    Text(
                      "${snapshot.data?.main!.temp}",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image(
                      image: AssetImage(
                        "assets/images/weather.png",
                      ),
                      height: 50,
                    ),
                    Text(
                      "${snapshot.data?.weather![0]['main']}",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              "is Loading",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontFamily: "Popins",
                  letterSpacing: 2),
            ),
          );
        }
      },
    );
  }
}
