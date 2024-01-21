import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api_provider.dart';
import '../../models/product_model/product.dart';
import '../../models/responses/products_response.dart';


part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()){
    on<DetailsEvent>((event, emit) async {
      try{
        if(event is GetProductDetails){
          emit(DetailsLoading());

          // fetch details and similar products by category
          var responses = await Future.wait([
            ApiProvider().getClient().getDetails(id: event.id),
            ApiProvider().getClient().getProductsByCategory(category: event.category),
          ]);

          Product? details = responses[0] as Product;
          List<Product>? products = (responses[1] as ProductsResponse).products;

          // check if details returned are not null by checking the id
          if(details.id != null){
            emit(DetailsSuccess(
              details: details,
              products: products,
            ));
          }
          else{
            emit(DetailsError());
          }

        }
      }
      catch(error){
        emit(DetailsError());
      }
    });
  }
}
