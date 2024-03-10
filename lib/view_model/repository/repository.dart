import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce_real/model/products_model.dart';

import 'package:http/http.dart';

class ProductsRepository {
  ProductsRepository();

  Future<List<Product>> fetchProducts() async {
    const String apiUrl = 'https://dummyjson.com/products'; // Your API URL
    final response = await get(Uri.parse(apiUrl));
    var data = jsonDecode(response.body);

    List<Product> _productModelList = [];
    if (response.statusCode == 200) {
      // Check if "articles" key exists and is an array
      if (data.containsKey("products") && data["products"] is List) {
        for (var item in data["products"]) {
          Product _artcileModel = Product.fromJson(item);
          _productModelList.add(_artcileModel);
        }
        return _productModelList;
      } else {
        print("Invalid response structure: Missing or invalid 'articles' key");
      }
    } else {
      print("Error: ${response.statusCode}");
    }

    // Return an empty list if there's any error or the response structure is invalid
    return _productModelList;
  }
}

class productRepository {
  Future<List<String>> fetchCategories() async {
    String apiCategories = 'https://dummyjson.com/products/categories';
    final response = await get(Uri.parse(apiCategories));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<String> categories = List<String>.from(data);
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
abstract class ProductApiClient {
  Future<List<Product>> search(String query);
}

class ProductApiClientImpl implements ProductApiClient {

  final Dio dio;

  ProductApiClientImpl(this.dio);

  @override
  Future<List<Product>> search(String query) async {
    final response = await dio.get('https://dummyjson.com/products/search', 
        queryParameters: {'q': query});
        
    return (response.data as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }

}