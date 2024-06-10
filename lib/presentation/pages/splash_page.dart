import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_project/api/dto/doctor_dto.dart';
import 'package:sm_project/api/dto/formResults_dto.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
import 'package:sm_project/presentation/pages/home_page.dart';
import 'package:sm_project/presentation/pages/login_page.dart';

import 'package:shimmer/shimmer.dart';

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
  List<Doctor> docs = [
    Doctor(id: 0, surname: "Krueger", field: "Ophthalmology", name: "Raya"),
    Doctor(id: 1, surname: "Huff", field: "Cardiology", name: "Hakeem"),
    Doctor(id: 2, surname: "Bernal", field: "Pediatrics", name: "Bowen")
  ];
  List<Visitor> vists = [
    Visitor(
        id: 0,
        name: "Никита",
        surname: "Петров",
        fathersName: "Гордеевич",
        birthday: DateTime(2003, 06, 12)),
    Visitor(
        id: 1,
        name: "Полина",
        surname: "Кузьмина",
        fathersName: "Максимовна",
        birthday: DateTime(1999, 04, 13)),
    Visitor(
        id: 2,
        name: "Илья",
        surname: "Коновалов",
        fathersName: "Николаевич",
        birthday: DateTime(1987, 07, 03)),
    Visitor(
        id: 3,
        name: "Ульяна",
        surname: "Минина",
        fathersName: "Эмировна",
        birthday: DateTime(1953, 04, 09)),
    Visitor(
      id: 4,
      name: "Ксения",
      surname: "Костина",
      fathersName: "Артёмовна",
      birthday: DateTime(1974, 09, 18),
    ),
    Visitor(
        id: 5,
        name: "Евгения",
        surname: "Иванова",
        fathersName: "Никитична",
        birthday: DateTime(1998, 10, 13)),
    Visitor(
        id: 6,
        name: "Евгения",
        surname: "Иванова",
        fathersName: "Никитична",
        birthday: DateTime(1977, 12, 22)),
    Visitor(
        id: 7,
        name: "Ксения",
        surname: "Наумова",
        fathersName: "Андреевна",
        birthday: DateTime(1934, 01, 07)),
    Visitor(
      id: 8,
      name: "Андрей",
      surname: "Александров",
      fathersName: " Дмитриевич",
      birthday: DateTime(2013, 03, 08),
    ),
    Visitor(
        id: 9,
        name: "Эмилия",
        surname: "Тихонова",
        fathersName: "Владиславовна",
        birthday: DateTime(1938, 11, 14)),
  ];
  String phraseOfTheDay =
      '"Жизнь - это то, что с тобой происходит, пока ты строишь планы."\nДжон Леннон';

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
    Future.delayed(const Duration(seconds: 10), _routeUser);
  }

  countYear(DateTime birthday) {
    int result = DateTime.now().year - birthday.year;
    if (DateTime.now().month < birthday.month) {
      return result - 1;
    } else if (DateTime.now().month == birthday.month) {
      if (DateTime.now().day < birthday.day) {
        return result - 1;
      }
    } else {
      return result;
    }
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
    global.doctors = docs;
    global.visitors = vists;
    //count age and save
    global.visitors[0].age = countYear(global.visitors[0].birthday);
    global.visitors[1].age = countYear(global.visitors[1].birthday);
    global.visitors[2].age = countYear(global.visitors[2].birthday);
    global.visitors[3].age = countYear(global.visitors[3].birthday);
    global.visitors[4].age = countYear(global.visitors[4].birthday);
    global.visitors[5].age = countYear(global.visitors[5].birthday);
    global.visitors[6].age = countYear(global.visitors[6].birthday);
    global.visitors[7].age = countYear(global.visitors[7].birthday);
    global.visitors[8].age = countYear(global.visitors[8].birthday);
    global.visitors[9].age = countYear(global.visitors[9].birthday);

    //add doctors to visitors
    global.visitors[0].doctor = global.doctors[0];
    global.visitors[1].doctor = global.doctors[2];
    global.visitors[2].doctor = global.doctors[1];
    //add formresults to visitor 0
    global.visitors[0].results = FormResults(question: [
      "Цель обращения",
      "Вид обращения",
      "Уровень оказания медицинской помощи"
    ], answer: [
      'профилактическая и иная',
      'медосмотр',
      'территориальный'
    ]);
    //add formresults to visitor 2
    global.visitors[2].results = FormResults(question: [
      "Цель обращения",
      "Вид обращения",
      "Уровень оказания медицинской помощи"
    ], answer: [
      'профилактическая и иная',
      'медосмотр',
      'территориальный'
    ]);
    //add prescription to visitor 2
    global.visitors[2].prescription =
        "принимать лекарство 2 раза в день по 1 таблетке";
    //add visitors to doctors:
    global.doctors[0].patients = [global.visitors[0]];
    global.doctors[2].patients = [global.visitors[1]];
    global.doctors[1].patients = [global.visitors[2]];
    return Scaffold(
        body: Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/splash.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.blueAccent,
            child: Text(
              phraseOfTheDay,
              textAlign: TextAlign.center,
              style: GoogleFonts.lobster(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
