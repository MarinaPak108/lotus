import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/doctor_dto.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';

import 'package:sm_project/presentation/pages/fillForm/form_page.dart';
import 'package:sm_project/presentation/widgets/app_bar.dart';
import 'package:sm_project/presentation/widgets/bottom_navigation.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;
import 'package:sm_project/presentation/widgets/btn.dart';
import 'package:sm_project/presentation/widgets/card.dart';
import 'package:sm_project/presentation/widgets/check_box.dart';
import 'package:sm_project/presentation/widgets/drop_box.dart';

class ChooseVisitorPage extends StatefulWidget {
  const ChooseVisitorPage({Key? key}) : super(key: key);

  @override
  State<ChooseVisitorPage> createState() => _ChooseVisitorState();
}

class _ChooseVisitorState extends State<ChooseVisitorPage> {
  Visitor? _selectedPost;
  Doctor? _selectedDoctor;
  List<Doctor> doctors = global.doctors;
  List<bool> isDoctorActive = [false, false, false];
  @override
  void initState() {
    super.initState();
    //esli uje est pacient kotorogo volonter vedet,
    //to on budet wiswechiwatsja w dropbox
    if (global.currentVisitor.id != -1) {
      _selectedPost = global.currentVisitor;
      //esli k pacientu uje prikleplen doctor,
      //to on toje budet wiswechiwatsja uje w checkbox
      if (global.currentVisitor.doctor != null) {
        _selectedDoctor = global.currentVisitor.doctor;
        isDoctorActive[_selectedDoctor!.id] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = global.globalHeight;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(height * 0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //patsienti
            MyDropDownMenu(
              selectedPost: _selectedPost,
              visitors: global.visitors,
              onChanged: (Visitor? newValue) {
                setState(() {
                  isDoctorActive = [false, false, false];
                  _selectedPost = newValue!;
                  if (newValue.doctor != null) {
                    isDoctorActive[newValue.doctor!.id] = true;
                  }
                });
              },
            ),
            SizedBox(
              height: height * 0.3,
            ),
            //vrachi
            SizedBox(
              height: height * 7,
              child: Column(
                children: [
                  MyCard(
                    fillWith: Row(
                      children: [
                        MyCheckBox(
                            value: isDoctorActive[0],
                            label: "",
                            onChanged: (bool? value) {
                              setState(() {
                                isDoctorActive[0] = value!;
                                isDoctorActive[1] = false;
                                isDoctorActive[2] = false;
                                _selectedDoctor = doctors[0];
                              });
                            }),
                        SizedBox(
                          width: height * 0.1,
                        ),
                        Text(
                          "${doctors[0].surname} ${doctors[0].name}\n${doctors[0].field}",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.5),
                        )
                      ],
                    ),
                  ),
                  MyCard(
                    fillWith: Row(
                      children: [
                        MyCheckBox(
                            value: isDoctorActive[1],
                            label: "",
                            onChanged: (bool? value) {
                              setState(() {
                                isDoctorActive[1] = value!;
                                isDoctorActive[0] = false;
                                isDoctorActive[2] = false;
                                _selectedDoctor = doctors[1];
                              });
                            }),
                        SizedBox(
                          width: height * 0.1,
                        ),
                        Text(
                          "${doctors[1].surname} ${doctors[1].name}\n${doctors[1].field}",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.5),
                        )
                      ],
                    ),
                  ),
                  MyCard(
                    fillWith: Row(
                      children: [
                        MyCheckBox(
                            value: isDoctorActive[2],
                            label: "",
                            onChanged: (bool? value) {
                              setState(() {
                                isDoctorActive[2] = value!;
                                isDoctorActive[0] = false;
                                isDoctorActive[1] = false;
                                _selectedDoctor = doctors[2];
                              });
                            }),
                        SizedBox(
                          width: height * 0.1,
                        ),
                        Text(
                          "${doctors[2].surname} ${doctors[2].name}\n${doctors[2].field}",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.5),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //pereiti k zapolneniju formi
            MyBtn(
                width: global.globalWidth * 5,
                name: "Заполнить форму",
                onPressed: () {
                  //for current mobile: add current doc and patient to global vars
                  global.currentVisitor = _selectedPost!;
                  global.currentVisitor.doctor = _selectedDoctor;
                  //for db:  assign doctor to patient and patient to doctor for db
                  global.visitors[global.currentVisitor.id].doctor =
                      _selectedDoctor;
                  global.doctors[_selectedDoctor!.id].patients
                      ?.add(global.currentVisitor);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FormPage()));
                })
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
