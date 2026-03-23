import 'dart:convert';
import 'package:connecteo/connecteo.dart';
import 'package:backend_test/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductsData {
  // 🔵 MAIN FUNCTION
  Future<List<ProductModel>> fetchProducts() async {
    final connecteo = ConnectionChecker();
    final hasInternetConnection = await connecteo.isConnected;

    if (!hasInternetConnection) {
      return await getProductsFromCache();
    }

    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      List<dynamic> rawProductList = decodedData['products'];

      List<ProductModel> cleanProductList = rawProductList
          .map((item) => ProductModel.fromJson(item))
          .toList();

      await cacheProductList(cleanProductList);

      return cleanProductList;
    }

    return await getProductsFromCache();
  }

  Future<List<ProductModel>> getProductsFromCache() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString('cached_products');

    if (jsonString == null) return [];

    List<dynamic> decodedList = jsonDecode(jsonString);

    return decodedList.map((item) => ProductModel.fromJson(item)).toList();
  }

  Future<void> cacheProductList(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();

    String jsonString = jsonEncode(products.map((p) => p.toJson()).toList());

    await prefs.setString('cached_products', jsonString);
  }
}
