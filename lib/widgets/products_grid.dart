import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/product.dart';
import 'package:easy_shop/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({Key key, this.groupId, this.subGroupId})
      : super(key: key);

  final String groupId;
  final String subGroupId;

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  ProductService get service => GetIt.I<ProductService>();

  APIResponse<List<Product>> _apiResponse;
  bool _isLoading = false;
  bool _isFavorite = false;
  String _selectedPackage;
  int _selectedQuantity = 1;
  final List _quantity = List<int>.generate(100, (index) => index + 1);

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

    setState(() {
      _isLoading = false;
    });
  }

  void onSelectedPackage(String value) {
    setState(() {
      _selectedPackage = value;
    });
  }

  void onSelectedQuantity(int value) {
    setState(() {
      _selectedQuantity = value;
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
                                    "Rs ${_apiResponse.data[item].data[0].mRP}",
                                    style: priceText,
                                  ),
                                  SizedBox(width: 45,),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      items: _apiResponse.data[item].data
                                          .map((element) {
                                        return DropdownMenuItem<String>(
                                            value: element.packingQty,
                                            child: Text(element.packingQty));
                                      }).toList(),
                                      onChanged: (value) =>
                                          onSelectedPackage(value),
                                      value: _selectedPackage,
                                      hint: Text("Package",style: TextStyle(color: Colors.white),),
                                    ),
                                  ),    
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text("Quantity",style: TextStyle(color: Colors.white),),
                                        value: _selectedQuantity,
                                        onChanged: (value) => onSelectedQuantity(value),
                                    items: _quantity.map((e) {
                                      return DropdownMenuItem(
                                          value: e, child: Text("${e}",style: TextStyle(color:Colors.white,)));
                                    }).toList(),
                                  )),
                                  GradientButton(
                                      child: Text("Add to Cart"),
                                      callback: () {
                                        print("Pressed");
                                      }),
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
}
