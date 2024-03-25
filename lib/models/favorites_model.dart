class FavoritesModel {
  bool? status;
  String? message;
  Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
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
  bool? in_favorites = true;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['product']['id'];
    price = json['product']['price'];
    old_price = json['product']['old_price'];
    discount = json['product']['discount'];
    image = json['product']['image'];
    name = json['product']['name'];
    description = json['product']['description'];
  }
}
