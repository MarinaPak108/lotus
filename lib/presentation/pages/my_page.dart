import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/card.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

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
            child: Text("${global.userId}, welcome to LotusMedi App",
                style: const TextStyle(color: Colors.white, fontSize: 30)),
          )),
          const SizedBox(
            height: 10,
          ),
          _tabSection(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

Widget _tabSection(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TabBar(
          tabs: [
            Tab(text: "Home"),
            Tab(text: "Articles"),
            Tab(text: "User"),
          ],
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.white,
          labelColor: AppStyles.logoColor,
          labelStyle: TextStyle(
              color: AppStyles.logoColor,
              fontSize: 30,
              fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              TextStyle(fontSize: 17, fontFamily: 'Family Name'),
        ),
        SizedBox(
          //Add this to give height
          height: MediaQuery.of(context).size.height * 0.5,
          child: TabBarView(children: [
            Container(
              child: Text("Home Body"),
            ),
            Container(
              child: Text("Articles Body"),
            ),
            Container(
              child: Text("User Body"),
            ),
          ]),
        ),
      ],
    ),
  );
}
