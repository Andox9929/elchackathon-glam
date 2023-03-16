import 'package:ecommerce_int2/models/product.dart';

List<Product> getProducts() {
  return [
    Product(
      'el_lipstick_red',
      'assets/el_lipstick_red.jpg',
      'Estee Lauder Red Lipstick',
      'A Red Lipstick from Estee Lauder',
      'Estee Lauder',
      'lipstick',
      30.00,
    ),
    Product(
      'el_lipstick_pink',
      'assets/el_lipstick_pink.jpg',
      'Estee Lauder Pink Lipstick',
      'A Pink Lipstick from Estee Lauder',
      'Estee Lauder',
      'lipstick',
      30.00,
    ),
    Product(
      'loreal_lipstick_red',
      'assets/loreal_lipstick_red.jpg',
      'Color Riche Lipstick Matte Red',
      'Indulge in a smooth, long-lasting formula. with 29 shades of matte lipsticks from color riche now in a new packaging.',
      "L'Oréal",
      'lipstick',
      15.00,
    ),
    Product(
      'loreal_lipstick_cherry',
      'assets/loreal_lipstick_cherry.jpg',
      'Color Riche Lipstick Matte Cherry',
      'Indulge in a smooth, long-lasting formula. with 29 shades of matte lipsticks from color riche now in a new packaging.',
      "L'Oréal",
      'lipstick',
      15.00,
    ),
  ];
}

List<Product> getProductsByCategory(String category) {
  List<Product> products = getProducts();
  products = products.where((element) => element.category == category).toList();
  return products;
}

List<Product> getProductsByBrand(String brand) {
  List<Product> products = getProducts();
  products = products.where((element) => element.brand == brand).toList();
  return products;
}
