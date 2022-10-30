
import 'package:flutter/material.dart';

import '../Home/home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    //it is a function  run for first time when your app or class gets called.
    super.initState();
   _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
      Duration(milliseconds: 5500),
      () {},
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         const  SizedBox(
            height: 60,
          ),
          Container(
              child: const Icon(Icons.whatsapp,
                  size: 90, color: Color.fromARGB(255, 39, 211, 105))),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                child: const Text(
                  "from",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                child: const Center(
                  child: Text(
                    "Meta",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 39, 211, 105)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
