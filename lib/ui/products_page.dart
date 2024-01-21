import 'package:code_structure_showcase/theme/colours.dart';
import 'package:code_structure_showcase/theme/colours.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart' hide View;
import '../bloc/product_bloc/product_bloc.dart';
import '../components/error_dialog.dart';
import '../components/gridview_component.dart';
import '../components/listview_component.dart';
import '../components/loading_component.dart';
import '../components/scaffold_component.dart';
import '../models/product_model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/text_field_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme_text.dart';
import '../utils/constants.dart';
import '../utils/debouncer.dart';
import '../utils/enums.dart';
import '../utils/routes.dart';
import '../utils/spacing.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  late final ProductBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  bool loadMore = false;
  int _totalProducts = 0;
  List<Product> _products = [];
  final _deBouncer = DeBouncer(milliseconds: 1000);
  final BehaviorSubject<bool> _showLoader$ = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<View> _view$ = BehaviorSubject<View>.seeded(View.gridView);
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ProductBloc>(context);

    _scrollController.addListener(() {
      if((_scrollController.position.maxScrollExtent - _scrollController.position.pixels <= 1) && (_totalProducts - _products.length>0)){
        _showLoader$.add(true);
      }
      else{
        _showLoader$.add(false);
      }
      if((_scrollController.position.maxScrollExtent - _scrollController.position.pixels == 0) && (_totalProducts - _products.length>0)){
        _bloc.add(GetMoreProducts(skipNumber: _products.length));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _bloc.close();
    _showLoader$.close();
    _view$.close();
    super.dispose();
  }

  void checkListenerState(ProductState state, ProductBloc bloc){
    if(state is ProductSuccess){
      _showLoader$.add(false);
      _products = _products..addAll(state.products);
      _totalProducts = state.totalProducts??0;
    }
    else if(state is ProductSearchSuccess){
      _showLoader$.add(false);
      _products = state.products;
      _totalProducts = state.totalProducts??0;
    }
    else if(state is ProductError){
      showError(
          onPressed: (){
            _bloc.add(const GetProducts());
          }
      );
    }
  }

  void searchProducts(String text){
    if(text.isEmpty){
      _searchController.clear();
    }
    _deBouncer.run(() {
      _bloc.add(SearchProducts( searchText: _searchController.text));
    });
  }

  navigateToPage(int id, String category){
    Get.toNamed(Routes.detailsPage, arguments: {'id': id, 'category': category});
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus, // Dismiss keyboard by tapping outside the text field component
      child: ScaffoldComponent(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              SizedBox(height: Spacing.lg,),

              /// Header:
              Text('Find your favorite product', style: ThemeText.header,),
              SizedBox(height: Spacing.lg,),

              /// Search TextField:
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: TextFieldComponent(
                      controller: _searchController,
                      placeHolder: 'Search products',
                      onChanged: searchProducts,
                      onSuffixIconTap: () => _searchController.text.isEmpty ? null : searchProducts(''),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.grid_view, color: Colours.tertiary,),
                      onPressed: () => _view$.add(View.gridView),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.list, color: Colours.tertiary,),
                      onPressed: () => _view$.add(View.listView),
                    ),
                  ),


                ],
              ),
              SizedBox(height: Spacing.md,),

              /// Products:
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  child: StreamBuilder<View>(
                      stream: _view$,
                      initialData: View.gridView,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            BlocConsumer<ProductBloc, ProductState>(
                              listener: (context, state) => checkListenerState(state, _bloc),
                              builder: (context, state) {
                                if(state is ProductInitial){
                                  _bloc.add(const GetProducts());
                                }
                                else if(state is ProductLoading){
                                  return const Center(child: LoadingComponent());
                                }
                                return (_searchController.text.isNotEmpty && _products.isEmpty) ?
                                Image.asset('assets/images/no_data.jpeg')
                                    :
                                snapshot.data == View.listView ?
                                ListViewComponent(products: _products, onTap: navigateToPage)
                                    :
                                GridViewComponent(
                                  onTap: navigateToPage,
                                  products: _products,
                                  scrollController: _scrollController,
                                );
                              },
                            ),
                            StreamBuilder<bool>(
                                stream: _showLoader$,
                                initialData: false,
                                builder: (context, snapshot) {
                                  return (snapshot.data??false) ? Container(
                                    color: Colors.transparent,
                                    height: 100,
                                    width: 1.sw,
                                    child: const Center(
                                      child: LoadingComponent(),
                                    ),
                                  ) : const SizedBox();
                                }
                            )
                          ],
                        );
                      }
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

