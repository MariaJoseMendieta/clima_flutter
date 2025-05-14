import 'package:clima_flutter/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:clima_flutter/services/weather.dart';

//Pantalla principal que muestra el clima según la ubicación del usuario
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.locationWeather});

  final dynamic
  locationWeather; //Recibe los datos meteorológicos para la ubicación actual

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temperature; //Almacena la temperatura
  String? weatherIcon; //Almacena el ícono del clima
  String? cityName; //Almacena el nombre de la ciudad
  String? weatherMessage; //Almacena el mensaje de clima

  //Inicializa la pantalla con los datos meteorológicos
  @override
  void initState() {
    super.initState();
    updateUI(
      widget.locationWeather,
    ); //Actualiza la UI con los datos meteorológicos recibidos
  }

  //Actualiza la UI con los datos del clima
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature ?? 0);
      cityName = weatherData['name'];
    });
  }

  //Construye la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData =
                          await weather
                              .getLocationWeather(); //Obtener clima de la ubicación actual
                      updateUI(
                        weatherData,
                      ); //Actualizar UI con los nuevos datos
                    },
                    child: Icon(Icons.near_me, color: Colors.black, size: 50.0),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(
                          typedName,
                        );
                        updateUI(
                          weatherData,
                        ); //Actualizar UI con el clima de la ciudad seleccionada
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.black,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text('$temperature°', style: kTempTextStyle),
                    Text(weatherIcon ?? '', style: kConditionTextStyle),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
