import 'package:blog/models/api_response.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
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

  // FUNCTION FOR LOGIN API CALL
  void _LoginUser() async{
    ApiResponse response = await login(txtEmail.text, password.text);
    
    if(response.error==null){
       Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("$response.error"),
        ));
    }
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
        child: ListView(
          padding: const EdgeInsets.all(30),
          children:[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
              validator: (val)=> val!.isEmpty ? "Invalid Eamil Address": null,
              decoration: textInputDecor('Email')
            ),
            const SizedBox(height: 10,),
            TextFormField(
              obscureText: true,
              controller: password,
              validator: (val)=> val!.isEmpty ? "Required atleast 4 characters": null,
              decoration: textInputDecor('Password')
            ),
            const SizedBox(height: 10,),
            srButton('Login', (){
              if(formkey.currentState!.validate()){
                
              }
            }),
            const SizedBox(height: 10,),
            srLogRegHint("Don't have an account?", " Register", (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Register()), (route)=>false);
            })
          ]
        )
      ),
    );
  }
}
