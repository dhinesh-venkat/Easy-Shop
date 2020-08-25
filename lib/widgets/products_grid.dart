import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/product.dart';
import 'package:easy_shop/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

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
  List<int> _selectedQuantity = [];
  List<bool> _favorites = [];
  List<double> _prices = [];
  final List _quantity = List<int>.generate(100, (index) => index);

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
      _selectedQuantity.add(0);
      _favorites.add(false);
      _prices.add(double.parse(_apiResponse.data[i].data[0].mRP));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void onSelectedPackage(String value, int index) {
    setState(() {
      _selectedPackage[index] = value;
    });
  }

  void onSelectedQuantity(int value, int index) {
    setState(() {
      _selectedQuantity[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("GroupId" + widget.groupId);
    print("SubGroupId" + widget.subGroupId);
    return Builder(
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
                return Container(
                  //  color: Colors.yellow,
                  //   height: 250,
                  width: 180,
                  margin: EdgeInsets.all(5),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.25),
                              spreadRadius: 20,
                              blurRadius: 0.00001,
                              offset:
                                  Offset(15, -20), // changes position of shadow
                            ),
                          ],
                        ),
                        child: RaisedButton(
                          color: Colors.white,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            print(_apiResponse.data[item].itemName);
                          },
                          // child: Image.network(
                          //   _apiResponse.data[item].imageName,
                          //   width: 100,
                          // ),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/no_image.png",
                            image: _apiResponse.data[item].imageName,
                            width: 100,
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
                                    _apiResponse.data[item].data[0].mRP,
                                    style: priceText,
                                  ),
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Text(
                                    _apiResponse.data[item].data[0].sellingRate,
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
                                  SizedBox(
                                    width: 45,
                                  ),
                                  getDropDownForQuantity(item),
                                ],
                              ),
                              Row(
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
                                  SizedBox(
                                    width: 45,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.shopping_cart_rounded,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        print(
                                            "Added ${_apiResponse.data[item].itemName}");
                                      })
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              }),
        );
      },
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

  Widget getDropDownForQuantity(int index) {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      style: TextStyle(color: Colors.white),
      dropdownColor: Colors.black,
      elevation: 8,
      value: _selectedQuantity[index],
      items: _quantity.map((item) {
        return DropdownMenuItem(
          child: Text(
            item.toString(),
          ),
          value: item,
        );
      }).toList(),
      onChanged: (value) => onSelectedQuantity(value, index),
    ));
  }
}
