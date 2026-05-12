import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  const HmCategory({super.key});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              "分类${index + 1}",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
