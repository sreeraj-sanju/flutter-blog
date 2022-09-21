//Routes
import 'package:flutter/material.dart';

// const baseUrl = "http://localhost:8000/api";
const baseUrl = "http://52.37.80.33/api";
const loginUrl = "$baseUrl/blog_login";
const registerUrl = "$baseUrl/register";
const userUrl = "$baseUrl/get_user";
const getPostUrl = "$baseUrl/getPost";
const createPostUrl = "$baseUrl/createPost";

//Errors
const serviceError = "Server Error";
const unauthorized = 'login failed';

// DECORATION FUNCTION
InputDecoration textInputDecor(String label){
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(borderSide: BorderSide(width: 1, ))
  );
} 

// BUTTON STYLING
ElevatedButton srButton(String label, Function onPressed){
  return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10))
      ),
      onPressed: ()=> onPressed(),
      child: Text(label, style: const TextStyle(color: Colors.white),), 
    );
}

// LOGIN REGISTER HINT
Row srLogRegHint(String text, String label, Function onTap){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(text),
    GestureDetector(
      child: Text(label, style: const TextStyle(color: Colors.blue)),
      onTap: () => onTap()
    )
  ],
  );
}