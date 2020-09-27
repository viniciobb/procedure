import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:procedure/funcionalidades/RandomWordsList.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initilization Future outside of `build`:

  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    print('*************initializeApp******************');
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text("Error", textDirection: TextDirection.ltr),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('*************carregou !******************');
          return MaterialApp(
            title: 'teste',
            home: RandomWords(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: Text("Loading", textDirection: TextDirection.ltr),
        );
      },
    );
  }
}