import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/screen/admin/add_product.dart';
import 'package:resturantapp_abdu/screen/admin/manage_product.dart';
import 'package:resturantapp_abdu/screen/admin/order_screen.dart';
import 'package:resturantapp_abdu/screen/login_screen.dart';

class AdminHome extends StatelessWidget {
  static String id = "AdminHome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(getTranslate(context, "admin_page")),
        backgroundColor: Colors.lightBlue,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,size: 30,),
          onPressed: (){
            Navigator.pushNamed(context, LoginScreen.id);
          },),

      ),
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          RaisedButton(onPressed: () {Navigator.pushNamed(context, AddProduct.id);}, child: Text(getTranslate(context, "add_product")),),
          RaisedButton(onPressed: (){Navigator.pushNamed(context, ManageProduct.id);}, child: Text(getTranslate(context, "manage_product")),),
          RaisedButton(onPressed: (){Navigator.pushNamed(context, OrderScreen.id);}, child: Text(getTranslate(context, "view_orders")),),
        ],
      ),
    );
  }
}
