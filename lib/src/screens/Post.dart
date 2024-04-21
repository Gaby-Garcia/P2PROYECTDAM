import 'dart:async';

import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  final Function(Map<String, String>) onAddPost;
  final String username;

  PostScreen({required this.onAddPost, required this.username});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  bool _showPostAddedMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Post'),
        backgroundColor: Colors.blueGrey[200], // Color de fondo de la barra de navegación
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF232D4B), // Federal Blue
              Color(0xFF1976D2), // Marian Blue
            ],
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'NOMBRE:', // Label para el nombre de usuario
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial', // Fuente diferente y divertida
                color: Colors.white, // Nuevo color del texto
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.username, // Nombre de usuario
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Arial', // Fuente diferente y divertida
                color: Colors.white, // Nuevo color del texto
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _descriptionController,
              style: TextStyle(color: Colors.white), // Color del texto de los campos
              decoration: InputDecoration(
                labelText: 'Descripción',
                labelStyle: TextStyle(color: Colors.white), // Color del texto del label
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0), // Bordes redondeados
                  borderSide: BorderSide(color: Colors.greenAccent), // Color del borde
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _placeController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Lugar',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _imageUrlController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Imagen',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                String description = _descriptionController.text;
                String place = _placeController.text;
                String imageUrl = _imageUrlController.text;

                if (description.isNotEmpty &&
                    place.isNotEmpty &&
                    imageUrl.isNotEmpty) {
                  widget.onAddPost({
                    'description': description,
                    'place': place,
                    'imageUrl': imageUrl,
                    'userName': widget.username,
                  });

                  _descriptionController.clear();
                  _placeController.clear();
                  _imageUrlController.clear();

                  // Mostrar el mensaje de "Post agregado" durante 2 segundos
                  setState(() {
                    _showPostAddedMessage = true;
                  });
                  Timer(Duration(seconds: 2), () {
                    setState(() {
                      _showPostAddedMessage = false;
                    });
                  });
                } else {
                  // Mostrar un diálogo de advertencia si algún campo está vacío
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Campos vacíos'),
                      content: Text('Por favor, completa todos los campos.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: Icon(Icons.add), // Icono de +
              label: Text(
                'Agregar',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Arial', // Fuente diferente y divertida
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent, // Nuevo color de fondo del botón
                onPrimary: Colors.black, // Nuevo color del texto del botón
                padding: EdgeInsets.symmetric(vertical: 15.0), // Espaciado interno
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0), // Bordes redondeados
                ),
              ),
            ),
            if (_showPostAddedMessage)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Post added',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 16.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
