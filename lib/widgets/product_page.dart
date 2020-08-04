import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductPage extends StatefulWidget {
  final Product productData;

  ProductPage({Key key, this.productData}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextStyle h6 = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins');

  TextStyle h5 = const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins');

  TextStyle h4 = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: 'Poppins');

  TextStyle h3 = const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w800,
      fontFamily: 'Poppins');


  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text(widget.productData.itemName, style: h4),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 100, bottom: 100),
                        padding: EdgeInsets.only(top: 100, bottom: 50),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //Text("Choose package  ",style:h5),
                            DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    hint: Text("Choose Package"),
                                    isDense: true,
                                    items: null,
                                    onChanged: null)),
                            Text(
                              "Selling Price  Rs ${widget.productData.data[0].sellingRate}",
                              style: h5,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 25),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text('Quantity', style: h6),
                                    margin: EdgeInsets.only(bottom: 15),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              _quantity += 1;
                                            });
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(_quantity.toString(),
                                            style: h3),
                                      ),
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_quantity == 1) return;
                                              _quantity -= 1;
                                            });
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text("MRP : ${widget.productData.data[0].mRP}",
                                      style: h3),
                                ],
                              ),
                            ),
                            Container(
                              width: 180,
                              child: FlatButton(
                                onPressed: () {},
                                child: Text("Add to Cart"),
                                textColor: Colors.white,
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, .05))
                            ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Container(
                          height: 180,
                          width: 180,
                          margin: EdgeInsets.all(5),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 180,
                                width: 180,
                                child: RaisedButton(
                                  color: Colors.white,
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: () {},
                                  child: Image.network(
                                    widget.productData.imageName,
                                    width: 150,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
