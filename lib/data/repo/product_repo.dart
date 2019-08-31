import 'package:flutter/widgets.dart';
import 'package:flutter_app_book_store/data/remote/product_service.dart';

class ProductRepo {
  ProductService _productService;

  ProductRepo({@required ProductService productService})
      : _productService = productService;
}
