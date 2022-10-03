import 'package:blog/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // VARIABLE USED FOR TAKING THE VALUES
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController usrName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;
  // FUNCTION FOR LOGIN API CALL
  void _RegisterUser() async{
    ApiResponse response = await register(usrName.text, txtEmail.text, password.text);
    
    if(response.error==null){
       _saveAndRedirectToHome(response.data as User);
    }else{
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${response.error}"),
        ));
    }
  }
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('token', user.token ?? 0);
    // await pref.setInt('token', user.id ?? 0);
     // ignore: use_build_context_synchronously
     Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()), (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(30),
          children:[
            TextFormField(
              keyboardType: TextInputType.name,
              controller: usrName,
              validator: (val)=> val!.isEmpty ? "Enter Your Name": null,
              decoration: textInputDecor('Name')
            ),

            const SizedBox(height: 10,),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
              validator: (val)=> val!.isEmpty ? "Enter E-mail Address": null,
              decoration: textInputDecor('Email')
            ),

            const SizedBox(height: 10,),

            TextFormField(
              obscureText: true,
              controller: password,
              validator: (val)=> val!.isEmpty ? "Enter The Password": null,
              decoration: textInputDecor('Password')
            ),

            const SizedBox(height: 10,),
            
            loading ? const Center(child: CircularProgressIndicator(
              backgroundColor: Colors.white70,
            ),):
            srButton('Register', (){
              if(formkey.currentState!.validate()){
                setState(() {
                  loading = true;
                   _RegisterUser();
                });
              }
            }),
            const SizedBox(height: 10,),
            srLogRegHint("Already have an account?", " Login", (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route)=>false);
            })
          ]
        )
      ),
    );
  }
}
