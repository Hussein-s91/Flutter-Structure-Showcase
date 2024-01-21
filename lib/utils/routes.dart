import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/details_page.dart';
import '../ui/products_page.dart';



class Routes{
  static const String homePage = '/homePage';
  static const String detailsPage = '/detailsPage';
  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: homePage,
      page: () => const ProductsPage(),
    ),

    GetPage(
      name: detailsPage,
      page: () => const DetailsPage(),
    ),
  ];
}