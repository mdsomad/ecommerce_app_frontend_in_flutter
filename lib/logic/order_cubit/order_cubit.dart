import 'dart:async';

import 'package:ecommerce_app_frontend_in_flutter/data/models/cart/cart_item_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/order/order_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/repositories/order_repository.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/order_cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {

  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;
  



  OrderCubit(this._userCubit, this._cartCubit) : super( OrderInitialState() ) {
    //* initial Value
    _handleUserState(_userCubit.state);

    //* Listening to User Cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }


  // TODO: Create _handleUserState function
  void _handleUserState(UserState userState) {
    if(userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    }
    else if(userState is UserLoggedOutState) {
      emit(OrderInitialState() );
    }
  }





final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit( OrderLoadingState(state.orders) );
    try {
      final orders = await _orderRepository.fetchOrdersForUser(userId);
      emit( OrderLoadedState(orders) );
    }
    catch(ex) {
      emit( OrderErrorState(ex.toString(), state.orders) );
    }
  }





// TODO: Create createOrder function
Future<bool> createOrder({
    required List<CartItemModel> items,
    required String paymentMethod
  }) async {
    emit( OrderLoadingState(state.orders) );
    try {
      if(_userCubit.state is! UserLoggedInState) {
        return false;
      }

      OrderModel newOrder = OrderModel(
        items: items,
        // totalAmount: Calculations.cartTotal(items),
        user: (_userCubit.state as UserLoggedInState).userModel,
        status: (paymentMethod == "pay-on-delivery") ? "order-placed" : "payment-pending"
      );

      final order = await _orderRepository.createOrder(newOrder);
                                  
      List<OrderModel> orders = [order,...state.orders];   //* <-- New list Create
 
      emit(OrderLoadedState(orders) );
        
      //* Clear the cart
      _cartCubit.clearCart();
       
      return true;
    }
    catch(ex) {
      emit( OrderErrorState(ex.toString(), state.orders) );
      return false;
    }
  }







  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }




}

