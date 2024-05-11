import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
import 'package:sm_project/domain/global_var/global_settings.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/card.dart';

class PatientCardDetailsPage extends StatelessWidget {
  final Visitor visitor;
  const PatientCardDetailsPage({Key? key, required this.visitor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
          child: Column(
        children: [
          MyCard(
              fillWith: Text(
            "${visitor.surname} ${visitor.name} возраст: ${visitor.age}",
            style: const TextStyle(color: Colors.white, fontSize: 30),
          )),
          const SizedBox(
            height: 5.0,
          ),
          MyCard(
              fillWith: (visitor.getDoctors() == "")
                  ? Text(
                      "ФИО врача: \n${visitor.doctors!.last.surname}  ${visitor.doctors!.last.name}\nСпециализация: ${visitor.doctors!.last.field}",
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    )
                  : Text(
                      "возраст: ${visitor.age}\nврачи: ${visitor.getDoctors()}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 30))),
          const SizedBox(
            height: 5.0,
          ),
          MyCard(
              fillWith: (visitor.getResults() != 0)
                  ? ListView.builder(
                      itemCount: visitor.getResults(),
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          "вопрос: ${visitor.results!.question![index]}\nответ: ${visitor.results!.answer![index]}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        );
                      },
                    )
                  : const Text(
                      "Формуляр еще не заполнен",
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ))
        ],
      )),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
