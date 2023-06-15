import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/api.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/order/order_model.dart';




class OrderRepository {



  final _api = Api();  //* <-- Create Api class object





  // TODO: Create fetchOrdersForUser function
  Future<List<OrderModel>> fetchOrdersForUser(String userId) async {
    try {
      
      Response response = await _api.sendRequest.get("/order/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => OrderModel.fromJson(json)).toList();
    }
    catch(ex) {
      rethrow;
    }
  }








  // TODO: Create createOrder function
  Future<OrderModel> createOrder(OrderModel orderModel) async {
    try {
      Response response = await _api.sendRequest.post(
        "/order",
        data: jsonEncode(orderModel.toJson())
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return OrderModel.fromJson(apiResponse.data);
    }
    catch(ex) {
      rethrow;
    }
  }







  // TODO: Create updateOrder function
  Future<OrderModel> updateOrder(OrderModel orderModel, {
    String? paymentId,
    String? signature
  }) async {
    try {
      Response response = await _api.sendRequest.put(
        "/order/updateStatus",
        data: jsonEncode({
          "orderId": orderModel.sId,
          "status": orderModel.status,
          "razorPayPaymentId": paymentId,
          "razorPaySignature": signature
        })
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return OrderModel.fromJson(apiResponse.data);
    }
    catch(ex) {
      rethrow;
    }
  }








}