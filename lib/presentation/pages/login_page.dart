import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_project/api/dto/gender_dto.dart';
import 'package:sm_project/api/requests/gender_request.dart';
import 'package:sm_project/presentation/pages/home_page.dart';
import 'package:sm_project/presentation/widgets/btn.dart';
import 'package:sm_project/presentation/widgets/check_box.dart';
import 'package:sm_project/presentation/widgets/input_field.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? stayLogged = false;
  bool isButtonActive = true;
  Future<Gender?>? gender;
  final _controller = TextEditingController();
  late SharedPreferences prefs;

  Future<void> saveAsLogged(bool? stayLoggedUser, String name) async {
    if (stayLoggedUser == true) {
      prefs = await SharedPreferences.getInstance();
      prefs.setBool("isSteySinged", stayLoggedUser!);
      prefs.setString("login", name);
      global.userId = name;
    }
  }

  void clickGetNameButton(String name) {
    setState(() {
      gender = GenderRequest().getRequest(name);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final isButtonActive = _controller.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyInputField(label: 'имя', ctrl: _controller),
              const SizedBox(
                height: 16,
              ),
              FutureBuilder<Gender?>(
                future: gender,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Container();
                  } else {
                    if (snapshot.hasData) {
                      return buildDataWidget(context, snapshot);
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("${snapshot.error}");
                    } else {
                      return Container();
                    }
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              MyBtn(
                name: "Ввести имя",
                onPressed: isButtonActive
                    ? () {
                        if (stayLogged!) {
                          saveAsLogged(stayLogged, _controller.text);
                          global.navBottmBarIndex = 3;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                        clickGetNameButton(_controller.text);
                        setState(() {});
                      }
                    : null,
              ),
              const SizedBox(
                height: 16,
              ),
              MyCheckBox(
                value: stayLogged,
                label: "остаться зарегестрированным",
                onChanged: (bool? newVal) {
                  setState(() {});
                  stayLogged = newVal;
                },
              )
            ],
          ),
        ),
      );

  Widget buildDataWidget(context, snapshot) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: snapshot.data.name,
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                const TextSpan(text: ' is '),
                TextSpan(
                    text: snapshot.data.gender,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      );
}
