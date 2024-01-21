import '../../api/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model/product.dart';
import '../../models/responses/products_response.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      try{
        if(event is GetProducts){
          emit(ProductLoading());
          ProductsResponse productsResponse = await ApiProvider().getClient().getProducts(skip: 0);
          emit(ProductSuccess(products: productsResponse.products??[], totalProducts: productsResponse.total));
        }
        else if(event is SearchProducts){
          emit(ProductLoading());
          ProductsResponse productsResponse = await ApiProvider().getClient().getProducts(skip: 0, q: event.searchText??'');
          emit(ProductSearchSuccess(products: productsResponse.products??[], totalProducts: productsResponse.total));
        }
        else if(event is GetMoreProducts){
          ProductsResponse productsResponse = await ApiProvider().getClient().getProducts(skip: event.skipNumber??0, q: event.searchText??'');
          emit(ProductSuccess(products: productsResponse.products??[], totalProducts: productsResponse.total));
        }
      }
      catch(error){
        emit(ProductError());
      }
    });
  }
}
