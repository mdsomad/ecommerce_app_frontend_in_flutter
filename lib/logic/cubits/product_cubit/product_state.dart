
import 'package:ecommerce_app_frontend_in_flutter/data/models/product/product_model.dart';



//TODO: Create ProductState abstract Class
abstract class ProductState {
  final List<ProductModel> products;
  ProductState(this.products);
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super([]);
}

class ProductLoadingState extends ProductState {
  ProductLoadingState(super.products);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(super.products);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message, super.products);
}