import 'package:sm_project/api/dto/doctor_dto.dart';

class Visitor {
  final int id;
  final String name;
  final String surname;
  final DateTime birthday;
  int? age;
  List<Doctor>? doctors;

  Visitor({
    required this.id,
    required this.name,
    required this.surname,
    required this.birthday,
    this.age,
    this.doctors,
  });
}
