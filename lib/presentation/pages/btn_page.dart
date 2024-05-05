import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/gender_dto.dart';
import 'package:sm_project/api/requests/gender_request.dart';
import 'package:sm_project/presentation/widgets/msg.dart';

class BtnPage extends StatefulWidget {
  const BtnPage({Key? key}) : super(key: key);

  @override
  State<BtnPage> createState() => _BtnPageState();
}

class _BtnPageState extends State<BtnPage> {
  Future<Gender?>? gender;

  void clickGetButton(String name) {
    setState(() {
      gender = GenderRequest().getRequest(name);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Center(
            child: Text('http package'),
          ),
        ),
        body: SizedBox(
          height: 500,
          width: double.infinity,
          child: Column(
            children: [
              FutureBuilder<Gender?>(
                future: gender,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Container();
                  } else {
                    if (snapshot.hasData) {
                      return myMsg(msg: "${snapshot.data!.gender}");
                    } else if (snapshot.hasError) {
                      return myMsg(msg: "${snapshot.error}");
                    } else {
                      return Container();
                    }
                  }
                },
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => clickGetButton("rachel"),
                  child: const Text("GET"),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildDataWidget(context, snapshot) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                snapshot.data.name,
              )),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(snapshot.data.gender),
          )
        ],
      );
}
