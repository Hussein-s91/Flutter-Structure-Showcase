part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductSuccess extends ProductState {
  final List<Product> products;
  final int? totalProducts;

  const ProductSuccess({required this.products, this.totalProducts});

  @override
  List<Object> get props => [products];
}

class ProductSearchSuccess extends ProductState {
  final List<Product> products;
  final int? totalProducts;

  const ProductSearchSuccess({required this.products, this.totalProducts});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  @override
  List<Object> get props => [];
}