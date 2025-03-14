import 'package:current_weather/screens/city_screen.dart';
import 'package:current_weather/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

class CurrentLocation extends StatefulWidget {
  CurrentLocation({this.locationWeather});

  final locationWeather;

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  WeatherModel weatherModel = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  String getDate() {
    final now = DateTime.now();
    final formattedDate = DateTimeFormat.format(now, format: 'D, M j');
    return formattedDate;
  }

  String getTime() {
    final now = DateTime.now();
    final formattedTime = DateTimeFormat.format(now, format: 'H:i');
    return formattedTime;
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      } else {
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();

        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition!);

        weatherMessage = weatherModel.getMessage(temperature!);
        cityName = weatherData['name'];
      }
    });
  }

  void updatePUI() {
    setState(() {
      temperature = 200;
      weatherIcon = weatherModel.getWeatherIcon(1000);
      weatherMessage = weatherModel.getMessage(200);
      cityName = 'Pu Tuu';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/current_location.jpeg'),
                  fit: BoxFit.fill)),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      height: 550,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      var weatherData = await weatherModel
                                          .getCurrentLocationWeather();
                                      updateUI(weatherData);
                                    },
                                    child: Icon(
                                      Icons.near_me,
                                      color: Colors.deepPurple,
                                      size: 40,
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      var typedName = await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                        return CityScreen();
                                      }));
                                      if(typedName!= null && typedName== 'Pu Tuu' || typedName=='pu tuu'){
                                        updatePUI();
                                      }
                                      else if (typedName != null) {
                                        var weatherData = await weatherModel
                                            .getCityWeather(typedName);
                                        updateUI(weatherData);
                                      }
                                    },
                                    child: Icon(
                                      Icons.location_city,
                                      color: Colors.deepPurple,
                                      size: 40,
                                    ))
                              ],
                            ),
                          ),
                          Text(
                            'Today, ${getDate()}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '$cityName',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '$weatherIcon',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 110),
                          ),
                          Text(
                            'Current Weather',
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer,
                                size: 28,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                getTime(),
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.thermostat,
                                size: 45,
                              ),
                              Text(
                                '$temperature°',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 55),
                              ),
                            ],
                          ),
                          Text(
                            '$weatherMessage',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                        ],
                      ))),
            ],
          ))),
    );
  }
}
