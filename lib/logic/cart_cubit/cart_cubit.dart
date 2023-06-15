import 'dart:async';
import 'package:ecommerce_app_frontend_in_flutter/data/models/cart/cart_item_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/product/product_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/repositories/cart_repository.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cart_cubit/cart_state.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;                //* receive _userCubit 
  StreamSubscription? _userSubscription;

  CartCubit(this._userCubit) : super( CartInitialState() ) {
    //* initial Value
    _handleUserState(_userCubit.state);    //* <--  call _initialize call function

    //* Listening to User Cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);  //* <-- call _handleUserState  function
  }

  void _handleUserState(UserState userState) {
    if(userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);    //* <-- call _initialize  function
    }
    else if(userState is UserLoggedOutState) {
      emit( CartInitialState() );
    }
  }




  final _cartRepository = CartRepository();   //TODO: <-- Craete CartRepository class object




// TODO: Create sortAndLoad function
  void sortAndLoad(List<CartItemModel> items) {
    items.sort((a, b) => b.product!.title!.compareTo(a.product!.title!));
    emit(CartLoadedState(items) );
  }



// TODO: Create _initialize function
  void _initialize(String userId)  async {
    emit(CartLoadingState(state.items) );
    try {
      final items = await _cartRepository.fetchCartForUser(userId);
      sortAndLoad(items);
    }
    catch(ex) {
      emit( CartErrorState(ex.toString(), state.items) );
    }
  }





// TODO: Create addToCart function
  void addToCart(ProductModel product, int quantity) async {
    emit( CartLoadingState(state.items) );
    try {
      if(_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        CartItemModel newItem = CartItemModel(
          product: product,
          quantity: quantity
        );

        final items = await _cartRepository.addToCart(newItem, userState.userModel.sId!);
        sortAndLoad(items);
      }
      else {
        throw "An error occured while adding the item!";
      }
    }
    catch(ex) {
      emit( CartErrorState(ex.toString(), state.items) );
    }
  }







  // TODO: Create removeFromCart function
  void removeFromCart(ProductModel product) async {
    emit(CartLoadingState(state.items) );
    try {
      if(_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        final items = await _cartRepository.removeFromCart(product.sId!, userState.userModel.sId!);
        sortAndLoad(items);
      }
      else {
        throw "An error occured while removing the item!";
      }
    }
    catch(ex) {
      emit( CartErrorState(ex.toString(), state.items) );
    }
  }

  bool cartContains(ProductModel product) {
    if(state.items.isNotEmpty) {
      final foundItem = state.items.where((item) => item.product!.sId! == product.sId!).toList();
      if(foundItem.isNotEmpty) {
        return true;
      }
      else {
        return false;
      }
    }
    return false;
  }
  



  // TODO: Create clearCart function
  void clearCart() {
    emit(CartLoadedState([]) );
  }







  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }




}