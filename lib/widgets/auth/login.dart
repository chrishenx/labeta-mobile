import 'package:labeta/utils/validators.dart';
import 'package:labeta/widgets/auth/single_click_auth.dart';
import 'package:labeta/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:uiblock/uiblock.dart';

class Login extends StatefulWidget {
  final Function onSignUpClick;

  const Login({super.key, required this.onSignUpClick});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>(debugLabel: 'Login Form');

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  Widget buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        validator: Validators.validateEmail,
        decoration: const InputDecoration(
            hintText: 'someone@example.com', labelText: 'Email'),
      ),
    );
  }

  Widget buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        decoration: const InputDecoration(
            hintText: 'Password', labelText: 'Type your password'),
        obscureText: true,
        validator: Validators.validatePassword,
      ),
    );
  }

  Widget buildLoginButton() {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: const Text('Login'),
              )),
        )
      ],
    );
  }

  Widget buildAlreadyLoginRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Text("Don't have an account?"),
        TextButton(
            onPressed: () {
              widget.onSignUpClick();
                        },
            child: const Text('Sign up here!'))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo_large.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                buildEmailInput(),
                buildPasswordInput(),
                buildLoginButton(),
                buildAlreadyLoginRow(),
                SingleClickAuth(
                    onSignInStarted: () => UIBlock.block(context,
                        customLoaderChild: const DefaultLoader()),
                    onSignInCompleted: () => UIBlock.unblock(context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
