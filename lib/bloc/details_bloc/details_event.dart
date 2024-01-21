part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class GetProductDetails extends DetailsEvent {
  final int id;
  final String category;
  const GetProductDetails({required this.id, this.category = ''});

  @override
  List<Object?> get props => [id, category];
}