class RegisterModel {
  bool? status;
  String? message;
  Data? data;

  RegisterModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;

  Data.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}