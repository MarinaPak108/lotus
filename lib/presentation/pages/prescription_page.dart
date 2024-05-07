import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sm_project/api/dto/post_dto.dart';
import 'package:sm_project/api/requests/post_requests.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/card.dart';

import '../widgets/bottom_navigation.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({Key? key}) : super(key: key);

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  Post? _selectedPost;
  Future<List<Post>> posts = getPosts();
  @override
  void initState() {
    super.initState();
  }

  static Future<List<Post>> getPosts() async {
    return await PostRequest().getPostsByUserId();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height / 10;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.3,
          ),
          FutureBuilder<List<Post>>(
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
                return buildDropBox(posts, height);
              } else {
                return const Text('Not post data');
              }
            },
          ),
          SizedBox(
            height: height * 0.3,
          ),
          Builder(builder: (context) {
            if (_selectedPost == null) {
              return Container();
            } else {
              return Expanded(
                child: SingleChildScrollView(
                  child: MyCard(
                      fillWith: Text(
                    _selectedPost!.body,
                    style: TextStyle(
                      fontSize: height * 0.4,
                      color: Colors.white,
                    ),
                  )),
                ),
              );
            }
          })
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget buildDropBox(List<Post> posts, double height) => Container(
        height: height * 1.5,
        padding: EdgeInsets.all(height * 0.3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height * 0.4),
            border: Border.all(
                color: AppStyles.logoComplimentaryColor2,
                style: BorderStyle.solid,
                width: height * 0.05)),
        child: DropdownButton<Post>(
          menuMaxHeight: height * 4,
          isExpanded: true,
          //isDense: true,
          hint: const Text('Choose'),
          value: _selectedPost,
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
          ),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(
            color: Colors.deepPurple,
          ),
          onChanged: (Post? newValue) {
            setState(() {
              _selectedPost = newValue!;
            });
          },
          items: posts.map<DropdownMenuItem<Post>>((Post value) {
            return DropdownMenuItem<Post>(
              value: value,
              child: Flexible(
                child: LimitedBox(
                  maxWidth: height * 2,
                  child: Text(
                    "${value.id}_${value.title}",
                    maxLines: 2,
                    style: TextStyle(fontSize: height * 0.3),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
}
