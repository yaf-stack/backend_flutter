// 1. The Blueprint: This class defines what a "Product" looks like in our app
class ProductModel {
  final String title;
  final String description;
  final String thumbnail;
  final String category;
  final double price;
  final double rating;

  ProductModel({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.price,
    required this.rating,
  });

  // The "Bridge": This factory takes a Map (from JSON) and builds a Product object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      category: json['category'],
      price: json['price'],
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'category': category,
      'price': price,
      'rating': rating,
    };
  }
}
