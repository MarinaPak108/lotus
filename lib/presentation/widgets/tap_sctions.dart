import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class MyTapSections extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;
  const MyTapSections(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.widget1,
      required this.widget2,
      required this.widget3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            tabs: [
              Tab(text: text1),
              Tab(text: text2),
              Tab(text: text3),
            ],
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            labelColor: AppStyles.logoColor,
            labelStyle: TextStyle(
                color: AppStyles.logoColor,
                fontSize: AppStyles.title1,
                fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
                fontSize: AppStyles.title1, fontFamily: 'Family Name'),
          ),
          Expanded(
            child: Container(
              //Add this to give height
              //height: MediaQuery.of(context).size.height * 0.4,
              child: TabBarView(children: [
                widget1,
                widget2,
                widget3,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
