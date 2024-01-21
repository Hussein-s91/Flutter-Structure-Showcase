import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product_model/product.dart';
import '../theme/theme_text.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import 'cached_network_image_component.dart';

class ListViewComponent extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Product> products;
  final void Function(int, String) onTap;
  const ListViewComponent({Key? key, this.scrollController, required this.products, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (ctx, index){
        Product product = products[index];
        return GestureDetector(
          onTap: () => onTap((product.id??0), (product.category??'')),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                Utils.boxShadow
              ],
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            child: ListTile(

              leading: SizedBox(
                width: 0.2.sw,
                height: 0.15.sw,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: CachedNetworkImageComponent(image: product.thumbnail,)
                ),
              ),
              title: Text(product.title??'', style: ThemeText.title, maxLines: 1, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,),
              subtitle: Text('${product.description}'??'', style: ThemeText.subtitle, maxLines: 1, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,),
              trailing: Text('\$${product.price}'??'', style: ThemeText.placeholder, maxLines: 1, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis,),
            ),
          ),
        );
      },
    );
  }
}
