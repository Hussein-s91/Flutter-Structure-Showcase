import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'loading_component.dart';

class CarouselComponent extends StatelessWidget {
  final List<String> images;
  final BehaviorSubject? indicatorIndex$;
  const CarouselComponent({Key? key, required this.images, this.indicatorIndex$}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: i,
                  imageBuilder: (context, imageProvider) =>
                    Container(
                      width: 1.sw,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      )
                    ),
                  placeholder: (context, url) => const LoadingComponent(color: Colors.white,),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

                Container(
                  height: double.infinity,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1)
                  ),
                )
              ],
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: double.infinity,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        onPageChanged: (index, carouselPageChangedReason) => indicatorIndex$?.add(index),
        scrollDirection: Axis.horizontal,
      )
    );
  }
}
