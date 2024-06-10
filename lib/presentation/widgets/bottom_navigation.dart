import 'package:flutter/material.dart';
import 'package:sm_project/core/theme/app_styles.dart';
import 'package:sm_project/domain/global_var/global_settings.dart' as global;
import 'package:sm_project/presentation/pages/fillForm/chooseVisitor_page.dart';
import 'package:sm_project/presentation/pages/home_page.dart';
import 'package:sm_project/presentation/pages/my_page.dart';
import 'package:sm_project/presentation/pages/patients_page.dart';
import 'package:sm_project/presentation/pages/prescription_page.dart';

class CustomBottomNavBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomBottomNavBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = global.navBottmBarIndex;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      global.navBottmBarIndex = index;
      changePage(index);
    });
  }

  void changePage(int idx) {
    switch (idx) {
      case (0):
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyPage()));
      case (1):
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PatientsPage()));
      case (3):
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ChooseVisitorPage()));
      case (4):
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => (const PrescriptionPage())));
      default:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30,
      selectedItemColor: AppStyles.logoColor,
      selectedIconTheme: const IconThemeData(color: AppStyles.logoColor),
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppStyles.backgroundLogoColor,
      unselectedItemColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "кабинет"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "очередь"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "главная"),
        BottomNavigationBarItem(icon: Icon(Icons.addchart), label: "формуляр"),
        BottomNavigationBarItem(
            icon: Icon(Icons.edit_document), label: "рецепт")
      ],
    );
  }
}
