import 'package:json_annotation/json_annotation.dart';



class Product {
  final String name;
  final List<String> pic;
  final double price;
  final String category;
  final String gender;
  final String age;
  final String sellerid;
  final DateTime releaseDate;
  final List<ColorSchema> colors;
  final List<CommentSchema> comments;
  final double rating;
  final int promotion;

  Product({
    required this.name,
    required this.pic,
    required this.price,
    required this.category,
    required this.gender,
    required this.age,
    required this.sellerid,
    required this.releaseDate,
    required this.colors,
    required this.comments,
    required this.rating,
    required this.promotion,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      pic: json['pic'].cast<String>(),
      price: json['price'],
      category: json['category'],
      gender: json['gender'],
      age: json['age'],
      sellerid: json['sellerid'],
      releaseDate: DateTime.parse(json['releaseDate']),
      colors: (json['colors'] as List)
         .map((colorJson) => ColorSchema.fromJson(colorJson))
         .toList(),
      comments: (json['comments'] as List)
         .map((commentJson) => CommentSchema.fromJson(commentJson))
         .toList(),
      rating: json['rating'],
      promotion: json['promotion'],
    );
  }

}

class ColorSchema {
  final String color;
  final List<SizeSchema> sizes;

  ColorSchema({
    required this.color,
    required this.sizes,
  });
  factory ColorSchema.fromJson(Map<String, dynamic> json) {
    return ColorSchema(
      color: json['color'],
      sizes: (json['sizes'] as List)
         .map((sizeJson) => SizeSchema.fromJson(sizeJson))
         .toList(),
    );
  }

}

class SizeSchema {
  final String value;
  final int shoeSize;
  final int inStock;

  SizeSchema({
    required this.value,
    required this.shoeSize,
    required this.inStock,
  });

  factory SizeSchema.fromJson(Map<String, dynamic> json) {
    return SizeSchema(
      value: json['value'],
      shoeSize: json['ShoeSize'],
      inStock: json['inStock'],
    );
  }
}

class CommentSchema {
  final String user;
  final String content;
  final double rating;

  CommentSchema({
    required this.user,
    required this.content,
    required this.rating,
  });

  factory CommentSchema.fromJson(Map<String, dynamic> json) {
    return CommentSchema(
      user: json['user'],
      content: json['content'],
      rating: json['rating'],
    );
  }
}