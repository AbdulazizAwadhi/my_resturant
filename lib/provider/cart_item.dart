import 'package:flutter/cupertino.dart';
import 'package:resturantapp_abdu/model/product.dart';

class CartItem extends ChangeNotifier
{
  List<Product> products = [];

  addProduct(Product product)
  {
    products.add(product);
    notifyListeners();
  }
  deleteProduct(Product product)
  {
    products.remove(product);
    notifyListeners();
  }
  deleteAllProduct(Product)
  {
    products.remove(Product);
    notifyListeners();
  }
}