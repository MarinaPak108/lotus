import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/presentation/pages/login_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late SharedPreferences prefs;
  logout() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("isSteySinged", false);
    prefs.setString("login", "");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //leadingWidth: 85,
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppStyles.notActiveDarkC,
            image: const DecorationImage(
                image: AssetImage("assets/icon/app_logo.jpg"),
                fit: BoxFit.fill),
            border: Border.all(
              width: 5,
              color: AppStyles.borderLogoColor,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
      backgroundColor: AppStyles.backgroundLogoColor,
      title: const Text(
        "MediLotus Help",
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'logout',
          color: Colors.white,
          iconSize: 28.0,
          onPressed: () {
            logout();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ],
    );
  }
}
