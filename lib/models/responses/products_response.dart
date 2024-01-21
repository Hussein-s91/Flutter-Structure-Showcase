import 'package:json_annotation/json_annotation.dart';

import '../product_model/product.dart';


part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  final List<Product>? products;
  final int? total;

  ProductsResponse({
    this.products,
    this.total
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}