class CartModel {
  bool? status;
  String? message;
  Data? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<Item> cart_items = [];
  int? sub_total;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cart_items.add(Item.fromJson(element));
    });
    sub_total = json['sub_total'];
    total = json['total'];
  }
}

class Item {
  int? id;
  int? quantity;
  Product? product;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic old_price;
  int? dicount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    dicount = json['dicount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
