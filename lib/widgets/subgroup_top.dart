import 'package:easy_shop/models/sub_group.dart';
import 'package:flutter/material.dart';
import '../models/sub_group.dart';

class SubGroupTop extends StatelessWidget {
  //const SubGroupTop({Key key}) : super(key: key);

  List<SubGroup> _subGroups = [
    SubGroup(
        id: "1",
        value: "One",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "2",
        value: "Two",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "3",
        value: "Three",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "4",
        value: "Four",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "5",
        value: "Five",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "6",
        value: "Six",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "7",
        value: "Seven",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "8",
        value: "Eight",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "9",
        value: "Nine",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
    SubGroup(
        id: "10",
        value: "Ten",
        imageUrl:
            "https://cdn.pixabay.com/photo/2012/04/18/20/21/strawberry-37781_960_720.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      margin: EdgeInsets.all(14.0),
      color: Colors.yellow,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _subGroups.length,
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              Container(
                height: 70,
                width: 70,
                child: Card(
                  child: Image.network(_subGroups[index].imageUrl),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
