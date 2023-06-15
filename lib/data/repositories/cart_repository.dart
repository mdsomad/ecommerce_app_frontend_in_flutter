import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/api.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/cart/cart_item_model.dart';

class CartRepository {
  final _api = Api();





  //TODO: Create fetchCartForUser function
  Future<List<CartItemModel>> fetchCartForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/cart/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => CartItemModel.fromJson(json)).toList();
    }
    catch(ex) {
      rethrow;
    }
  }






  //TODO: Create addToCart function
  Future<List<CartItemModel>> addToCart(CartItemModel cartItem, String userId) async {
    try {
      Map<String, dynamic> data = cartItem.toJson();
      data["user"] = userId;

      Response response = await _api.sendRequest.post(
        "/cart",
        data: jsonEncode(data)
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => CartItemModel.fromJson(json)).toList();
    }
    catch(ex) {
      rethrow;
    }
  }







  // TODO: Create removeFromCart function
  Future<List<CartItemModel>> removeFromCart(String productId, String userId) async {
    try {
      Map<String, dynamic> data = {
        "product": productId,
        "user": userId
      };

      Response response = await _api.sendRequest.delete(
        "/cart",
        data: jsonEncode(data)
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => CartItemModel.fromJson(json)).toList();
    }
    catch(ex) {
      rethrow;
    }
  }








}