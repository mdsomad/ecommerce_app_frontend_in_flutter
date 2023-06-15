import 'package:dio/dio.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/api.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/product/product_model.dart';




class ProductRepository {
  final _api = Api();



  //TODO: Create fetchAllProducts function 
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get("/product");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => 
      ProductModel.fromJson(json)).toList();

      
    }
    catch(ex) {
      rethrow;
    }
  }





  //TODO: Create fetchProductsByCategory function 
   Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
    try {
      Response response = await _api.sendRequest.get("/product/category/$categoryId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
    }
    catch(ex) {
      rethrow;
    }
  }




}