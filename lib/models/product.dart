import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

class Product {
  String id;
  String name;
  List<String> pic;
  int price;
  String category;
  String gender;
  String age;
  String sellerid;
  DateTime releaseDate;
  List<ColorSchema> colors;
  List<CommentSchema> comments;
  var rating;
  int promotion;

  Product({
    required this.id,
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
      id: json['_id'],
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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'pic': pic});
    result.addAll({'price': price});
    result.addAll({'category': category});
    result.addAll({'gender': gender});
    result.addAll({'age': age});
    result.addAll({'sellerid': sellerid});
    result.addAll({'releaseDate': releaseDate.millisecondsSinceEpoch});
    result.addAll({'colors': colors.map((x) => x.toMap()).toList()});
    result.addAll({'comments': comments.map((x) => x.toMap()).toList()});
    result.addAll({'rating': rating});
    result.addAll({'promotion': promotion});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id:map['_id'],
      name: map['name'] ?? '',
      pic: List<String>.from(map['pic']),
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] ?? '',
      sellerid: map['sellerid'] ?? '',
      releaseDate: DateTime.fromMillisecondsSinceEpoch(map['releaseDate']),
      colors: List<ColorSchema>.from(
          map['colors']?.map((x) => ColorSchema.fromMap(x))),
      comments: List<CommentSchema>.from(
          map['comments']?.map((x) => CommentSchema.fromMap(x))),
      rating: map['rating']?.toDouble() ?? 0.0,
      promotion: map['promotion']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
}

class ColorSchema {
  String color;
  List<SizeSchema> sizes;

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'color': color});
    result.addAll({'sizes': sizes.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ColorSchema.fromMap(Map<String, dynamic> map) {
    return ColorSchema(
      color: map['color'] ?? '',
      sizes: List<SizeSchema>.from(
          map['sizes']?.map((x) => SizeSchema.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
}

class SizeSchema {
  String value;
  int shoeSize;
  int inStock;

  SizeSchema({
    required this.value,
    required this.shoeSize,
    required this.inStock,
  });

  factory SizeSchema.fromJson(Map<String, dynamic> json) {
    return SizeSchema(
      value: json['value'],
      shoeSize: json['shoeSize'],
      inStock: json['inStock'],
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'value': value});
    result.addAll({'shoeSize': shoeSize});
    result.addAll({'inStock': inStock});

    return result;
  }

  factory SizeSchema.fromMap(Map<String, dynamic> map) {
    return SizeSchema(
      value: map['value'] ?? '',
      shoeSize: map['shoeSize']?.toInt() ?? 0,
      inStock: map['inStock']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
}

class CommentSchema {
  String user;
  String content;
  int rating;

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user': user});
    result.addAll({'content': content});
    result.addAll({'rating': rating});

    return result;
  }

  factory CommentSchema.fromMap(Map<String, dynamic> map) {
    return CommentSchema(
      user: map['user'] ?? '',
      content: map['content'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());
}
