import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_project/api/dto/post_dto.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
import 'package:sm_project/api/requests/post_requests.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/presentation/pages/fillForm/chooseVisitor_page.dart';
import 'package:sm_project/presentation/pages/my_page.dart';
import 'package:sm_project/presentation/pages/patient_card_detailed.dart';
import 'package:sm_project/presentation/pages/patients_page.dart';
import 'package:sm_project/presentation/pages/prescription_page.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;
import 'package:sm_project/presentation/widgets/image_btn.dart';
import 'package:sm_project/presentation/widgets/tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  String nameUser = "+++";
  Future<List<Post>> posts = getPosts();
  List<Visitor> visitors = global.visitors;

  getName() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("login")) {
      setState(() {
        nameUser = prefs.getString("login")!;
      });
    }
  }

  logout() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("isSteySinged", false);
    prefs.setString("login", "");
  }

  static Future<List<Post>> getPosts() async {
    return PostRequest().getPosts();
  }

  @override
  void initState() {
    super.initState();
    global.navBottmBarIndex = 2;
    getName();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height / 10;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(13),
              itemCount: listLinks.length,
              separatorBuilder: (context, index) {
                return SizedBox(width: height * 0.5);
              },
              itemBuilder: (context, index) {
                return buildCard(index);
              },
            ),
          ),
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
                      return buildPosts(visitors);
                    } else {
                      return const Text('Not post data');
                    }
                  }))
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

//spisok pacientow
  Widget buildPosts(List<Visitor> visits) => ListView.separated(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(3),
      itemCount: visits.length,
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
            subTitle: "",
            actionIcn: Icons.navigate_next);
      });

  final List pageList = [
    const MyPage(),
    const PatientsPage(),
    const ChooseVisitorPage(),
    const PrescriptionPage()
  ];

  final List globalBottomIconList = [0, 1, 3, 4];

  final List listLinks = [
    "assets/img/personalRoom.jpg",
    "assets/img/peopleWaitingLine.jpg",
    "assets/img/fillForm.jpg",
    "assets/img/prescription.jpg"
  ];
  final List listNames = [
    "личный\nкабинет",
    'список\nожидания',
    "форма для\nзаполнения",
    "рецепт"
  ];

  Widget buildCard(int index) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyImageBtn(
            link: listLinks.elementAt(index),
            label: listNames.elementAt(index),
            idx: globalBottomIconList.elementAt(index),
            page: pageList.elementAt(index),
          ),
        ],
      );
}
