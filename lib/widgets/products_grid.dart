import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/product.dart';
import 'package:easy_shop/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './product_page.dart';
import 'package:collection/collection.dart';

class ProductsGrid extends StatefulWidget {
  //const ProductsGrid({Key key}) : super(key: key);
  // final String subGroupId;

  // ProductsGrid(this.subGroupId);
  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  ProductService get service => GetIt.I<ProductService>();

  APIResponse<List<Product>> _apiResponse;
  bool _isLoading = false;
  bool _isFavorite = false;

  TextStyle itemNameText = const TextStyle(
      color: Colors.cyan,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins');

  TextStyle priceText = const TextStyle(
      color: Colors.black,
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

    _apiResponse = await service.getProductList();


    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_isLoading) {
          return Center(child: Text("Loading...",style: TextStyle(color: Colors.black),));
        }
        if (_apiResponse.error) {
          return Center(child: Text(_apiResponse.errorMessage));
        }
        return GridView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8),
            itemCount: _apiResponse.data.length,
            itemBuilder: (BuildContext _, int item) {
              return Container(
                height: 180,
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
                          //print(_apiResponse.data[item].createdOn);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return new ProductPage(
                                  productData: _apiResponse.data[item],
                                );
                              },
                            ),
                          );
                        },
                        child: Image.network(
                          _apiResponse.data[item].imageName,
                          width: 150,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: -15,
                        child: FlatButton(
                            padding: EdgeInsets.all(5),
                            shape: CircleBorder(),
                            onPressed: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            },
                            child: _isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.blue,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.blue,
                                  ))),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _apiResponse.data[item].itemName,
                              style: itemNameText,
                            ),
                            Text(
                              "Rs ${_apiResponse.data[item].data[0].mRP}",
                              style: priceText,
                            ),
                          
                            //Text(food.name, style: foodNameText),
                            //Text(food.price, style: priceText),
                          ],
                        )),
                  ],
                ),
              );
            });
      },
    );
  }
}
