import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/answer_dto.dart';
import 'package:sm_project/api/dto/formResults_dto.dart';
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
    QuestionForm(questionText: "Цель обращения", answers: [
      Answer(id: 0, answer: 'обращение по поводу заболевания'),
      Answer(id: 1, answer: 'профилактическая и иная'),
      Answer(id: 2, answer: 'неотложная помощь'),
    ]),
    QuestionForm(questionText: "Вид обращения", answers: [
      Answer(id: 4, answer: 'разовое посещение по поводу заболевания'),
      Answer(id: 5, answer: 'диспансерное наблюдение'),
      Answer(id: 6, answer: 'медосмотр'),
      Answer(id: 7, answer: 'диспансеризация'),
      Answer(id: 10, answer: "профосмотр"),
      Answer(id: 11, answer: "посещение центра здоровья"),
      Answer(id: 12, answer: "оформление медицинских документов и справок"),
      Answer(id: 13, answer: "паллиативная помощь"),
      Answer(id: 14, answer: "реабилитация"),
    ]),
    QuestionForm(questionText: "Уровень оказания медицинской помощи", answers: [
      Answer(id: 8, answer: 'специализированный'),
      Answer(id: 9, answer: 'территориальный'),
      Answer(id: 15, answer: 'межмуниципальный'),
    ])
  ];
  late List<bool> isChecked = List.filled(_questions.length, false);
  Future<List<Post>> posts = getPosts();
  List<String>? questions;
  List<String>? answers;
  @override
  void initState() {
    super.initState();
  }

  static Future<List<Post>> getPosts() async {
    return await PostRequest().getPostsByUserId();
  }

  @override
  Widget build(BuildContext context) {
    double height = global.globalHeight;
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
                                  questions?.add(qst.questionText);
                                  answers?.add(qst.answers[idx].answer);
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
                        global.visitors[global.currentVisitor.id].results =
                            FormResults(answer: answers, question: questions);
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
