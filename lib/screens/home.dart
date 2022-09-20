import 'package:flutter/material.dart';

import '../services/user_service.dart';
import 'login.dart';
import 'post_form.dart';
import 'post_screen.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: (){
            logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()), (route) => false)
            });
          }, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: currentIndex == 0 ? PostScreen() : Profile(),
      floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => PostForm()), (route) => false);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label:''
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person),
          label:''
          ),
        ],
        currentIndex: currentIndex,
        onTap: (val){
          setState(() {
            currentIndex = val;
          });
        },
        ),
      ),
    );
  }
}
