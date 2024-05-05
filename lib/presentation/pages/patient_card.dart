import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/post_dto.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/card.dart';

class PatientCardPage extends StatelessWidget {
  final Post pst;
  const PatientCardPage({Key? key, required this.pst}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
          child: Column(
        children: [
          MyCard(
              fillWith: Text(
            pst.title,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          )),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: MyCard(
                  fillWith: Text(
                pst.body,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              )),
            ),
          )
        ],
      )),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
