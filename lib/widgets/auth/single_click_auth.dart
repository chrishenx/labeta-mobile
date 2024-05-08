import 'package:labeta/services/auth.dart';
import 'package:labeta/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SingleClickAuth extends StatelessWidget {
  final Function onSignInStarted;
  final Function onSignInCompleted;

  const SingleClickAuth({super.key, required this.onSignInCompleted, required this.onSignInStarted});

  @override
  Widget build(BuildContext context) {
    const iconsSize = 30.0;

    return Container(
      child: Column(children: [
        const Text('-- Or enter using --'),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              icon: const Icon(FontAwesomeIcons.facebook),
              iconSize: iconsSize,
              color: Colors.blue[600],
              onPressed: () {}),
          const IconButton(
              icon: Icon(FontAwesomeIcons.google),
              iconSize: iconsSize,
              onPressed: null),
          IconButton(
              icon: const Icon(FontAwesomeIcons.userSecret),
              iconSize: iconsSize,
              tooltip: 'Anounymous user',
              onPressed: () async {
                onSignInStarted.call();
                Logger.log('Signing in anonymous user...');
                final user = await AuthService.signInAnonymously();
                if (user != null) {
                  Logger.log(
                      'Anonymous user "${user.uid}" signed at ${user.metadata.creationTime}.');
                } else {
                  Logger.error('Could not sign in anonymous user.');
                }
                onSignInCompleted.call();
              }),
        ]),
      ]),
    );
  }
}
