import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_project/presentation/pages/home_page.dart';
import 'package:sm_project/presentation/pages/login_page.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Splash();
  }
}

class _Splash extends StatefulWidget {
  const _Splash({super.key});

  @override
  State<_Splash> createState() => _SplashState();
}

class _SplashState extends State<_Splash> {
  late bool userIsLoggedIn;
  late SharedPreferences prefs;

  getLoggedInState() async {
    prefs = await SharedPreferences.getInstance();
    final bool? isSigned;
    if (prefs.containsKey("isSteySinged")) {
      isSigned = prefs.getBool("isSteySinged");
    } else {
      isSigned = false;
    }
    setState(() {
      if (isSigned == null) isSigned == false;
      userIsLoggedIn = isSigned!;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoggedInState();
    Future.delayed(const Duration(seconds: 2), _routeUser);
  }

  void _routeUser() {
    //if user is stay logged in
    if (userIsLoggedIn) {
      if (prefs.containsKey("login")) {
        global.userId = prefs.getString("login")!;
      }
      //Navigator.push() esli nujno nazad na stranicu wernutsja tak kak on zagrujaet power predidushei stranici = sohranjaet predidushuju stranicu
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (cxt) => const HomePage()));
    }
    //if stay logged in => redirect to home page
    else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (cxt) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    global.globalWidth = MediaQuery.sizeOf(context).height / 10;
    global.globalHeight = MediaQuery.sizeOf(context).width / 10;
    return Scaffold(
        body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Image.asset(
              'assets/img/splash.jpg',
              fit: BoxFit.fitHeight,
            )));
  }
}
