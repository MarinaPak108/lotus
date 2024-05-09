import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_project/api/dto/doctor_dto.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
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

  List<Doctor> docs = [
    Doctor(id: 0, surname: "Krueger", field: "Ophthalmology", name: "Raya"),
    Doctor(id: 1, surname: "Huff", field: "Cardiology", name: "Hakeem"),
    Doctor(id: 2, surname: "Bernal", field: "Pediatrics", name: "Bowen")
  ];

  List<Visitor> vists = [
    Visitor(
      id: 0,
      name: "Avah",
      surname: "Pace",
      birthday: DateTime(2003, 06, 12),
    ),
    Visitor(
        id: 1,
        name: "Freyja",
        surname: "Patterson",
        birthday: DateTime(1999, 04, 13)),
    Visitor(
        id: 2,
        name: "Jair",
        surname: "Pittman",
        birthday: DateTime(1987, 07, 03)),
    Visitor(
        id: 3,
        name: "Cali",
        surname: "Rangel",
        birthday: DateTime(1953, 04, 09)),
    Visitor(
        id: 4,
        name: "Addyson",
        surname: "Wilkins",
        birthday: DateTime(1974, 09, 18)),
    Visitor(
        id: 5,
        name: "Gustavo",
        surname: "Pitts",
        birthday: DateTime(1998, 10, 13)),
    Visitor(
        id: 6,
        name: "Alianna",
        surname: "McDowell",
        birthday: DateTime(1977, 12, 22)),
    Visitor(
        id: 7, name: "Ruth", surname: "Hill", birthday: DateTime(1934, 01, 07)),
    Visitor(
        id: 8,
        name: "Murphy",
        surname: "Weeks",
        birthday: DateTime(2013, 03, 08)),
    Visitor(
        id: 9,
        name: "Jaylen",
        surname: " Conley",
        birthday: DateTime(1938, 11, 14)),
  ];

  @override
  Widget build(BuildContext context) {
    global.globalWidth = MediaQuery.sizeOf(context).height / 10;
    global.globalHeight = MediaQuery.sizeOf(context).width / 10;
    global.doctors = docs;
    global.visitors = vists;
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
