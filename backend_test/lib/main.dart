import 'dart:convert';
import 'package:backend_test/json_parse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 2. The Storage: A list that specifically holds 'Product' objects
  List<Product> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Run the network request when the app starts
  }

  Future<void> fetchData() async {
    // GET request to the API
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    if (response.statusCode == 200) {
      // Step A: Turn the raw String body into a Map
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      // Step B: Grab the List of products inside the "products" key
      List<dynamic> rawProductList = decodedData['products'];

      // Step C: Convert each Map item in that list into a 'Product' object
      List<Product> cleanProductList = rawProductList
          .map((item) => Product.fromJson(item))
          .toList();

      setState(() {
        // Step D: Update our UI storage with the new list of objects
        _data = cleanProductList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: _data.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    // 3. The Display: Use 'dot notation' to access object properties
                    final product = _data[index];
                    return ListTile(
                      title: Text(product.title),
                      subtitle: Text(product.description),
                      leading: Image.network(product.thumbnail),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
