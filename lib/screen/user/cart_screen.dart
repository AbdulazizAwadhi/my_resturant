import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/provider/cart_item.dart';
import 'package:resturantapp_abdu/screen/maps.dart';
import 'package:resturantapp_abdu/screen/user/home_page.dart';
import 'package:resturantapp_abdu/screen/user/order_view.dart';
import 'package:resturantapp_abdu/screen/user/product_info.dart';
import 'package:resturantapp_abdu/services/store.dart';

class CartScreen extends StatefulWidget {

  static String id = "CartScreen" ;
  final Set addressDetails;


  const CartScreen({Key key, this.addressDetails}) : super(key: key);



  @override
  _CartScreenState createState() => _CartScreenState(addressDetails: this.addressDetails);
}

class _CartScreenState extends State<CartScreen> {

  final Set addressDetails;

   _CartScreenState({this.addressDetails});
  String radioItembranch = 'Makkah';
  String radioItemservice = 'pickup_order';
  String radioItempay = 'cash';
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {

   List<Product> products = Provider.of<CartItem>(context).products;
   final double screenHeight = MediaQuery.of(context).size.height;
   final double screenWidth = MediaQuery.of(context).size.width;
   final double appBarHeight = AppBar().preferredSize.height;
   final double statusBarHeight = MediaQuery.of(context).padding.top;
   return Scaffold(
     resizeToAvoidBottomPadding: false,
     appBar: AppBar(
       elevation: 0,
       backgroundColor: Colors.white,
       centerTitle: true,
       title: Text(getTranslate(context, "my_cart") , style: TextStyle(color: KMainColor),),titleSpacing: 40,
       leading: GestureDetector(onTap: ()
       {
         Navigator.pushNamed(context , HomePage.id);
       },child: Icon(Icons.arrow_back,color: KMainColor,size: 30,)),
     ),
      body: ListView(
        children: [
          Column(
            children: [
              LayoutBuilder(
                builder:(context , constrains) {
                  if(products.isNotEmpty) {
                    return Column(
                      children: [
                        Container(
                          height: screenHeight - statusBarHeight - appBarHeight -(screenHeight * .24),
                          child: ListView.builder(itemBuilder:
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF8DE7E),
                                      borderRadius: BorderRadius.all(Radius.circular(16)),
                                    ),

                                    height: screenHeight * .17,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 20),
                                          child: Text(
                                            products[index].pQuantity.toString(),
                                            style: TextStyle(fontSize: 16,
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
                                                      " SR ${products[index].pFPrice}",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold),),
                                                  ],
                                                ),
                                              ),
                                              IconButton(tooltip: "Delete",
                                                icon: Icon(
                                                  Icons.delete, color: Colors.red,
                                                  size: 25,), onPressed: () {
                                                Provider.of<CartItem>(
                                                    context, listen: false)
                                                    .deleteProduct(products[index]);
                                              },),
                                              //there are some logic needs to control in IconButton(tooltip: "Edit", icon: Icon(Icons.edit, color: Colors.green, size: 25,), onPressed: () {Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);},),
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
                        Divider(color: KMainColor, indent: 70, endIndent: 70, thickness: 4, height: 10, ),
                        Text(getTranslate(context, "type_of_service"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KMainColor),),
                        SizedBox(height: 8,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Maps.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF8DE7E),
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                              ),
                              width: 250,
                              height: 50,
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.location_on, size: 40,),
                                  SizedBox(width: 5,),
                                  Text(getTranslate(context, "select_your_location"), style: TextStyle(fontSize: 18),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        RadioListTile(
                          groupValue: radioItemservice,
                          title: Text(getTranslate(context, "delivery")),
                          value: getTranslate(context, "delivery"),
                          activeColor: KMainColor,
                          onChanged: (val) {
                            setState(() {
                              radioItemservice = val;
                            });
                          },
                        ),
                        RadioListTile(
                          groupValue: radioItemservice,
                          title: Text(getTranslate(context, "pickup_order")),
                          value: getTranslate(context, "pickup_order"),
                          activeColor: KMainColor,
                          onChanged: (val) {
                            setState(() {
                              radioItemservice = val;
                            });
                          },
                        ),

                        Divider(color: KMainColor, indent: 70, endIndent: 70, thickness: 4, height: 10, ),
                        Text(getTranslate(context, "branch"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KMainColor),),
                        RadioListTile(
                          groupValue: radioItembranch,
                          activeColor: KMainColor,
                          title: Text(getTranslate(context, "makkah")),
                          value: getTranslate(context, "makkah"),
                          onChanged: (val) {
                            setState(() {
                              radioItembranch = val;
                            });
                          },
                        ),
                        RadioListTile(
                          groupValue: radioItembranch,
                          title: Text(getTranslate(context, "riyadh")),
                          value: getTranslate(context, "riyadh"),
                          activeColor: KMainColor,
                          onChanged: (val) {
                            setState(() {
                              radioItembranch = val;
                            });
                          },
                        ),
                        Divider(color: KMainColor, indent: 70, endIndent: 70, thickness: 4, height: 10, ),
                        Text(getTranslate(context, "receipt_time"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KMainColor),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(

                            decoration: BoxDecoration(
                              color: Color(0xFFF8DE7E),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                            width: screenWidth * .6,
                            height: screenHeight * .10,

                            child: SizedBox(height: 100,
                              child: CupertinoDatePicker(
                                initialDateTime: _dateTime,
                                use24hFormat: true,
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: (dateTime)
                                {
                                  //print(dateTime);
                                  setState(() {
                                    _dateTime = dateTime;

                                  });

                                },
                              ),
                            ),
                          ),
                        ),
                        Divider(color: KMainColor, indent: 70, endIndent: 70, thickness: 4, height: 10, ),

                        Text(getTranslate(context, "pay_way"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KMainColor),),
                        RadioListTile(
                          groupValue: radioItempay,
                          title: Text(getTranslate(context, "cash")),
                          value: getTranslate(context, "cash"),
                          activeColor: KMainColor,
                          onChanged: (val) {
                            setState(() {
                              radioItempay = val;
                            });
                          },
                        ),
                        RadioListTile(
                          groupValue: radioItempay,
                          title: Text(getTranslate(context, "mada_card")),
                          value: getTranslate(context, "mada_card"),
                          activeColor: KMainColor,
                          onChanged: (val) {
                            setState(() {
                              radioItempay = val;
                            });
                          },
                        ),
                      ],
                    );
                  }else{
                    return Container(
                      height: screenHeight - (screenHeight * .08) - appBarHeight - statusBarHeight,
                      child: Center(
                      child: Text(getTranslate(context, "cart_is_empty")),
                      ) ,
                    );
                  }
                }
              ), // details of order

              Builder(
                builder:(context) => ButtonTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                  ),
                  minWidth: screenWidth,
                  height: screenHeight * .08,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: KMainColor,
                    onPressed: ()
                    {

                      showCustomDialog(products , context);

                    },
                    child: Text(getTranslate(context, "confirm_order"),style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                ),
              ), //order button
            ],
          ),
        ],
      ),
    );

  }

  void showCustomDialog(List<Product> products , context) async
  {

    var price = getTotalPrice(products);
    var phonenumber;
    var time_of_receipt = _dateTime;

    AlertDialog alertDialog = AlertDialog(
      actions: [

        MaterialButton(
          child: Text(getTranslate(context, "confirm")),
          onPressed: ()
          {

            if(phonenumber.toString().isEmpty || phonenumber.toString().length <10){
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(getTranslate(context, "error_invalid_please_insert_correct_phone_number")),
              ));
              Navigator.pop(context);
            }else
            {
              try {
                Store _store = Store();
                _store.stroeOrders({
                  KTotalPrice: price,
                  KPhoneNumber: phonenumber,
                  KTimeofreceipt: time_of_receipt.toString(),
                  KServiceType: radioItemservice,
                  Kpay: radioItempay,
                  KAddress: addressDetails.toString(),
                  KBranch: radioItembranch,
                }, products);
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text("Ordered Successfully"),
                // ));
                String pr = price.toString();
                String phn = phonenumber.toString();
                String tm = time_of_receipt.toString();
                String st = radioItemservice;
                String pw = radioItempay;
                Set ad = addressDetails;
                String brnch = radioItembranch;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_){return OrderView(prc: pr,phon: phn, tim: tm, servcTpe: st, pmntway: pw,addrs: ad,branch: brnch, );}
                )
                );

              }catch(ex)
              {
                print("CARTSCREEN $ex.message");
              }
            }

          },
        ),

      ],
      content: TextField(
        onChanged: (value)
        {
          phonenumber = value ;
        },
        decoration: InputDecoration(hintText: getTranslate(context, "enter_your_phone_number")),
      ),
      title: Text("Total Price = SR $price"),
    );
    await showDialog(context: context,builder:(context)
    {
      return alertDialog;

    });
  }



  getTotalPrice(List<Product> products)
  {
    double price = 0;
    for( var product in products)
    {
      price += product.pQuantity * double.parse(product.pFPrice);
    }
    return price ;
  }
}
