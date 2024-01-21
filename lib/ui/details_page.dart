import 'package:code_structure_showcase/theme/colours.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/details_bloc/details_bloc.dart';
import '../components/error_dialog.dart';
import '../components/horizontal_listview_component.dart';
import '../components/loading_component.dart';
import '../components/scaffold_component.dart';
import '../models/product_model/product.dart';
import '../theme/theme_text.dart';
import '../utils/constants.dart';
import '../utils/spacing.dart';
import '../utils/utils.dart';
import '../utils/routes.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../components/carousel_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  navigateToPage(int id, String category){
    Get.offAndToNamed(Routes.detailsPage, arguments: {'id': id, 'category': category});
  }

  @override
  Widget build(BuildContext context) {
    final DetailsBloc bloc = BlocProvider.of<DetailsBloc>(context);
    final SizedBox heightSpace = SizedBox(height: Spacing.lg,);
    final BehaviorSubject<int> activeIndex$ = BehaviorSubject<int>.seeded(0);

    Product details = Product();
    List<Product> products = [];

    void checkListenerState(DetailsState state, DetailsBloc bloc){
      if(state is DetailsSuccess){
        details = state.details??Product();
        products = state.products??[];

        products.removeWhere((element) => element.id == details.id);
      }
      else if(state is DetailsError){
        showError(
            onPressed: (){
              bloc.add(GetProductDetails(id: Get.arguments['id'], category: Get.arguments['category']));
            }
        );
      }
    }
    bloc.add(GetProductDetails(id: Get.arguments['id'], category: Get.arguments['category']));

    return ScaffoldComponent(
      hasSafeArea: true,
      statusBarColor: Colours.tertiary,
      body: BlocConsumer<DetailsBloc, DetailsState>(
        listener: (context, state) => checkListenerState(state, bloc),
        builder: (context, state) {
          if(state is DetailsLoading){ return const Center(child: LoadingComponent()); }
          else if(state is DetailsError){
            return const SizedBox();
          }
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: false,
                pinned: false,
                floating: false,

                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: StreamBuilder<int>(
                    stream: activeIndex$,
                    initialData: 0,
                    builder: (context, snapshot) {
                      return AnimatedSmoothIndicator(
                        activeIndex: snapshot.data??0,
                        count: details.images?.length??0,
                        effect: const WormEffect(
                          dotHeight: 5,
                          activeDotColor: Colours.tertiary
                        ),
                      );
                    }
                  ),
                  background: CarouselComponent(
                    images: details.images??[],
                    indicatorIndex$: activeIndex$,
                  )
                ), //FlexibleSpaceBar
                expandedHeight: 150,
                backgroundColor: Colours.tertiary,
                leadingWidth: 70,
                leading: GestureDetector(
                  onTap: Get.back,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colours.tertiary.withOpacity(0.8),
                      shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.arrow_back_sharp),
                  ),
                ),
              ), //SliverAppBar
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index){
                    return Column(
                      children: [
                        heightSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Category
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsetsDirectional.all(10),
                                    decoration: BoxDecoration(
                                      color: Colours.secondary.withOpacity(0.2),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(borderRadius)
                                    ),
                                    child: Center(
                                      child: Text(details.category??'', style: ThemeText.subtitle.copyWith(color: Colours.secondary, fontWeight: FontWeight.bold, height: 1.5),),
                                    ),
                                  ),
                                ],
                              ),
                              heightSpace,

                              /// Title
                              Text(details.title??'', style: ThemeText.header,),
                              heightSpace,

                              /// Price and rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.wallet, color: Colours.tertiary,),
                                  Text(' \$${details.price??''}', style: ThemeText.placeholder.copyWith(height: 1.5, color: Colors.grey.withOpacity(0.9)),),
                                  SizedBox(width: Spacing.md,),
                                  SvgPicture.asset('assets/icons/star.svg'),
                                  Text(' ${details.rating??''} Rating', style: ThemeText.placeholder.copyWith(height: 1.5, color: Colors.grey.withOpacity(0.9)),)
                                ],
                              ),

                              heightSpace,

                              /// Description
                              Text(details.description??'', style: ThemeText.subtitle, maxLines: null,),
                              SizedBox(height: Spacing.xxlg,),
                              Text('Similar items', style: ThemeText.subtitle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),),

                            ],
                          ),
                        ),

                        /// Similar item list:
                        SizedBox(
                          height: 190,
                          child: HorizontalListViewComponent(
                            products: products,
                            onTap: navigateToPage
                          )
                        ),
                        SizedBox(height: Spacing.xxlg,),
                      ],
                    );
                  }, //ListTile
                  childCount: 1,
                ), //SliverChildBuildDelegate
              ) //SliverList
            ], //<Widget>[]
          );
        },
      ),
      // floatingActionButton: ButtonComponent(
      //   text: 'Back to home page',
      //   onTap: Get.back,
      // )
    );
  }
}
