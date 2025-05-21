import 'package:geolocator/geolocator.dart';

//Clase para obtener la ubicación actual del usuario
class Location {
  double? latitude; //Latitud de la ubicación
  double? longitude; //Longitud de la ubicación

  //Metodo para obtener la ubicación actual utilizando el paquete geolocator
  Future<void> getCurrentLocation() async {
    try {
      // Verificar si el servicio de ubicación está habilitado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Los servicios de ubicación están desactivados.');
        return;
      }

      // Verificar y solicitar permisos de ubicación
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Permisos de ubicación denegados.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Permisos de ubicación denegados permanentemente.');
        return;
      }

      // Si los permisos están concedidos, obtener la ubicación
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.low),
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(
        'Error al obtener la ubicación: $e',
      ); //En caso de error, mostramos el error
    }
  }
}
