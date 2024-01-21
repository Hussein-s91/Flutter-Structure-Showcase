import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/product_model/product.dart';
import 'item_container_component.dart';

class HorizontalListViewComponent extends StatelessWidget {
  final List<Product> products;
  final  void Function(int, String) onTap;
  const HorizontalListViewComponent({Key? key, required this.products, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: products.length,
      padding: const EdgeInsetsDirectional.only(start: 20),
      itemBuilder: (ctx, index){
        Product product = products[index];
        return Container(
          width: 0.4.sw,
          height: 190,
          padding: const EdgeInsetsDirectional.only(top: 5, bottom: 5, end: 20),
          child: ItemContainerComponent(
              product: product,
              onTap: onTap
          ),
        );
      },
    );
  }
}
