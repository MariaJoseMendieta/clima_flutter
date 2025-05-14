import 'package:flutter/material.dart';
import 'package:clima_flutter/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima_flutter/services/weather.dart';

//Clase para la pantalla de carga mientras se obtiene el clima
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData(); //Obtenemos los datos del clima al iniciar
  }

  //Metodo para obtener el clima de la ubicación actual
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    //Cuando los datos del clima se obtienen, navegamos a la pantalla principal
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Color(0xFF90CAF9),
          size: 100.0,
        ), //Indicador de carga mientras obtenemos los datos
      ),
    );
  }
}
