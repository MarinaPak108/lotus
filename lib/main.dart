import 'package:flutter/material.dart';
import 'package:sm_project/presentation/pages/splash_page.dart';

//https://www.google.com/search?q=redmi+developer+options&rlz=1C1IXYC_ruKR935KR935&oq=redmi+develo&gs_lcrp=EgZjaHJvbWUqBwgAEAAYgAQyBwgAEAAYgAQyBggBEEUYOTIHCAIQABiABDIHCAMQABiABDIICAQQABgWGB4yCAgFEAAYFhgeMggIBhAAGBYYHjIICAcQABgWGB4yCAgIEAAYFhgeMggICRAAGBYYHqgCALACAA&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:6d561fd7,vid:GyhywquSkkA,st:0
//https://gist.github.com/rjsuzuki/3e6b43008feaf5191265548de6d0a6b3
//https://docs.flutter.dev/deployment/android#enable-material-components

//java -jar C:\Users\Mari\Downloads\bundletool-all-1.16.0.jar build-apks --bundle=D:\SaiMediProject\sai_medi_project\sm_project\build\app\outputs\bundle\release\app-release.aab --output=D:\SaiMediProject\sai_medi_project\lotus.apks
//java -jar C:\Users\Mari\Downloads\bundletool-all-1.16.0.jar install-apks --adb=C:\Users\Mari\AppData\Local\Android\Sdk\platform-tools\adb.exe --apks=D:\SaiMediProject\sai_medi_project\lotus.apks
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, title: 'SM App', home: SplashPage());
  }
}
