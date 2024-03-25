class FavoriteChangeModel {
  bool? status;
  String? message;
  Data? data;

  FavoriteChangeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? id;
  Product? product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  int? price;
  int? old_price;
  int? discount;
  String? image;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
