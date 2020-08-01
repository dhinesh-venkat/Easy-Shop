import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import '../models/product.dart';
import 'dart:convert';
import '../main.dart';

class ProductService {
  String url = MyApp.BASE_URL;

  Future<APIResponse<List<Product>>> getProductList() {
    return http.get(url + "/api/item?&pagenumber=1&pagesize=20").then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final products = <Product>[];
        for (var item in jsonData) {
          products.add(Product.fromJson(item));
        }
        return APIResponse<List<Product>>(data: products);
      }
      return APIResponse<List<Product>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<Product>>(
        error: true, errorMessage: "An error occured"));
  }
}
