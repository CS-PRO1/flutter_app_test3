class ProductModel {
  bool? status;
  String? message;
  Data? data;

  ProductModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images = [];
  bool? in_favorites;
  bool? in_cart;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
