import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteapp/home.dart';
import 'package:noteapp/providers.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return

         AnimatedSplashScreen(
          splash: Container(

            decoration: BoxDecoration(

                image: DecorationImage(
                    image:AssetImage('assets/splash_screen_res/splash3.jpg'),
                    fit: BoxFit.cover
                )
            ),
              child: Lottie.asset('assets/splash_screen_res/note.json'),
            ),

          nextScreen: home(),
          pageTransitionType: PageTransitionType.fade,
          duration: 4000,
          splashIconSize: double.infinity,
          splashTransition: SplashTransition.fadeTransition,
          curve: Curves.easeInToLinear,
      
          animationDuration: Duration(seconds:4),

    );
  }
}


