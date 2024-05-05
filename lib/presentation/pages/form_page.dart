import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/answer_dto.dart';
import 'package:sm_project/api/dto/post_dto.dart';
import 'package:sm_project/api/dto/questionForm_dto.dart';
import 'package:sm_project/api/requests/post_requests.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/presentation/pages/home_page.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/btn.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool isButtonActive = false;
  final List<QuestionForm> _questions = [
    QuestionForm(questionText: "Q1. Who created Flutter?", answers: [
      Answer(id: 0, answer: 'Facebook'),
      Answer(id: 1, answer: 'Adobe'),
      Answer(id: 2, answer: 'Google'),
      Answer(id: 3, answer: 'Microsoft')
    ]),
    QuestionForm(questionText: "Q2. What is Flutter?", answers: [
      Answer(id: 4, answer: 'Android Development Kit'),
      Answer(id: 5, answer: 'IOS Development Kit'),
      Answer(id: 6, answer: 'Web Development Kit'),
      Answer(id: 7, answer: 'Microsoft')
    ]),
    QuestionForm(
        questionText:
            "Q5. Is Flutter for Web and Desktop available in stable version?",
        answers: [
          Answer(id: 8, answer: 'yes'),
          Answer(id: 9, answer: 'no'),
        ])
  ];
  late List<bool> isChecked = List.filled(_questions.length, false);
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
    bool isButtonActive = isChecked.every((e) => e == true);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Flex(direction: Axis.vertical, children: [
        Expanded(
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(height * 0.1),
                itemCount: _questions.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.1);
                },
                itemBuilder: (context, index) {
                  final qst = _questions[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: height * 0.03, color: AppStyles.logoColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(qst.questionText,
                            style: TextStyle(
                                fontSize: height * 0.4,
                                color: AppStyles.logoColor)),
                        const SizedBox(height: 5.0),
                        Column(
                          children: List.generate(
                            qst.answers.length,
                            (idx) => CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                qst.answers[idx].answer,
                                style: TextStyle(
                                  fontSize: height * 0.3,
                                  color: AppStyles.logoComplimentaryColor2,
                                ),
                              ),
                              value: qst.answers[idx].isSelected!,
                              onChanged: (value) {
                                setState(() {
                                  for (var element in qst.answers) {
                                    element.isSelected = false;
                                  }
                                  qst.answers[idx].isSelected = value;
                                  isChecked[index] = true;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })),
        Padding(
          padding: EdgeInsets.all(height * 0.1),
          child: MyBtn(
              name: "Send",
              onPressed: isButtonActive
                  ? () {
                      if (isButtonActive) {
                        global.navBottmBarIndex = 3;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    }
                  : null),
        ),
      ]),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
