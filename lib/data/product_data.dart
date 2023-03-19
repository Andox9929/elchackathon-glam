import 'package:ecommerce_int2/models/product.dart';
import 'package:flutter/material.dart';

List<Product> getProducts() {
  return [
    Product(
      'SL1',
      'assets/products/sl1.svg',
      'VELVET CREAM LIQUID LIPSTICK',
      'ULTRA PIGMENTED CREAMY MATTE LIP STAIN',
      'Saint Laurent',
      'lipstick',
      ['lipstick', 'red', 'pigment matte'],
      155.00,
    ),
    Product(
      'CH1',
      'assets/products/ch1.svg',
      'Retro Matte',
      'A vibrant and luminous lipstick. An ultra-fine, melt-away and second-skin texture',
      'Chanel',
      'lipstick',
      ['lipstick', 'red', 'pigment matte'],
      170.00,
    ),
    Product(
      'DO1',
      'assets/products/do1.svg',
      'DIOR ADDICT',
      'Hydrating shine lipstick, 90% natural-origin ingredients',
      "Dior",
      'lipstick',
      ['lipstick', 'red', 'pigment'],
      130.00,
    ),
    Product(
      'MC1',
      'assets/products/mc1.svg',
      'MAC Lustre Glass Lipstick',
      'MAC’s Lustre Glass Lipstick features a glossy finish, imparting ultra-wearable, sheer and buildable color.',
      "MAC",
      'lipstick',
      ['lipstick', 'purple', 'pigment'],
      180.00,
    ),
    Product(
      'MB1',
      'assets/products/mb1.svg',
      'Maybelline Super Stay',
      'A weightless moisture-matte lipstick that delivers a blur of soft-focus color.',
      "Maybelline",
      'lipstick',
      ['lipstick', 'purple', 'pigment'],
      80.00,
    ),
    Product(
      'DO2',
      'assets/products/do2.svg',
      'DIOR Poison',
      'A weightless, long-lasting liquid blush that blends and builds beautifully for a soft, healthy flush.',
      "Dior",
      'lipstick',
      ['lipstick', 'purple', 'pigment'],
      160.00,
    ),
  ];
}

Product getProduct(String id) {
  List<Product> products = getProducts();
  return products.where((element) => element.id == id).first;
}

List<Product> getProductsByCategory(String category) {
  List<Product> products = getProducts();
  products = products.where((element) => element.category == category).toList();
  return products;
}

List<Product> getProductsByKeywords(String str) {
  List<Product> products = getProducts();
  List<String> keywords = str.split(" ");

  List<Product> matchedProducts = [];

  for (var product in products) {
    bool allTagsMatch = true;

    for (var keyword in keywords) {
      if (!product.keywords.contains(keyword)) {
        allTagsMatch = false;
        break;
      }
    }

    if (allTagsMatch) {
      matchedProducts.add(product);
    }
  }
  return matchedProducts;
}

List<Product> getProductsByBrand(String brand) {
  List<Product> products = getProducts();
  products = products.where((element) => element.brand == brand).toList();
  return products;
}
