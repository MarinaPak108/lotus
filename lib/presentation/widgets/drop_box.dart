import 'package:flutter/material.dart';
import 'package:sm_project/api/dto/visitor_dto.dart';
import 'package:sm_project/core/theme/app_styles.dart';

import 'package:sm_project/domain/global_var/global_settings.dart' as global;

class MyDropDownMenu extends StatelessWidget {
  final Visitor? selectedPost;
  final Iterable<Visitor> visitors;
  final Function(Visitor?)? onChanged;

  const MyDropDownMenu(
      {Key? key,
      required this.selectedPost,
      required this.visitors,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = global.globalHeight;
    return Container(
      padding: EdgeInsets.all(height * 0.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height * 0.5),
          border: Border.all(
              color: AppStyles.logoComplimentaryColor2,
              style: BorderStyle.solid,
              width: height * 0.05)),
      child: DropdownButton<Visitor>(
        menuMaxHeight: height * 5,
        isExpanded: true,
        //isDense: true,
        hint: Text(
          'Выберете пациента',
          style: TextStyle(fontSize: height * 0.5),
        ),
        value: selectedPost,
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
        ),
        iconSize: height,
        elevation: (height * 0.5).round(),
        style: const TextStyle(
          color: Colors.deepPurple,
        ),
        onChanged: onChanged,
        items: visitors.map<DropdownMenuItem<Visitor>>((value) {
          return DropdownMenuItem<Visitor>(
            value: value,
            child: Text(
              "${value.id}. ${value.surname} ${value.name} ${value.fathersName}",
              maxLines: 2,
              style: TextStyle(fontSize: height * 0.5),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }
}
