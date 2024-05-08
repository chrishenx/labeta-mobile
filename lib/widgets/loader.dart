import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DefaultLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
    );
  }
}
