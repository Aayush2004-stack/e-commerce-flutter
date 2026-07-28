import 'package:flutter/material.dart';
import 'package:my_app/common/custom_text.dart';

class CommonPhoneCard extends StatelessWidget {
  final String name;
  const CommonPhoneCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),

            child: Icon(Icons.phone, color: Colors.white),
          ),
          CustomText(text: name, fontSize: 20, color: Colors.black),
          Icon(Icons.keyboard_arrow_right, size: 32, color: Colors.blue),
        ],
      ),
    );
  }
}
