import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/product.dart';
import 'package:easy_shop/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
//import 'package:number_inc_dec/number_inc_dec.dart';

class ProductsGrid extends StatefulWidget {
  // const ProductsGrid({Key key, this.groupId, this.subGroupId})
  //     : super(key: key);

  final String groupId;
  final String subGroupId;

  ProductsGrid({this.groupId, this.subGroupId});
  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  ProductService get service => GetIt.I<ProductService>();

  APIResponse<List<Product>> _apiResponse;
  bool _isLoading = false;
  List<String> _selectedPackage = [];
  List<bool> _favorites = [];
  //List<double> _prices = [];
  List<int> _quantities = [];
  List<Map<String, List<String>>> _prices = [];
  List<Map<String, String>> _selectedPrices = [];
  int _temp = 0;

  TextStyle itemNameText = const TextStyle(
      color: Colors.cyan,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins');

  TextStyle priceText = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      fontFamily: 'Poppins');

  @override
  void initState() {
    _fetchProducts();
    super.initState();
  }

  _fetchProducts() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse =
        await service.getProductList(widget.groupId, widget.subGroupId);
    for (int i = 0; i < _apiResponse.data.length; i++) {
      _selectedPackage.add(_apiResponse.data[i].data[0].packingQty);
      _favorites.add(false);
      _quantities.add(1);
      //_prices.add(double.parse(_apiResponse.data[i].data[0].mRP));
      _prices.add({
        'mrp': _apiResponse.data[i].data.map((e) => e.mRP).toList(),
        'sr': _apiResponse.data[i].data.map((e) => e.sellingRate).toList(),
      });
      _selectedPrices.add({
        'mrp': _apiResponse.data[i].data[0].mRP,
        'sr': _apiResponse.data[i].data[0].sellingRate
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  void onSelectedPackage(String value, int index) {
    for (int i = 0; i < _apiResponse.data[index].data.length; i++) {
      if (_apiResponse.data[index].data[i].packingQty == value) {
        _temp = i;
      }
    }
    setState(() {
      _selectedPackage[index] = value;
      _selectedPrices[index]['mrp'] = _prices[index]['mrp'][_temp];
      _selectedPrices[index]['sr'] = _prices[index]['sr'][_temp];
    });
  }

  void add(value) {
    setState(() {
      _quantities[value]++;
    });
  }

  void sub(value) {
    setState(() {
      if (_quantities[value] > 1) {
        _quantities[value]--;
      }
    });
  }

  double getTotal(int quantity, String price) {
    return quantity * double.parse(price);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    print("GroupId" + widget.groupId);
    print("SubGroupId" + widget.subGroupId);
    return SafeArea(
      child: Builder(
        builder: (context) {
          if (_isLoading) {
            return Center(
                child: Text(
              "Loading...",
              style: TextStyle(color: Colors.black),
            ));
          }
          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 180 / 300),
                itemCount: _apiResponse.data.length,
                itemBuilder: (BuildContext _, int item) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.2),
                                  offset: Offset(10, 10),
                                  blurRadius: 10),
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.7),
                                  offset: Offset(-10, -10),
                                  blurRadius: 10),
                            ]),
                        child: RaisedButton(
                          color: Colors.white,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            print(_apiResponse.data[item].itemName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CachedNetworkImage(
                                placeholder: (context, url) => Image.network(
                                    'https://cdn.pixabay.com/photo/2017/03/09/12/31/error-2129569_960_720.jpg'),
                                imageUrl: _apiResponse.data[item].imageName),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _apiResponse.data[item].itemName,
                                style: itemNameText,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    //  '₹ ${_apiResponse.data[item].data[0].mRP}',
                                    '₹ ' + _selectedPrices[item]['mrp'],
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.yellow),
                                  ),
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Text(
                                    //  '₹ ${_apiResponse.data[item].data[0].sellingRate}',
                                    '₹ ' + _selectedPrices[item]['sr'],
                                    style: priceText,
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  getDropDownForPacking(
                                      _apiResponse.data[item].data
                                          .map((e) => e.packingQty)
                                          .toList(),
                                      item),
                                  // SizedBox(
                                  //   width: 45,
                                  // ),
                                  //getDropDownForQuantity(item),
                                  Container(
                                    height: 20,
                                    width: 120,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: FloatingActionButton(
                                            backgroundColor: Colors.white,
                                            onPressed: () => add(item),
                                            child: Icon(
                                              Icons.add,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _quantities[item].toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: FloatingActionButton(
                                              backgroundColor: Colors.white,
                                              onPressed: () => sub(item),
                                              child:
                                                  Icon(Icons.remove, size: 12)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      icon: _favorites[item]
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          _favorites[item] = !_favorites[item];
                                        });
                                      }),
                                  // SizedBox(
                                  //   width: 45,
                                  // ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.shopping_cart_rounded,
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        HapticFeedback.lightImpact();
                                        cart.addItem(
                                          _apiResponse.data[item].itemId +
                                              _apiResponse
                                                  .data[item].data[_temp].code,
                                          double.parse(
                                              _selectedPrices[item]['sr']),
                                          _apiResponse.data[item].itemName,
                                          Image.network(_apiResponse
                                              .data[item].imageName),
                                          getTotal(_quantities[item], _selectedPrices[item]['sr']),
                                          _quantities[item],
                                        );
                                        Scaffold.of(context)
                                            .hideCurrentSnackBar();
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Added to cart'),
                                          duration: Duration(seconds: 2),
                                          action: SnackBarAction(
                                            label: "Undo",
                                            onPressed: () {
                                              cart.removeSingleItem(_apiResponse
                                                  .data[item].itemId);
                                            },
                                          ),
                                        ));
                                      })
                                ],
                              ),
                            ],
                          )),
                    ],
                  );
                }),
          );
        },
      ),
    );
  }

  Widget getDropDownForPacking(List<String> list, int index) {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      style: TextStyle(color: Colors.white),
      dropdownColor: Colors.black,
      elevation: 8,
      value: _selectedPackage[index],
      items: list.map((item) {
        return DropdownMenuItem<String>(
          child: Text(item),
          value: item,
        );
      }).toList(),
      onChanged: (value) => onSelectedPackage(value, index),
    ));
  }
}
