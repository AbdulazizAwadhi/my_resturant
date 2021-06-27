import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/order.dart';
import 'package:resturantapp_abdu/screen/admin/admin_home.dart';
import 'package:resturantapp_abdu/screen/admin/order_details.dart';
import 'package:resturantapp_abdu/services/store.dart';

class OrderScreen extends StatelessWidget {
  static String id = "OrderScreen";
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text(getTranslate(context, "order_screen_page")),
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context , AdminHome.id);
            },
            child: Icon(Icons.arrow_back, color: Colors.black, size: 30,)
        ),),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context , snapshot)
        {
          if(!snapshot.hasData)
          {
            return Center(
              child: Text(getTranslate(context, "there_is_no_orders")),
            );
          }else
            {
              List<Order> orders = [];
              for(var doc in snapshot.data.docs)
                {
                  orders.add(Order(
                    documentId: doc.id,
                    totalPrice: doc.data()[KTotalPrice],
                    phoneNumber: doc.data()[KPhoneNumber],
                    time: doc.data()[KTimeofreceipt].toString(),
                    serviceType: doc.data()[KServiceType],
                    pay: doc.data()[Kpay],
                    address: doc.data()[KAddress],
                    branch: doc.data()[KBranch]
                  ));
                }
              return ListView.builder(
                  itemBuilder: (context , index) => Padding(
                    padding: const EdgeInsets.all(21),
                    child: GestureDetector(
                      onTap: ()
                      {
                        Navigator.pushNamed(context, OrderDetails.id , arguments: orders[index].documentId);
                      },
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(

                              Radius.circular(16)),
                          color: Color(0xFFF8DE7E),
                        ),
                        height: MediaQuery.of(context).size.height *.7,
                        child: Padding(
                          padding: const EdgeInsets.all(11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getTranslate(context, "total_price"),style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${orders[index].totalPrice.toString()}",style: TextStyle(
                                  fontSize: 19,
                              ),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "phone_number"),style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${orders[index].phoneNumber}",style: TextStyle(
                                  fontSize: 19,
                              ),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "receipt_time"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${orders[index].time}",style: TextStyle(
                                fontSize: 19,
                              ),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "type_of_service"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${orders[index].serviceType}",style: TextStyle(
                                fontSize: 19,
                              ),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "pay_way"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${orders[index].pay}",style: TextStyle(
                                fontSize: 19,
                              ),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "address"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${orders[index].address.toString()}",style: TextStyle(fontSize: 19,),),
                              SizedBox(height: 10,),
                              Text(getTranslate(context, "branch"),style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${orders[index].branch}",style: TextStyle(fontSize: 19,),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                itemCount: orders.length,
              );
            }
        },
      ),
    );
  }
}
