import 'package:firebase_auth/firebase_auth.dart';

class ProductModel {
  String? urlImage;
  String? title;
  String? brand;
  String? price;
  String? type;
  String? size;


  ProductModel({this.urlImage, this.title, this.brand, this.price, this.type, this.size});

  // receiving data from server
  factory ProductModel.fromMap(map)
  {
    return ProductModel(
        urlImage: map['urlImage'],
        title: map['title'],
        brand: map['brand'],
        price : map['price'],
        type: map['type'],
        size: map['size']
    );
  }
  // sending data to our server

  Map<String, dynamic> toMap() {
    return{
      'urlImage': urlImage,
      'title': title,
      'brand': brand,
      'price': price,
      'type': type,
      'size': size,
    };
  }


}