import 'package:easy_shop/widgets/subgroup_top.dart';
import 'package:flutter/material.dart';

class SubGroupScreen extends StatelessWidget {
  //const SubGroup({Key key}) : super(key: key);

  final String groupTitle;
  SubGroupScreen({this.groupTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Flexible(child: SubGroupTop()),
        ],
      ),
    );
  }
}

