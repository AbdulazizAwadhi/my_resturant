import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/screen/admin/admin_home.dart';
import 'package:resturantapp_abdu/screen/admin/edit_product.dart';
import 'package:resturantapp_abdu/services/store.dart';
class ManageProduct extends StatefulWidget {
  static String id = "ManageProduct";

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(getTranslate(context, "manage_product_page")),
        backgroundColor: Colors.blue,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,size: 30,),
        onPressed: (){
          Navigator.pushNamed(context, AdminHome.id);
        },),

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> product = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data();
              product.add(Product(
                pId: doc.documentID,
                pName: data[KProductName],
                pFPrice: data[KProductFPrice],
                pMPrice: data[KProductMPrice],
                pSPrice: data[KProductSPrice],
                pDescription: data[KProductDescription],
                pCategory: data[KProductCategory],
                pLocation: data[KProductLocation],
              ));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
              ,childAspectRatio: .9),

              itemBuilder:
                  (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details)
                      async {
                        double dx= details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.width - dy;
                        await showMenu(context: context, position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              MyPopupMenuItem(
                                child: Text(getTranslate(context, "edit")),
                                onClick: ()
                                {
                                  Navigator.pushNamed(context, EditProduct.id,arguments: product[index]);
                                },

                              ),
                              MyPopupMenuItem(
                                child: Text(getTranslate(context, "delete")),
                                onClick: ()
                                {
                                  _store.deleteProduct(product[index].pId);
                                  Navigator.pop(context);
                                },
                              )
                            ]);
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image(
                             fit: BoxFit.fill,
                             image: AssetImage(product[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                color: Colors.white,
                                height: 75,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(product[index].pName,style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("SR ${product[index].pFPrice}",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("Cal ${product[index].pDescription}",style: TextStyle(fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              itemCount: product.length,
            );
          } else {
            return Center(child: Text("Loading..."));
          }
        },
      ),
    );
  }

}


class MyPopupMenuItem<T> extends PopupMenuItem<T>
{
  final Widget child ;
  final Function onClick;
  MyPopupMenuItem({@required this.onClick, @required this.child}) : super(child: child);
  PopupMenuItemState<T,PopupMenuItem<T>> createState()
  {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T,PopMenuItem> extends PopupMenuItemState<T,MyPopupMenuItem<T>>
{


  @override
  void handleTap() {
    widget.onClick();
  }
}