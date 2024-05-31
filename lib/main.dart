import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:labeta/services/auth.dart';
import 'package:labeta/utils/logger.dart';
import 'package:labeta/widgets/auth_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
   try {
     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
     FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
   } catch (e) {
     Logger.error(e.toString());
   }
 }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthService.userStream,
      child: MaterialApp(
        title: 'LaBeta',
        theme: ThemeData(
          primaryColor: Colors.lime[900],
          primarySwatch: Colors.lime,
          colorScheme: const ColorScheme.light().copyWith(secondary: Colors.blue[500]),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

