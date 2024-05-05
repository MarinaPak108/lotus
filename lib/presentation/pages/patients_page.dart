import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/post_dto.dart';
import 'package:sm_project/api/requests/post_requests.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/presentation/pages/patient_card.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/card.dart';
import 'package:sm_project/presentation/widgets/tile.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class PatientsPage extends StatefulWidget {
  const PatientsPage({Key? key}) : super(key: key);

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  Future<List<Post>> posts = getPosts();
  @override
  void initState() {
    super.initState();
  }

  static Future<List<Post>> getPosts() async {
    return PostRequest().getPosts();
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
            height: 20,
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
                      final posts = snapshot.data!;
                      return buildPosts(posts);
                    } else {
                      return const Text('Not post data');
                    }
                  })),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget buildPosts(List<Post> posts) => ListView.separated(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(3),
      itemCount: posts.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 1);
      },
      itemBuilder: (context, index) {
        final pst = posts[index];
        return MyTile(
            icn: Icons.person_2_rounded,
            page: PatientCardPage(
              pst: pst,
            ),
            title: pst.userId.toString(),
            subTitle: pst.title,
            actionIcn: Icons.navigate_next);
      });
}
