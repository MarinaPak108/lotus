import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/doctor_dto.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/card.dart';

class DoctorCardDetailsPage extends StatelessWidget {
  final Doctor doctor;
  const DoctorCardDetailsPage({Key? key, required this.doctor})
      : super(key: key);

  get bottomNavigationBar => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: MyCard(fillWith: Text("${doctor.surname} ${doctor.name}")),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
