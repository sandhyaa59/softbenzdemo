import 'package:flutter/material.dart';
import 'package:softbenzproduct/screens/product_detail_page.dart';
import 'package:softbenzproduct/utils.dart/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Softbenz',
      theme: CustomTheme.lightTheme,
      home:const ProductDetailScreen()
    );
  }
}
