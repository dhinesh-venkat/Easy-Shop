import 'package:easy_shop/models/api_response.dart';
import 'package:easy_shop/models/product.dart';
import 'package:easy_shop/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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

  TextStyle _textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 14,
  );

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
          return Center(child: CircularProgressIndicator());
        }
        if (_apiResponse.error) {
          return Center(child: Text(_apiResponse.errorMessage));
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0),
          child: GridView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: _apiResponse.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 2.5,
                mainAxisSpacing: 2.5,
              ),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    print(_apiResponse.data[index].imageName);
                  },
                  child: GridTile(
                    child: Image.network(
                      _apiResponse.data[index].imageName,
                      fit: BoxFit.fill,
                    ),
                    footer: Container(
                      color: Colors.black54,
                      child: Column(
                        children: <Widget>[
                          Text(
                            _apiResponse.data[index].itemName,
                            style: _textStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "MRP :${_apiResponse.data[index].mrp}",
                                style: _textStyle,
                              ),
                              Text(
                                "Selling Price : ${_apiResponse.data[index].sellingRate}",
                                style: _textStyle,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Package : ${_apiResponse.data[index].packingQty}",
                                style: _textStyle,
                              ),
                              Text(
                                "Quantity : 1",
                                style: _textStyle,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
