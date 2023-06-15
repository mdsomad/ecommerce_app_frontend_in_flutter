import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/api.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/category/category_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/user/user_model.dart';




class CategoryRepository {
  
  final _api = Api();




//TODO: Create createAccount function
Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => 
      CategoryModel.fromJson(json)
      ).toList();
      
    }
    catch(ex) {
      rethrow;
    }
  }









  

}