import 'package:blog/screens/home.dart';
import 'package:flutter/material.dart';

import '../services/user_service.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions: [
          IconButton(onPressed: (){
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Home()), (route) => false);
          }, icon: const Icon(Icons.arrow_back))
        ],
        title: const Text('Add A New Post'),
      ),
    );
  }
}