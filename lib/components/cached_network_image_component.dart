import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_component.dart';

class CachedNetworkImageComponent extends StatelessWidget {
  final String? image;
  final BoxFit? fit;
  const CachedNetworkImageComponent({Key? key, this.image, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image??'',
      imageBuilder: (context, imageProvider) =>
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit??BoxFit.cover,
                ),
              )
          ),
      placeholder: (context, url) => const LoadingComponent(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
