import 'package:easy_shop/widgets/grids.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Easy Shop"),
      ),
      body: Container(
        margin: EdgeInsets.all(14),
        child: Column(
          children: <Widget>[
            SizedBox(
                child: Container(
                color: Colors.yellow,
                height: 35,
              ),
            ),
            SizedBox(height: 14,),
            Flexible(child: Grids()),
          ],
        )),
    );
  }
}
