import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //definir la variable controler
  final crlnombre = TextEditingController();

  String idioma = '';

//va estar una caja de texto en donde se guarden los valores
  Future saveIdioma(String idioma) async {
//pide el async para que sincronce datos
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('idioma', idioma);
    print(idioma);
  }

  //metodo para obtener la shared preferences
  Future<String> obtenerIdioma() async {
    final prefs = await SharedPreferences.getInstance();
    String idioma = prefs.getString('idioma') ?? 'no se encontro';
    // en caso de que no exista ?? por que pide la opcion
    return idioma;
  }

//
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //esto es nuevo del curso intermedio con las cajas de texto
            TextFormField(
              //invoca al controlador de la variable
              controller: crlnombre,
              //definir que quiero que tenga la caja de texto
              decoration: const InputDecoration(labelText: 'idioma'),
            ),
            Text(idioma),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                saveIdioma(crlnombre.text);
              },
              child: Icon(Icons.ac_unit),
            ),
            FloatingActionButton(
              onPressed: () async {
                idioma = await obtenerIdioma();
                setState(() {});
              },
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
