import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/screen/admin/order_screen.dart';
import 'package:resturantapp_abdu/services/store.dart';

class OrderDetails extends StatelessWidget {
  static String id = "OrderDetails" ;
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text(getTranslate(context, "orders_details_page")),),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrderDetails(documentId),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            List<Product> products = [];
            for(var doc in snapshot.data.docs)
            {
              products.add(Product(
                pName: doc.data()[KProductName],
                pQuantity: doc.data()[KProductQuantity],
                pDetails: doc.data()[KProductDetails],
                pDescription: doc.data()[KProductDescription],
              ));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context , index) => Padding(
                      padding: const EdgeInsets.all(21),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF8DE7E),
                          borderRadius: BorderRadius.all(
                              Radius.circular(16)),
                        ),
                        height: MediaQuery.of(context).size.height *.5,
                        child: Padding(
                          padding: const EdgeInsets.all(11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getTranslate(context, "product_name"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${products[index].pName}",style: TextStyle(
                                  fontSize: 19,
                              ),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "quantity"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${products[index].pQuantity}",style: TextStyle(
                                fontSize: 19,
                              ),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "details"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${products[index].pDetails}",style: TextStyle(
                                fontSize: 19,
                              ),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "description"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${products[index].pDescription}",style: TextStyle(
                                fontSize: 19,
                              ),),
                              /*Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ButtonTheme(
                                        buttonColor: KMainColor,
                                        child: RaisedButton(
                                          child: Text(getTranslate(context, "confirm_order")),
                                          onPressed: (){},
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12,),
                                    Expanded(
                                      child: ButtonTheme(
                                        buttonColor: KMainColor,
                                        child: RaisedButton(
                                          child: Text(getTranslate(context, "delete_order")),
                                          onPressed: (){
                                            _store.deleteOrder(documentId);
                                            Navigator.pushNamed(context, OrderScreen.id);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ), //tow button of conf and delete
                              )*/
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: products.length,
                  ), //details of order
                ),

              ],
            );
          }else{
            return Center(child: Text("Loading Orders Details"),);
          }
        }
      ),
    );
  }
}
