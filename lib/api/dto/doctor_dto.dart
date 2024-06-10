import 'package:sm_project/api/dto/visitor_dto.dart';

class Doctor {
  final int id;
  final String surname;
  final String name;
  final String field;
  List<Visitor>? patients;

  Doctor({
    required this.id,
    required this.surname,
    required this.field,
    required this.name,
    this.patients,
  });

  void setPatients(List<Visitor> newPatients) {
    patients = newPatients;
  }
}
