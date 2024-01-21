import '../theme/theme_text.dart';
import '../utils/constants.dart';
import '../utils/spacing.dart';
import 'package:flutter/material.dart';
import '../models/product_model/product.dart';
import '../utils/utils.dart';
import 'cached_network_image_component.dart';

class ItemContainerComponent extends StatelessWidget {
  final Product product;
  final void Function(int id, String category) onTap;
  const ItemContainerComponent({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap((product.id??0), (product.category??'')),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const[
            Utils.boxShadow
          ],
          borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: CachedNetworkImageComponent(image: product.thumbnail, fit: BoxFit.fill,)
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(product.title??'', style: ThemeText.title, maxLines: 2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: Spacing.sm,),
                  Text('\$${product.price??''}', style: ThemeText.subtitle,),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
