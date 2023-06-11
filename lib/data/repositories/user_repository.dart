import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/api.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/user/user_model.dart';




class UserRepository {
  
  final _api = Api();




//TODO: Create createAccount function
Future<UserModel> createAccount({
    required String email,
    required String password
  }) async {
    try {
      Response response = await _api.sendRequest.post(
        "/user/createAccount",
        data: jsonEncode({
          "email": email,
          "password": password 
        })
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      
      //* convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    }
    catch(ex) {
      rethrow;
    }
  }





//TODO: Create signIn function
Future<UserModel> signIn({
  required String email,
  required String password
}) async {
  try {
    Response response = await _api.sendRequest.post(
      "/user/signIn",
      data: jsonEncode({
        "email": email,
        "password": password 
      })
    );

    ApiResponse apiResponse = ApiResponse.fromResponse(response);

    if(!apiResponse.success) {
      throw apiResponse.message.toString();
    }

    return UserModel.fromJson(apiResponse.data);
  }
  catch(ex) {
    rethrow;
  }
}










  

}