import 'package:easy_shop/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

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
    final cart = Provider.of<Cart>(context);
    List<CartItem> _cartList = List();
    for (var i in cart.items.values) {
      _cartList.add(i);
    }
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 500,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                    rows: _cartList
                        .map(((value) => DataRow(cells: <DataCell>[
                              DataCell(Container(
                                height: 50,
                                width: 50,
                                child: value.imageUrl,
                              )),
                              DataCell(Text(
                                value.itemName,
                                style: _style2,
                              )),
                              DataCell(Text(
                                value.quantity.toString(),
                                style: _style2,
                              )),
                              DataCell(Text(
                                value.rate.toString(),
                                style: _style2,
                              )),
                              DataCell(Text(
                                value.total.toString(),
                                style: _style2,
                              ))
                            ])))
                        .toList(),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "TOTAL ITEMS ${cart.items.length}",
                  style: _style1,
                ),
                Text("TOTAL VALUE ${cart.totalAmount}", style: _style1)
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
