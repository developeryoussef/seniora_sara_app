import 'package:flutter/material.dart';
import 'package:seniora_sara/configs/configs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: kPrimayLightColorLT),
        child: Image.asset('assets/Picture1.png'),
      ),
    );
  }
}
