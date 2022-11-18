import 'package:blog/models/api_response.dart';
import 'package:blog/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // VARIABLE USED FOR TAKING THE VALUES
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;
  // FUNCTION FOR LOGIN API CALL
  // ignore: non_constant_identifier_names
  void _LoginUser() async {
    ApiResponse response = await login(txtEmail.text, password.text);

    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Color.fromARGB(255, 100, 34, 29),
      ));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('token', user.token ?? 0);
    // await pref.setInt('token', user.id ?? 0);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Form(
          key: formkey,
          child: ListView(padding: const EdgeInsets.all(30), children: [
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
                validator: (val) =>
                    val!.isEmpty ? "Enter E-mail Address" : null,
                decoration: textInputDecor('Email')),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                obscureText: true,
                controller: password,
                validator: (val) => val!.isEmpty ? "Enter the password" : null,
                decoration: textInputDecor('Password')),
            const SizedBox(
              height: 10,
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white70,
                    ),
                  )
                : srButton('Login', () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                        _LoginUser();
                      });
                    }
                  }),
            const SizedBox(
              height: 10,
            ),
            srLogRegHint("Don't have an account?", " Register", () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Register()),
                  (route) => false);
            })
          ])),
    );
  }
}
