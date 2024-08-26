import 'package:categoryquizapp_sample/dummydb.dart';
import 'package:flutter/material.dart';

class OptioncardSection extends StatelessWidget {
  final int questionindex;
  final int index;
  final Color borderColor;
  final Function() onOptionTap;
  OptioncardSection(
      {required this.questionindex,
      required this.index,
      required this.onOptionTap,
      required this.borderColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onOptionTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Dummydb.category[questionindex]["options"][index],
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.radio_button_unchecked,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
