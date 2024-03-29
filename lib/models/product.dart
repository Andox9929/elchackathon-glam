class Product {
  String id;
  String image;
  String name;
  String description;
  String brand;
  String category;
  List<String> keywords;
  double price;

  Product(this.id, this.image, this.name, this.description, this.brand,
      this.category, this.keywords, this.price);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json["id"],
      json["image"],
      json["name"],
      json["description"],
      json["brand"],
      json["category"],
      json["keywords"],
      json["price"],
    );
  }
}
