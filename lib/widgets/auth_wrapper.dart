import 'package:labeta/utils/logger.dart';
import 'package:labeta/widgets/auth/authentication.dart';
import 'package:labeta/widgets/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      Logger.log(
          'AuthWrapper - Initial user "${user.uid}" created at ${user.metadata.creationTime}, last signed in at ${user.metadata.lastSignInTime}');
      return const Home();
    }
  }
}
