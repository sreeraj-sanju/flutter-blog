import 'dart:io';
import 'package:blog/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';
import '../models/api_response.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';
import 'login.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
   // VARIABLE USED FOR TAKING THE VALUES
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController blogData = TextEditingController();
  bool loading = false;

  File ? _imageFile;
  final picker = ImagePicker();

  Future getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() async {
    String? image = _imageFile == null ? null:getStringImage(_imageFile);
    ApiResponse response = await createPost(blogData.text, image);
    if(response.error == null){
      Navigator.of(context).pop();
    }else if(response.error == unauthorized){
      logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()), (route) => false)
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${response.error}"),
        ));
        setState(() {
          loading = !loading;
        });
    }
  }
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
      body: loading ? const Center(child: CircularProgressIndicator(),) : ListView(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              image: _imageFile == null ? null : DecorationImage(
                image: FileImage(_imageFile ?? File('')),
                fit: BoxFit.cover
              )
            ),
            child: Center(
              child: IconButton(onPressed: (){
                getImage();
              }, icon: const Icon(Icons.image, size: 50, color:Colors.black45)),
            ),
          ),
          Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (val)=>val!.isEmpty ? 'Enter something' : null,
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                decoration: const InputDecoration(
                  hintText: "Write Something...",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black12))
                ),
              ),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: srButton('Post', (){
             if(formkey.currentState!.validate()){
              _createPost();
              setState(() {
                 loading = !loading;
               });
              };
            }),
          )
        ],
      ),
    );
  }
}