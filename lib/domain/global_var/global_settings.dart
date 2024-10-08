library globals;

import 'package:sm_project/api/dto/doctor_dto.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';

int navBottmBarIndex = 2;
String userId = "user";
int currentUserId = 0;
double globalWidth = 0.0;
double globalHeight = 0.0;
Visitor currentVisitor = Visitor(
    id: -1,
    name: "",
    surname: "",
    fathersName: "",
    birthday: DateTime(0000, 00, 00));
List<Visitor> visitors = List.empty(growable: true);
List<Doctor> doctors = List.empty(growable: true);
