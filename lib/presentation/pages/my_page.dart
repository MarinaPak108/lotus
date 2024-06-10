import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/doctor_dto.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
import 'package:sm_project/presentation/pages/patient_card_detailed.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/card.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;
import 'package:sm_project/presentation/widgets/tap_sctions.dart';
import 'package:sm_project/presentation/widgets/tile.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width / 10;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          MyCard(
              fillWith: SizedBox(
            width: width * 9,
            child: Text("${global.userId},\n добро пожаловать в LotusMedi App",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: global.globalHeight * 0.6)),
          )),
          SizedBox(
            height: width * 0.1,
          ),
          Expanded(child: buildTap()),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

Doctor doc1 = global.doctors[0];
Doctor doc2 = global.doctors[1];
Doctor doc3 = global.doctors[2];

Widget buildTap() => MyTapSections(
    text1: "${doc1.name}\n${doc1.surname}",
    text2: "${doc2.name}\n${doc2.surname}",
    text3: "${doc3.name}\n${doc3.surname}",
    widget1: buildPosts(doc1.patients),
    widget2: buildPosts(doc2.patients),
    widget3: buildPosts(doc3.patients));

Widget buildPosts(List<Visitor>? visits) => ListView.separated(
    scrollDirection: Axis.vertical,
    padding: const EdgeInsets.all(3),
    itemCount: visits!.length,
    separatorBuilder: (context, index) {
      return const SizedBox(height: 1);
    },
    itemBuilder: (context, index) {
      final visit = visits[index];
      return MyTile(
          icn: Icons.person_2_rounded,
          color: visit.getColor(),
          page: PatientCardDetailsPage(
            visitor: visit,
          ),
          title: "${visit.surname} ${visit.name} ${visit.fathersName}",
          subTitle:
              "дата рождения:${visit.getBirthDate()}\nвозраст:${visit.age}",
          actionIcn: Icons.navigate_next);
    });
