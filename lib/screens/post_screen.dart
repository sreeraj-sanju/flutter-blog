import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  List<dynamic> postList=[];
  int userId = 0;
  bool loading =true;

  // GET ALL POSTS
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Posts")),
    );
  }
}