import 'package:flutter/material.dart';

class SubGroup extends StatelessWidget {
  //const SubGroup({Key key}) : super(key: key);

  final String groupTitle;
  SubGroup({this.groupTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Text("Hello"),
    );
  }
}
