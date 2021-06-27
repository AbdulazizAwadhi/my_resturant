import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/screen/admin/admin_home.dart';
import 'package:resturantapp_abdu/screen/admin/manage_product.dart';
import 'package:resturantapp_abdu/services/store.dart';
import 'package:resturantapp_abdu/widgets/custom_text_field.dart';

class EditProduct extends StatelessWidget {
  static String id = "EditProduct";

  final _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _name, _Fprice,_Mprice, _Sprice, _description, _category, _imageLocation;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      appBar: AppBar( centerTitle: true,title: Text(getTranslate(context, "edit_product_page")),),
      backgroundColor: Colors.green,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(hint: getTranslate(context, "product_name"), OnClick: (value) {_name = value;},),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_full_price"),OnClick:(value){_Fprice=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_medium_price"),OnClick:(value){_Mprice=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_small_price"),OnClick:(value){_Sprice=value;} ,),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_description"), OnClick: (value) {_description = value;},),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context,"product_category"), OnClick: (value) {_category = value;},),
                SizedBox(height: 10,),
                CustomTextField(hint: getTranslate(context, "product_location"), OnClick: (value) {_imageLocation = value;},),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text(getTranslate(context, "edit")),
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      _store.editProduct(({
                        KProductName: _name,
                        KProductFPrice: _Fprice,
                        KProductMPrice: _Mprice,
                        KProductSPrice: _Sprice,
                        KProductDescription: _description,
                        KProductCategory: _category,
                        KProductLocation: _imageLocation,
                      }
                      ), product.pId);
                    }
                    Navigator.pushNamed(context, ManageProduct.id);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
