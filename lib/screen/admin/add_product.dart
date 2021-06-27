import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/screen/admin/admin_home.dart';
import 'package:resturantapp_abdu/widgets/custom_text_field.dart';
import 'package:resturantapp_abdu/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProduct extends StatelessWidget {
  final _store =Store();
  static String id = "AddProduct";
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _name , _Fprice , _Mprice, _Sprice , _description , _category ,_imageLocation ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(getTranslate(context, "add_product_page")),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            SizedBox(height: 35,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(hint: getTranslate(context, "product_name"), OnClick:(value){_name=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_full_price"),OnClick:(value){_Fprice=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_medium_price"),OnClick:(value){_Mprice=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_small_price"),OnClick:(value){_Sprice=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_description"),OnClick:(value){_description=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_category"),OnClick:(value){_category=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_location"),OnClick:(value){_imageLocation=value;} ,),
                SizedBox(height: 20,),
                RaisedButton(
                  onPressed: ()
                {
                  if(_globalKey.currentState.validate())
                    {
                      _globalKey.currentState.save();
                      _store.addProduct(Product(
                        pName: _name,
                        pFPrice: _Fprice,
                        pMPrice: _Mprice,
                        pSPrice: _Sprice,
                        pDescription: _description,
                        pCategory: _category,
                        pLocation: _imageLocation,
                      ));
                      Navigator.pushNamed(context, AdminHome.id);
                    }
                },
                  child: Text(getTranslate(context, "add_product")),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
