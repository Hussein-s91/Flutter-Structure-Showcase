import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(includeIfNull: false)
class Product {
  final int? id;
  final String? title;
  final String? description;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final num? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String>? images;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}