class CategoryDetailsModel {
  bool? status;
  String? message;
  Data? data;

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? current_page;
  List<Product> products = [];

  Data.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      products.add(Product.fromJson(element));
    });
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String> images = [];
  bool? in_favorites;
  bool? in_cart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    json['images'].forEach((element) {
      images.add(element);
    });
  }
}
