import 'package:flutter/material.dart';

//Definimos estilos de texto para distintas partes de la aplicación
const kTempTextStyle = TextStyle(fontFamily: 'Spartan MB', fontSize: 100.0);
const kMessageTextStyle = TextStyle(fontFamily: 'Spartan MB', fontSize: 60.0);
const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.black,
  fontFamily: 'Spartan MB',
);
const kConditionTextStyle = TextStyle(fontSize: 100.0);

//Estilo de decoración para el campo de texto en el que se ingresa el nombre de la ciudad
const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(Icons.location_city),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);
