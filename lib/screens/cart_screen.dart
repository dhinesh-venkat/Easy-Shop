import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class CartScreen extends StatelessWidget {
  //const CartScreen({Key key}) : super(key: key);
  static const routeName = '/cart';
  TextStyle _style1 = const TextStyle(
    color: Colors.orange,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
  );

  TextStyle _style2 =
      const TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Poppins');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 500,
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text("")),
                  DataColumn(
                      label: Text(
                    "ITEM",
                    style: _style1,
                  )),
                  DataColumn(label: Text("QTY", style: _style1)),
                  DataColumn(label: Text("RATE", style: _style1)),
                  DataColumn(label: Text("TOTAL", style: _style1)),
                ],
                rows: [
                  // DataRow(cells: null)
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "TOTAL ITEMS 4",
                  style: _style1,
                ),
                Text("TOTAL VALUE 101.00", style: _style1)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GradientButton(
              gradient: Gradients.serve,
                child: Text("CHECKOUT"),
                callback: () {
                  print("Checkout");
                })
          ],
        ));
  }
}
