import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rideshareapp/screens/MainPage.dart';




// bool shouldUseFirebaseEmulator = false;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
//   // See related issue: https://github.com/flutter/flutter/issues/96391
//   if (!kIsWeb) {
//     await Firebase.initializeApp();
//   } else {
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//         apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
//         appId: '1:448618578101:web:0b650370bb29e29cac3efc',
//         messagingSenderId: '448618578101',
//         projectId: 'react-native-firebase-testing',
//         authDomain: 'react-native-firebase-testing.firebaseapp.com',
//         databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
//         storageBucket: 'react-native-firebase-testing.appspot.com',
//         measurementId: 'G-F79DJ0VFGS',
//       ),
//     );
//   }
//
//   if (shouldUseFirebaseEmulator) {
//     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
//   }
//
//   runApp(MyApp());
// }


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MainPage(),
    );
  }
}
