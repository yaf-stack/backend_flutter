// 1. The Blueprint: This class defines what a "Product" looks like in our app
class Product {
  final String title;
  final String description;
  final String thumbnail;

  Product({
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  // The "Bridge": This factory takes a Map (from JSON) and builds a Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
    );
  }
}