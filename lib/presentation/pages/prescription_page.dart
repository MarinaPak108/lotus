import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/post_dto.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
import 'package:sm_project/api/requests/post_requests.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/presentation/pages/home_page.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/btn.dart';
import 'package:sm_project/presentation/widgets/card.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;
import 'package:sm_project/presentation/widgets/input_field.dart';

import '../widgets/bottom_navigation.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({Key? key}) : super(key: key);

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  bool isActive = false;
  Visitor? _selectedPost;
  Future<List<Post>> posts = getPosts();
  final _controller = TextEditingController();
  //get only visitors with filled form and no prespription
  Iterable<Visitor> visitors = global.visitors.where(
      (element) => element.prescription == null && element.results != null);
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final isActive = _controller.text.isNotEmpty;
      setState(() => this.isActive = isActive);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                //final posts = snapshot.data!;
                return buildDropBox(visitors, height);
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
                    child: Padding(
                  padding: EdgeInsets.all(height * 0.1),
                  child: MyInputField(
                    label: "Рецепт",
                    lines: 7,
                    ctrl: _controller,
                  ),
                )),
              );
            }
          }),
          Padding(
            padding: EdgeInsets.all(height * 0.1),
            child: MyBtn(
                name: "Сохранить",
                onPressed: isActive
                    ? () {
                        _selectedPost?.prescription = _controller.text;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    : null),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget buildDropBox(Iterable<Visitor> visitors, double height) => Container(
        padding: EdgeInsets.all(height * 0.3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height * 0.4),
            border: Border.all(
                color: AppStyles.logoComplimentaryColor2,
                style: BorderStyle.solid,
                width: height * 0.05)),
        child: DropdownButton<Visitor>(
          menuMaxHeight: height * 5,
          isExpanded: true,
          //isDense: true,
          hint: Text(
            'Выберете пациента',
            style: TextStyle(fontSize: height * 0.4),
          ),
          value: _selectedPost,
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
          ),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(
            color: Colors.deepPurple,
          ),
          onChanged: (Visitor? newValue) {
            setState(() {
              _selectedPost = newValue!;
            });
          },
          items: visitors.map<DropdownMenuItem<Visitor>>((value) {
            return DropdownMenuItem<Visitor>(
              value: value,
              child: Text(
                "${value.surname}_${value.name}",
                maxLines: 2,
                style: TextStyle(fontSize: height * 0.4),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
      );
}
