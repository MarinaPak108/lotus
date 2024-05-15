import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/post_dto.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
import 'package:sm_project/api/requests/post_requests.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/presentation/pages/patient_card_detailed.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/card.dart';
import 'package:sm_project/presentation/widgets/tap_sctions.dart';
import 'package:sm_project/presentation/widgets/tile.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class PatientsPage extends StatefulWidget {
  const PatientsPage({Key? key}) : super(key: key);

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  Future<List<Post>> posts = getPosts();
  Iterable<Visitor> visitorsDoctor = global.visitors.where((element) =>
      element.doctor != null &&
      element.results == null &&
      element.prescription == null);
  Iterable<Visitor> visitorsForm = global.visitors.where(
      (element) => element.results != null && element.prescription == null);
  Iterable<Visitor> finishedVisitors =
      global.visitors.where((element) => element.prescription != null);
  @override
  void initState() {
    super.initState();
  }

  static Future<List<Post>> getPosts() async {
    return PostRequest().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    double width = global.globalWidth;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          //obshaja informacija o kolichestwe pacientow, teh kotorie doljni
          //eshe zapolnit formu i teh kto eshe ne popal na priem
          MyCard(
              fillWith: SizedBox(
            width: width * 9,
            child: Text(
                "Количество пациентов: ${global.visitors.length}\nОжидание на заполнение формы: ${visitorsDoctor.length}\nОжидание на прием:${visitorsForm.length}\nЗавершили прием:${finishedVisitors.length}",
                style: TextStyle(color: Colors.white, fontSize: width * 0.3)),
          )),
          Expanded(
            child: FutureBuilder<List<Post>>(
                future: posts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: AppStyles.logoComplimentaryColor2),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (snapshot.hasData) {
                    //final posts = snapshot.data!;
                    return buildTap();
                  } else {
                    return const Text('Not post data');
                  }
                }),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget buildTap() => MyTapSections(
      text1: "ФОРМА",
      text2: "ПРИЕМ",
      text3: "ЗАВЕРШЕНО",
      widget1: buildPosts(visitorsDoctor),
      widget2: buildPosts(visitorsForm),
      widget3: buildPosts(finishedVisitors));

  Widget buildPosts(Iterable<Visitor> visits) => ListView.separated(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(3),
      itemCount: visits.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 1);
      },
      itemBuilder: (context, index) {
        final visit = visits.elementAt(index);
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
}
