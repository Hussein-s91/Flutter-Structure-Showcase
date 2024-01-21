part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();
}

class DetailsInitial extends DetailsState {
  @override
  List<Object> get props => [];
}

class DetailsLoading extends DetailsState {
  @override
  List<Object> get props => [];
}

class DetailsSuccess extends DetailsState {
  final Product? details;
  final List<Product>? products;

  const DetailsSuccess({this.details, this.products});

  @override
  List<Object> get props => [];
}

class DetailsError extends DetailsState {
  @override
  List<Object> get props => [];
}