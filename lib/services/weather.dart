import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';

//Definimos una constante para la clave de la API de OpenWeatherMap y la URL base para las solicitudes
const apiKey = '049e5234bc0a2140c0ba4117ea31573c';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

//Clase para manejar las solicitudes de clima
class WeatherModel {
  //Metodo para obtener el clima de una ciudad, basado en el nombre de la ciudad
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      url: '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric',
    );
    //Realizamos la solicitud HTTP y obtenemos los datos del clima
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  //Metodo para obtener el clima basado en la ubicación actual del usuario
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location
        .getCurrentLocation(); //Obtención ubicación actual del usuario

    //Creamos la URL para obtener el clima con las coordenadas
    NetworkHelper networkHelper = NetworkHelper(
      url:
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );

    //Solicitamos los datos del clima para esas coordenadas
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  //Metodo para obtener el ícono correspondiente al clima, basado en el código de condición
  String getWeatherIcon(int condition) {
    if (condition < 300) {
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

  //Metodo para obtener un mensaje según la temperatura
  String getMessage(int temp) {
    if (temp > 25) {
      return "It's 🍦 time";
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
