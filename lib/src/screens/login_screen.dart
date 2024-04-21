import 'package:flutter/material.dart';
import 'package:proyect2p/src/bloc/bloc.dart';
import 'Cards.dart';

class LoginScreen extends StatelessWidget {
  final bloc = Bloc();
  final Map<String, String> users = {
    "garciagaby839@gmail.com": "Gaby Garcia",
    "Laura27@gmail.com": "Laura Garcia",
    "JairEmmanuel@gmail.com": "Jair Emmanuel"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TECBOOK'),
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
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121212), // Negro oscuro
              Color(0xFF1E1E1E), // Gris oscuro
            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'WELCOME TO TECBOOK ',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                        color: Color(0xFFBB86FC), // Morado
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    TextSpan(
                      text: '\nGABRIELA GARCIA ',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBB86FC),
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                'LOGIN:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[800], // Blanco medio oscuro
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'USER:',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                        onChanged: bloc.changeEmail,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'PASSWORD:',
                          labelStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                        onChanged: bloc.changePassword,
                        obscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          String email = bloc.currentEmail;
                          String password = bloc.currentPassword;
                          String username = users[email] ?? "";

                          if ((email == "garciagaby839@gmail.com" &&
                                  password == "gaby208") ||
                              (email == "Laura27@gmail.com" &&
                                  password == "isela027") ||
                              (email == "JairEmmanuel@gmail.com" &&
                                  password == "JairEmmanuel8")) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Inicio de sesión exitoso'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CardsScreen(username: username),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error de autenticación"),
                                  content: Text(
                                      "Credenciales incorrectas. Por favor, inténtalo de nuevo."),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text('Entrar'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF64FFDA), // Cyan
                          onPrimary: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
