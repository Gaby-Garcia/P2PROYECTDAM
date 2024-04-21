import 'package:flutter/material.dart';
import 'package:proyect2p/src/screens/Api.dart';
import 'package:proyect2p/src/screens/Post.dart';
import 'package:proyect2p/src/models/api.dart';

class CardsScreen extends StatefulWidget {
  final String username;

  CardsScreen({required this.username});

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  List<Map<String, String>> _posts = [];

  void _deletePost(int index) {
    setState(() {
      _posts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TECBOOK'),
        backgroundColor:
            Colors.blueGrey[200], // Color de la barra de navegación
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pacifico',
          color: Colors.black,
          shadows: [
            Shadow(
              color: Colors.white.withOpacity(0.5),
              offset: Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
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
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_posts[index]['userName'] ?? ''),
                            Text(_posts[index]['place'] ?? ''),
                            Text(_posts[index]['description'] ?? ''),
                          ],
                        ),
                        leading: SizedBox(
                          height: 150.0,
                          width: 150.0,
                          child: Image.network(
                            _posts[index]['imageUrl'] ?? '',
                            fit: BoxFit.cover, 
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletePost(index);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 10.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () async {
                Map<String, String>? newPost = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostScreen(
                        onAddPost: _addPost, username: widget.username),
                  ),
                );
                if (newPost != null) {
                  _addPost(newPost);
                }
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MarvelScreen()),
          );
        },
        child: Text("API"), // Icono del nuevo botón
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _addPost(Map<String, String> post) {
    post['userName'] = widget.username;
    setState(() {
      _posts.add(post);
    });
  }
}
