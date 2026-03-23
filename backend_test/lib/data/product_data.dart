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

    // ❌ NO INTERNET → get from cache
    if (!hasInternetConnection) {
      return await getProductsFromCache();
    }

    // 🌐 FETCH FROM API
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    if (response.statusCode == 200) {
      // convert JSON string → Map
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      // get products list
      List<dynamic> rawProductList = decodedData['products'];

      // convert → ProductModel list
      List<ProductModel> cleanProductList = rawProductList
          .map((item) => ProductModel.fromJson(item))
          .toList();

      // 💾 SAVE TO CACHE
      await cacheProductList(cleanProductList);

      return cleanProductList;
    }

    // ❗ API failed → fallback to cache
    return await getProductsFromCache();
  }

  // 🟡 GET FROM LOCAL STORAGE
  Future<List<ProductModel>> getProductsFromCache() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString('cached_products');

    if (jsonString == null) return [];

    // string → list
    List<dynamic> decodedList = jsonDecode(jsonString);

    // list → ProductModel
    return decodedList.map((item) => ProductModel.fromJson(item)).toList();
  }

  // 🟢 SAVE TO LOCAL STORAGE
  Future<void> cacheProductList(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();

    // convert ProductModel → Map → JSON string
    String jsonString = jsonEncode(products.map((p) => p.toJson()).toList());

    await prefs.setString('cached_products', jsonString);
  }
}
