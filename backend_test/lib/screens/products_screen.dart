import 'dart:convert';
import 'package:backend_test/models/product_model.dart';
import 'package:backend_test/screens/products_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> _data = [];

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
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      List<dynamic> rawProductList = decodedData['products'];

      List<ProductModel> cleanProductList = rawProductList
          .map((item) => ProductModel.fromJson(item))
          .toList();

      setState(() {
        _data = cleanProductList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ProductsList(products: _data),
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  final List<ProductModel> products;
  const ProductsList({super.key, required this.products});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsDetail(product: product),
              ),
            );
          },
          title: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    product.thumbnail,
                    width: width,
                    height: height * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category,
                        style: TextStyle(
                          fontSize: width * 0.06,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 10),

                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 5),

                      Row(
                        children: [
                          Icon(Icons.star_rate_rounded, color: Colors.amber),
                          Text(
                            " ${product.rating}",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${product.price}",
                            style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Add To Bag",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
