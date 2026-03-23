import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductsDetail extends StatefulWidget {
  final ProductModel product;

  const ProductsDetail({super.key, required this.product});

  @override
  State<ProductsDetail> createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Details"), centerTitle: true),
      body: SingleChildScrollView(
        child: Align(
          alignment: AlignmentGeometry.center,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(244, 245, 244, 0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.product.thumbnail,
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

              Column(
                children: [
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.product.category,
                          style: TextStyle(
                            fontSize: width * 0.055,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink[400],
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 248, 191, 211),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: Colors.pinkAccent,
                              ),
                              Text(
                                " ${widget.product.rating}",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    46,
                                    115,
                                  ),
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: 280,
                        child: Text(
                          widget.product.title,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900],
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "\$ ${widget.product.price}",
                        style: TextStyle(
                          fontSize: width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  SizedBox(
                    height: height * 0.3,
                    child: Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.product.description,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
