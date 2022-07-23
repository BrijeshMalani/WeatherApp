import 'package:flutter/material.dart';
import 'package:weather_learn_api/Api/Api_class.dart';
import 'package:weather_learn_api/Api/forcast_weather_api_model.dart';
import 'package:weather_learn_api/Api/weather_api_service.dart';

class WeatherDetailScreen extends StatefulWidget {
  const WeatherDetailScreen({Key? key}) : super(key: key);

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  final search = TextEditingController();
  GlobalKey<FormState> _formkey = new GlobalKey();

  String name = "gujrat";
  List city = ["dilli", "surat", "gujrat", "mumbai", "kolkata"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formkey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sun.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '* required';
                    } else {
                      return null;
                    }
                  },
                  controller: search,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: InkWell(
                      onTap: () {
                        if (search.text.isNotEmpty) {
                          setState(() {
                            name = search.text;
                          });
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                    counterText: "Weather",
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    fillColor: Colors.black.withOpacity(0.4),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: ApiService().getcurrentWeather("${name}"),
                builder:
                    (BuildContext context, AsyncSnapshot<Forecast?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 200,
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
                        // image:
                        // DecorationImage(
                        //     image: AssetImage("assets/images/sun.jpg"),
                        //     fit: BoxFit.cover),
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
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "Popins",
                                    letterSpacing: 2),
                              ),
                            ),
                            Divider(
                              height: 10,
                              thickness: 3,
                              color: Colors.blue,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${snapshot.data?.weather![0]['main']}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      "${snapshot.data?.main!.temp}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Feels like : ${snapshot.data!.main!.feelsLike}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "assets/images/weather.png",
                                      ),
                                      height: 70,
                                    ),
                                    Text(
                                      "humidity : ${snapshot.data!.main!.humidity}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
              ),
              SizedBox(height: 10),
              Container(
                height: 170,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: city.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ApiClass(city: city[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
