class CategoryModel {
  bool? status;
  String? message;
  CategoryData? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = CategoryData.fromJson(json['data']);
  }
}

class CategoryData {
  List<Data> data = [];

  CategoryData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  int? id;
  String? name;
  String? image;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
