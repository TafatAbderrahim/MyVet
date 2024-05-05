import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:project/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
        return MyWidget();
      }));
    });
  }

  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage('assets/background.jpeg',),fit: BoxFit.cover)
        ),
        child: Center(
          child: Image.asset('assets/whit_logo_Mesa de trabajo 1 1.png'),
        ),
      ),
    );
  }
}