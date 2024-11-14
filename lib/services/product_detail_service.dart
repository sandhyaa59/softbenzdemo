import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:softbenzproduct/screens/product_detail_response.dart';

class ProductDetailService{
 static final dio = Dio();

  static Future<dynamic> getProductDetails()async{
    try {
 var response= await    dio.get('https://api.melabazaar.com.np/api/v1/items/product_list/realme-c30/?format=json');
 if(response.statusCode==200){
  Product product=Product.fromJson(response.data["data"]);
  return product;
 }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}