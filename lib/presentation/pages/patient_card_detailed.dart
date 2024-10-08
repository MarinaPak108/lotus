import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';
import 'package:sm_project/presentation/widgets/card.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class PatientCardDetailsPage extends StatelessWidget {
  final Visitor visitor;
  const PatientCardDetailsPage({Key? key, required this.visitor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = global.globalWidth;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          SizedBox(
            width: width * 7.5,
            //height: global.globalHeight * 4.5,
            child: MyCard(
                fillWith: Text(
              "${visitor.surname} ${visitor.name} ${visitor.fathersName}\nдата рождения:${visitor.getBirthDate()}\nвозраст: ${visitor.age}",
              style: TextStyle(color: Colors.white, fontSize: width * 0.3),
            )),
          ),
          const SizedBox(
            height: 5.0,
          ),
          SizedBox(
            width: width * 7.5,
            child: MyCard(
                fillWith: (visitor.getDoctors() == "")
                    ? Row(
                        children: [
                          Text(
                            "ФИО врача: \n${visitor.doctor!.surname}  ${visitor.doctor!.name}\nСпециализация: ${visitor.doctor!.field}",
                            style: TextStyle(
                                color: Colors.white, fontSize: width * 0.3),
                          ),
                          const Spacer(),
                          const Icon(Icons.update_sharp, color: Colors.white)
                        ],
                      )
                    : Text("${visitor.getDoctors()}",
                        style: TextStyle(
                            color: Colors.yellow, fontSize: width * 0.3))),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
              child: ListView(
            children: [
              //formular i recept ot wracha
              SizedBox(
                width: width * 7.5,
                child: MyCard(
                    fillWith: (visitor.getResults() != 0)
                        ? Row(
                            children: [
                              Text(
                                "Формуляр заполнен",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: global.globalWidth * 0.3,
                                    fontWeight: FontWeight.w800),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.update_rounded,
                                color: Colors.white,
                              )
                            ],
                          )
                        : Text(
                            "Формуляр еще не заполнен",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: global.globalWidth * 0.3),
                          )),
              ),
              //recept
              SizedBox(
                width: width * 7.5,
                child: MyCard(
                    fillWith: (visitor.prescription == null)
                        ? Text(
                            "рецепт еще не выписан",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: global.globalWidth * 0.3,
                                fontWeight: FontWeight.w800),
                          )
                        : Row(
                            children: [
                              SizedBox(
                                width: global.globalWidth * 5,
                                child: Text(
                                  "Рецепт: ${visitor.prescription}",
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: global.globalWidth * 0.3),
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.update_rounded,
                                color: Colors.white,
                              )
                            ],
                          )),
              ),
            ],
          ))
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
