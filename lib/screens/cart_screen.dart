import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_shop/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartScreen extends StatefulWidget {
  //const CartScreen({Key key}) : super(key: key);
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> _quantities = [];
  List<double> _price = [];
  List<CartItem> _cartList = [];
  double _totalAmount = 0.0;

  @override
  void initState() {
    _totalAmount = Provider.of<Cart>(context, listen: false).totalAmount;
    super.initState();
  }

  void add(value) {
    setState(() {
      _quantities[value]++;
      _price[value] += _cartList[value].total;
      _totalAmount += _cartList[value].rate;
    });
  }

  void sub(value) {
    setState(() {
      if (_quantities[value] > 1) {
        _quantities[value]--;
        _price[value] -= _cartList[value].total;
        _totalAmount -= _cartList[value].rate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    _cartList = [];
    for (var i in cart.items.values) {
      _cartList.add(i);
      _quantities.add(i.quantity);
      _price.add(i.rate);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          FlatButton(
              onPressed: () {
                cart.clear();
                setState(() {
                  _totalAmount = 0.0;
                });
              },
              child: Text(
                'Clear',
                style: TextStyle(color: Colors.blue.shade200),
              ))
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Cart',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Row(
                  children: [
                    Text(
                      '${cart.itemCount} items',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 60,
                      width: 140,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        color: Colors.black,
                        onPressed: () {},
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text('₹ ' + _totalAmount.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'Fryo',
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => getItem(_cartList[index], index),
              itemCount: _cartList.length,
            ))
          ],
        ),
      ),
    );
  }

  Widget getItem(CartItem item, int index) {
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 120,
                width: 90,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.network(
                      'https://cdn.pixabay.com/photo/2017/03/09/12/31/error-2129569_960_720.jpg'),
                  imageUrl: item.imageUrl,
                ),
              ),
              Container(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        item.itemName,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Fryo',
                            fontSize: 15),
                      ),
                    ),
                    Text(
                      '₹ ${_price[index]}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Fryo',
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('₹ ' + item.rate.toString()),
                  Container(
                    height: 50,
                    width: 110,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: ()  {
                              HapticFeedback.lightImpact();
                              sub(index);}),
                        Text(
                          _quantities[index].toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              add(index);
                            }),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          endIndent: 15,
          indent: 15,
        )
      ],
    );
  }
}
