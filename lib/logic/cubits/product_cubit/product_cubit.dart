import 'package:ecommerce_app_frontend_in_flutter/data/repositories/product_repository.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Create ProductCubit Class
class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super( ProductInitialState() ) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit( ProductLoadingState(state.products) );
    try {
      final products = await _productRepository.fetchAllProducts();
      emit( ProductLoadedState(products) );
    }
    catch(ex) {
      emit( ProductErrorState(ex.toString(), state.products) );
    }
  }
}