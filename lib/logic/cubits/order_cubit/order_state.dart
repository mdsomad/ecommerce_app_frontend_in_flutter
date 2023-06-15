import 'package:ecommerce_app_frontend_in_flutter/data/models/order/order_model.dart';

abstract class OrderState {
  final List<OrderModel> orders;
  OrderState(this.orders);
}

class OrderInitialState extends OrderState {
  OrderInitialState() : super( [] );
}

class OrderLoadingState extends OrderState {
  OrderLoadingState(super.orders);
}

class OrderLoadedState extends OrderState {
  OrderLoadedState(super.orders);
}

class OrderErrorState extends OrderState {
  final String message;
  OrderErrorState(this.message, super.orders);
}