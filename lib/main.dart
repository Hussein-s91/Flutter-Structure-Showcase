import 'package:code_structure_showcase/ui/splash_page.dart';
import 'package:code_structure_showcase/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'bloc/details_bloc/details_bloc.dart';
import 'bloc/product_bloc/product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ProductBloc>(create: (_) => ProductBloc()),
            BlocProvider<DetailsBloc>(create: (_) => DetailsBloc())
          ],
          child: GetMaterialApp(
            title: 'Flutter Structure Showcase',
            getPages: Routes.routes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Poppins',
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent
            ),
            home: const SplashPage(),
          ),
        );
      }
    );
  }
}