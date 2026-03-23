import 'package:backend_test/data/product_data.dart';
import 'package:backend_test/models/product_model.dart';
import 'package:backend_test/screens/products_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> _data = [];
  final ProductsData productsData = ProductsData();

  @override
  void initState() {
    super.initState();
    fetchData(); // Run the network request when the app starts
  }

  Future<void> fetchData() async {
    final cleanProductList = await productsData.fetchProducts();

    // GET request to the API
    setState(() {
      _data = cleanProductList;
    });
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
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail,
                    width: width,
                    height: height * 0.4,
                    fit: BoxFit.cover,

                    placeholder: (context, url) => Container(
                      height: height * 0.4,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
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
