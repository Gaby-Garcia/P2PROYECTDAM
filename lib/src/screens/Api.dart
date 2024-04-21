import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:proyect2p/src/models/api.dart';

class MarvelScreen extends StatefulWidget {
  @override
  _MarvelScreenState createState() => _MarvelScreenState();
}

class _MarvelScreenState extends State<MarvelScreen> {
  late Future<List<Gif>> _listadoGifs;
  String publicKey = '770ad0590cb9e05c998f2cf5ef9ab044';
  String privateKey = '515d674299105e5d1dff312b40262bc592b0726b';
  String baseUrl = 'https://gateway.marvel.com/v1/public/characters';
  Gif? _selectedGif; // Nuevo estado para almacenar el card seleccionado

  String generateHash(int timestamp) {
    String toHash = '$timestamp$privateKey$publicKey';
    return md5.convert(utf8.encode(toHash)).toString();
  }

  Future<List<Gif>> _getGifs() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String hash = generateHash(timestamp);

    final Uri url = Uri.parse(
        '$baseUrl?apikey=$publicKey&ts=$timestamp&hash=$hash&limit=25');

    final response = await http.get(url);
    List<Gif> gifs = [];

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      for (var item in jsonData["data"]["results"]) {
        final name = item["name"];
        final url = item["thumbnail"]["path"] +
            '.' +
            item["thumbnail"]["extension"];
        final description = item["description"];

        // Check if all required fields are available
        if (name != null && url != null && description != null) {
          gifs.add(Gif(
            name: name,
            description: description,
            url: url,
          ));
        }
      }

      return gifs;
    } else {
      throw Exception("Failed to connect");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoGifs = _getGifs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel'),
        backgroundColor: Colors.red, // Cambiamos el color a rojo, más icónico de Marvel
      ),
      
      body: Container( // Cambiamos el padding por un Container para agregar un fondo
        decoration: BoxDecoration( // Añadimos una decoración para el fondo de la pantalla
          image: DecorationImage(
            image: AssetImage("assets/marvel_background.jpg"), // Ruta de la imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _listadoGifs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error");
              } else {
                final data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _buildGifCard(data[index]);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

 Widget _buildGifCard(Gif gif) {
  return Card(
    elevation: 4,
    margin: EdgeInsets.symmetric(vertical: 8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    color: _selectedGif == gif ? Colors.redAccent : Colors.white70, // Cambiamos el color de fondo de las tarjetas
    child: InkWell(
      onTap: () {
        setState(() {
          _selectedGif = gif;
        });
        _showDetailsDialog(gif);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
            ),
            child: Image.network(
              gif.url,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gif.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    gif.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void _showDetailsDialog(Gif gif) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(gif.name),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Image.network(
                gif.url,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Text(
                gif.description,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}
