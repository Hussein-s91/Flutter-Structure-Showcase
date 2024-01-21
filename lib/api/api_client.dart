import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../models/product_model/product.dart';
import '../models/responses/products_response.dart';
import 'url.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Urls.baseUrl)
abstract class ApiClient<T> {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient<T>;

  @GET(Urls.productsSearch)
  Future<ProductsResponse> getProducts({
    @Query("q") String q = '',
    @Query("limit") int limit = 20,
    @Query("skip") required int skip,
    @Query("select") String select='title,description,price,thumbnail,category',
  });

  @GET("${Urls.products}/{id}")
  Future<Product> getDetails({@Path("id") required int id});

  @GET("${Urls.productsByCategory}/{category}")
  Future<ProductsResponse> getProductsByCategory({
    @Path("category") required String category,
    @Query("limit") int limit = 5,
    @Query("select") String select='title,description,price,thumbnail,category',
  });

}
