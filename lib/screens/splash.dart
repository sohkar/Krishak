import 'package:flutter/material.dart';
import 'package:krishak/utils/colors_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var size = 160.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        size = 120.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsContants.kDarkGreenColor,
      body: Center(
        child: AnimatedContainer(
          width: size,
          duration: const Duration(milliseconds: 600),
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
      ),
    );
  }
}
