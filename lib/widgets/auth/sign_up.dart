import 'package:labeta/utils/validators.dart';
import 'package:labeta/widgets/auth/single_click_auth.dart';
import 'package:labeta/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:uiblock/uiblock.dart';

class SignUp extends StatefulWidget {
  final Function onLoginClick;

  const SignUp({super.key, required this.onLoginClick});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>(debugLabel: 'Sign Up Form');
  final TextEditingController passwordController = TextEditingController();

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  Widget buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        validator: Validators.validatePassword,
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
        controller: passwordController,
        validator: Validators.validatePassword,
      ),
    );
  }

  Widget buildConfirmPasswordInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        decoration: const InputDecoration(
            hintText: 'Confirm password', labelText: 'Confirm your password'),
        obscureText: true,
        validator: (value) =>
            value != passwordController.text ? 'Passwords must match' : null,
      ),
    );
  }

  Widget buildSignUpButton() {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: const Text('Sign Up'),
              )),
        )
      ],
    );
  }

  Widget buildAlreadySignUpRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Text('Already signed up?'),
        TextButton(
            onPressed: () {
              widget.onLoginClick();
                        },
            child: const Text('Login here!'))
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
                buildConfirmPasswordInput(),
                buildSignUpButton(),
                buildAlreadySignUpRow(),
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
