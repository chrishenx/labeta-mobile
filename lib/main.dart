import 'package:labeta/services/auth.dart';
import 'package:labeta/widgets/auth_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthService.userStream,
      child: MaterialApp(
        title: 'DevelBoulder',
        theme: ThemeData(
          primaryColor: Colors.lime[900],
          primarySwatch: Colors.lime,
          colorScheme: ColorScheme.dark().copyWith(secondary: Colors.blue[500]),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

