import 'package:resturantapp_abdu/model/product.dart';
List<Product> getProductByCategory(String value, List<Product>allproducts) {
  List<Product> products = [];
  try{
    for (var product in allproducts) {
      if (product.pCategory == value) {
        products.add(product);
      }
    }}on Error catch (ex)
  {
    print(ex);
  }
  return products;
}