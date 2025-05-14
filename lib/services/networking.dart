import 'package:http/http.dart' as http;
import 'dart:convert';

//Clase para hacer solicitudes HTTP y obtener datos de la API
class NetworkHelper {
  NetworkHelper({required this.url}); //Recibimos la URL para hacer la solicitud

  final String url;

  //Metodo para hacer la solicitud HTTP y devolver los datos en formato JSON
  Future getData() async {
    http.Response response = await http.get(
      Uri.parse(url),
    ); //Realizamos la solicitud GET
    if (response.statusCode == 200) {
      String data =
          response
              .body; //Si la respuesta es exitosa, obtenemos el cuerpo de la respuesta
      return jsonDecode(data); //Decodificamos el JSON y lo devolvemos
    } else {
      print(
        response.statusCode,
      ); //Si la respuesta falla, mostramos el código de error
    }
  }
}
