part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProducts extends ProductEvent {
  const GetProducts();
  @override
  List<Object?> get props => [];
}

class GetMoreProducts extends ProductEvent {
  final int skipNumber;
  final String searchText;
  const GetMoreProducts({required this.skipNumber, this.searchText = ''});
  @override
  List<Object?> get props => [skipNumber, searchText];
}

class SearchProducts extends ProductEvent {
  final String? searchText;
  const SearchProducts({required this.searchText});
  @override
  List<Object?> get props => [];
}