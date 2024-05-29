import 'package:labeta/widgets/auth/login.dart';
import 'package:labeta/widgets/auth/sign_up.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

enum AuthType { LOGIN, SIGNUP }

class _AuthenticateState extends State<Authenticate>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: [
      Login(onSignUpClick: () => tabController.animateTo(1)),
      SignUp(onLoginClick: () => tabController.animateTo(0))
    ]);
  }
}
