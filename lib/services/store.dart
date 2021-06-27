import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/model/product.dart';
class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //this method to add product to database
  addProduct(Product product) {
    // here i ask fire store to go to collection that if not present it will create new one to pass data to it
    _firestore.collection(KProductCollection).add(
        {
          KProductName: product.pName,
          KProductFPrice: product.pFPrice,
          KProductMPrice: product.pMPrice,
          KProductSPrice: product.pSPrice,
          KProductDescription: product.pDescription,
          KProductDetails: product.pDetails,
          KProductCategory: product.pCategory,
          KProductLocation: product.pLocation,
        });
  }
  //this method will fetch data from firebase
  Stream <QuerySnapshot> loadProduct() {
    return _firestore.collection(KProductCollection).snapshots();
  }
  //this method will delete product admin from edit product screen
  deleteProduct(documentId) {
    _firestore.collection(KProductCollection).document(documentId).delete();
  }
//this method to edit product by admin
  editProduct(data, documentId) {
    _firestore.collection(KProductCollection).document(documentId).updateData(
        data);
  }
  stroeOrders(data, List<Product>products)
  {
    var documentRef = _firestore.collection(KOrders).doc();
    documentRef.set(data);
    for(var product in products){
    documentRef.collection(KOrderDetails).doc().set({
      KProductName : product.pName,
      KProductFPrice : product.pFPrice,
      KProductQuantity : product.pQuantity,
      KProductDescription : product.pDescription,
      KProductDetails : product.pDetails,
    });
  }}
  Stream<QuerySnapshot> loadOrders ()
  {
    return _firestore.collection(KOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails (documentId)
  {
    return _firestore.collection(KOrders).doc(documentId).collection(KOrderDetails).snapshots();
  }
  deleteOrder(documentId) {
    _firestore.collection(KOrders).document(documentId).delete();
  }

}