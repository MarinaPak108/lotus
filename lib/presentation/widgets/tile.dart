import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sm_project/core/theme/app_styles.dart';

class MyTile extends StatelessWidget {
  final IconData icn;
  final Widget page;
  final String title;
  final String subTitle;
  final IconData actionIcn;
  final Color color;

  const MyTile(
      {Key? key,
      required this.icn,
      required this.page,
      required this.title,
      required this.subTitle,
      required this.actionIcn,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height / 10;
    double width = MediaQuery.sizeOf(context).width / 10;
    return InkWell(
      splashColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppStyles.logoComplimentaryColor2, AppStyles.logoColor],
              //begin: Alignment.topLeft,
              //end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.all(Radius.circular(height * 0.3))),
        child: ListTile(
          title: Row(
            children: [
              Icon(
                icn,
                size: width,
                color: color,
              ),
              SizedBox(
                width: width * 0.1,
              ),
              SizedBox(
                width: width * 6.2,
                child: Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: height * 0.25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          isThreeLine: true,
          subtitle: Row(
            children: [
              SizedBox(
                width: width * 2,
              ),
              Expanded(
                child: Text(
                  subTitle,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: height * 0.2,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                actionIcn,
                size: height * 0.5,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
