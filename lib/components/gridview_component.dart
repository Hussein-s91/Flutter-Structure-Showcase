import 'package:flutter/material.dart';
import '../models/product_model/product.dart';
import 'item_container_component.dart';

class GridViewComponent extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Product> products;
  final void Function(int, String) onTap;
  const GridViewComponent({
    Key? key,
    this.scrollController,
    required this.products,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
        //controller: scrollController,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 147 / 184,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext ctx, index) {
          Product product = products[index];
          return ItemContainerComponent(
            product: product,
            onTap: (id, category) => onTap(id, category)
          );
        }
    );
  }
}
