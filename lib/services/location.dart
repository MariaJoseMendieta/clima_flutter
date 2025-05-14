import 'package:geolocator/geolocator.dart';

//Clase para obtener la ubicación actual del usuario
class Location {
  double? latitude; //Latitud de la ubicación
  double? longitude; //Longitud de la ubicación

  //Metodo para obtener la ubicación actual utilizando el paquete geolocator
  Future<void> getCurrentLocation() async {
    try {
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.low, //Configuración para precisión baja
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            locationSettings, //Obtenemos la posición actual con la configuración especificada
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e); //En caso de error, mostramos el error
    }
  }
}
