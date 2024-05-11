import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sm_project/api/dto/doctor_dto.dart';
import 'package:sm_project/api/dto/formResults_dto.dart';

class Visitor {
  final int id;
  final String name;
  final String surname;
  final DateTime birthday;
  int? age;
  List<Doctor>? doctors;
  FormResults? results;
  List<String>? prescription;

  Visitor(
      {required this.id,
      required this.name,
      required this.surname,
      required this.birthday,
      this.age,
      this.doctors,
      this.results,
      this.prescription});

  getDoctors() {
    if (doctors == null || doctors!.isEmpty) {
      return "в ожидании на посещение врача";
    } else {
      return "";
    }
  }

  getBirthDate() {
    return DateFormat('yyyy-MM-dd').format(birthday);
  }

  getColor() {
    if (doctors != null) {
      return const Color.fromARGB(248, 243, 26, 26);
    } else if (results != null) {
      return const Color.fromARGB(249, 217, 230, 40);
    } else if (prescription != null &&
        doctors!.length == prescription!.length) {
      return const Color.fromARGB(248, 40, 230, 53);
    } else {
      return const Color.fromRGBO(243, 245, 245, 0.973);
    }
  }

  getResults() {
    if (results == null || results!.question!.isEmpty) {
      return 0;
    } else {
      return results!.question!.length;
    }
  }
}
