class SearchModel {
  bool? status;
  String? message;
  SearchResultData? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = SearchResultData.fromJson(json['data']);
  }
}

class SearchResultData {
  int? current_page;
  List<Product> products = [];

  SearchResultData.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      products.add(Product.fromJson(element));
    });
  }
}

class Product {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  List<String> images = [];
  bool? in_favorites;
  bool? in_cart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
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
