import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/order.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/provider/cart_item.dart';
import 'package:resturantapp_abdu/screen/user/home_page.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp_abdu/services/store.dart';
import 'dart:math';

class OrderView extends StatelessWidget {
  final String prc;
  final String phon;
  final String tim;
  final String servcTpe;
  final String pmntway;
  final Set addrs;
  final String branch;

  static String id = "OrderView";

  const OrderView({Key key, this.prc, this.phon, this.tim,this.servcTpe,this.pmntway,this.addrs,this.branch }) : super(key: key);


  @override
  Widget build(BuildContext context) {

   // int ordernum = Random().nextInt(50);
    List<Product> products = Provider
        .of<CartItem>(context)
        .products;
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return Scaffold(
      backgroundColor: Color(0xFF4B3621),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF4B3621),
        title: Text(getTranslate(context, "my_order"), style: TextStyle(color: Color(0xFFF8DE7E)),),
        //titleSpacing: 30,
        leading: GestureDetector(onTap: () {
          Navigator.pushNamed(context, HomePage.id);
        }, child: Icon(Icons.clear, color: Color(0xFFF8DE7E), size: 30,)),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              LayoutBuilder(
                  builder: (context, constrains) {
                    return Column(
                      children: [
                        Container(
                          height: screenHeight - statusBarHeight -
                              appBarHeight - (screenHeight * .29),
                          child: ListView.builder(itemBuilder:
                              (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF8DE7E),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(16)),
                                ),

                                height: screenHeight * .21,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: Text(
                                        products[index].pQuantity.toString(),
                                        style: TextStyle(fontSize: 30,
                                            fontWeight: FontWeight.bold),),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text(
                                                  products[index].pName,
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight: FontWeight
                                                          .bold),),
                                                Text(
                                                  products[index].pDetails,
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight: FontWeight
                                                          .bold),),
                                                SizedBox(height: 10,),
                                                Text(
                                                  products[index].pDescription,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold),),
                                                Text(
                                                  " SR ${products[index]
                                                      .pFPrice}",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold),),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            );
                          },
                            itemCount: products.length,

                          ),
                        ),
                        Divider(color: Color(0xFF848482),
                          indent: 70,
                          endIndent: 70,
                          thickness: 4,
                          height: 10,),
                        Container(
                          height: screenHeight * .55,
                          width: screenWidth * .8,
                          decoration: BoxDecoration(
                            color: Color(0xFF848482),
                            borderRadius: BorderRadius.all(
                                Radius.circular(16)),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(getTranslate(context, "receipt_time"), style: TextStyle( color: Color(0xFFF8DE7E),fontSize: 18, fontWeight: FontWeight.bold,),),
                                Text(tim, style: TextStyle(color: Color(0xFFF8DE7E),fontSize: 18, fontWeight: FontWeight.bold, ),),
                                Text(getTranslate(context, "branch"), style: TextStyle( color: Color(0xFFF8DE7E),fontSize: 18, fontWeight: FontWeight.bold,),),
                                Text(branch, style: TextStyle(color: Color(0xFFF8DE7E),fontSize: 18, fontWeight: FontWeight.bold, ),),
                                SizedBox(height: 5,),
                                Text(getTranslate(context, "address"), style: TextStyle( color: Color(0xFFF8DE7E),fontSize: 18, fontWeight: FontWeight.bold,),),
                                Text(addrs.toString(), style: TextStyle(color: Color(0xFFF8DE7E),fontSize: 18, fontWeight: FontWeight.bold, ),),
                                SizedBox(height: 5,),
                                Text(getTranslate(context, "total_price"), style: TextStyle(color: Color(0xFFF8DE7E), fontSize: 18, fontWeight: FontWeight.bold),),
                                Text("SR $prc", style: TextStyle(color: Color(0xFFF8DE7E), fontSize: 18, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text(getTranslate(context, "order_number"), style: TextStyle(color: Color(0xFFF8DE7E), fontSize: 18, fontWeight: FontWeight.bold),),
                                Text(phon, style: TextStyle(color: Color(0xFFF8DE7E), fontSize: 18, fontWeight: FontWeight.bold),),

                                 ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(getTranslate(context, "for_contacting"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        )
                      ],
                    );
                  }
              ), //
            ],
          ),
        ],
      ),

    );
  }
}



