import 'package:labeta/services/auth.dart';
import 'package:labeta/widgets/new_boulder/basic_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DevelBoulder'),
        actions: [
          TextButton(
              onPressed: null,
              child: Text(
                  user.isAnonymous
                      ? 'Anonymous user'
                      : user.displayName ?? user.email ?? 'Unknown user',
                  textScaler: const TextScaler.linear(0.8),
                  style: const TextStyle(fontStyle: FontStyle.italic))),
          IconButton(
              icon: const Icon(FontAwesomeIcons.rightFromBracket),
              onPressed: () => {AuthService.signOut()}),
        ],
      ),
      body: Container(
        child: const Center(child: Text('Die climbing!', textScaler: TextScaler.linear(2.0))),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return NewBoulderBasicInput(
              onCancel: () {
                // TODO: Check if this is needed or not
                // Navigator.popUntil(context, (route) => route.isFirst);
              },
            );
          }))
        },
        iconSize: 40,
      ),
    );
  }
}