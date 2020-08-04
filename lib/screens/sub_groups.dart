import 'package:easy_shop/widgets/subgroup_top.dart';
import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../widgets/change_group.dart';

class SubGroupScreen extends StatelessWidget {
  //const SubGroup({Key key}) : super(key: key);

  final String groupTitle;
  final String groupID;
  SubGroupScreen({this.groupID,this.groupTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Easy Shop"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        shrinkWrap: true,
      children: <Widget>[
        ChangeGroup(groupTitle),
        SubGroupTop(groupID),
        ProductsGrid(),
      ],
        ),
    );
  }
}
