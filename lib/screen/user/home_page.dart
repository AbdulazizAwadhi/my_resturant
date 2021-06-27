import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/screen/first_page.dart';
import 'package:resturantapp_abdu/screen/user/cart_screen.dart';
import 'package:resturantapp_abdu/screen/user/product_info.dart';
import 'package:resturantapp_abdu/services/auth.dart';
import 'package:resturantapp_abdu/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../functions.dart';

class HomePage extends StatefulWidget {
  static String id="HomePage";


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = Store();
  final _auth = Auth();
  UserCredential _loggedUser;
  int _tabBarindex = 0;
  int _bottumBarindex = 0;
  List<Product> _product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 8,
          child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color(0xff864128),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: KUnActiveColor,
              currentIndex: _bottumBarindex,
              fixedColor: Colors.black,
              onTap: (value)  async {

                if(value == 1)
                  {
                    SharedPreferences prefe = await SharedPreferences.getInstance();
                    prefe.clear();
                    
                     await _auth.signOut();
                     Navigator.pushNamed(context , FirstPage.id);
                  }
                setState(() {
                  _bottumBarindex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    title: Text(getTranslate(context, "click_here_to_show_menu")),
                    icon: Icon(Icons.restaurant_menu)
                ),
                BottomNavigationBarItem(
                    title: Text(getTranslate(context, "sign_out")), icon: Icon(Icons.clear)
                ),
              ],
            ),

            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: KMainColor,
              bottom: TabBar(
                indicatorColor: KMainColor,
                isScrollable: true,
                onTap: (value) {
                  setState(() {
                    _tabBarindex = value;
                  });
                },
                tabs: [
                  Text(getTranslate(context, "chicken"), style: TextStyle(
                      color: _tabBarindex == 0 ? Colors.black : KUnActiveColor,
                      fontSize: 16),),
                  Text(getTranslate(context, "meat"), style: TextStyle(
                      color: _tabBarindex == 1 ? Colors.black : KUnActiveColor,
                      fontSize: 16),),
                  Text(getTranslate(context, "grill"), style: TextStyle(
                      color: _tabBarindex == 2 ? Colors.black : KUnActiveColor,
                      fontSize: 16),),
                  Text(getTranslate(context, "appetizer"), style: TextStyle(
                      color: _tabBarindex == 3 ? Colors.black : KUnActiveColor,
                      fontSize: 16),),
                  Text(getTranslate(context, "idamat"), style: TextStyle(
                      color: _tabBarindex == 4 ? Colors.black : KUnActiveColor,
                      fontSize: 16),),
                  Text(getTranslate(context,"drink"), style: TextStyle(
                      color: _tabBarindex == 5 ? Colors.black : KUnActiveColor,
                      fontSize: 16),),
                  Text(getTranslate(context, "dessert"), style: TextStyle(
                      color: _tabBarindex == 6 ? Colors.black : KUnActiveColor,
                      fontSize: 16),),
                  Text(getTranslate(context, "lamb"), style: TextStyle(
                      color: _tabBarindex == 7 ? Colors.black : KUnActiveColor,
                      fontSize: 16),),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ChickenView(),
                MeatView(KMeat, _product),
                GrillView(KGrill, _product),
                AppetizerView(KAppetizer, _product),
                idamatView(KIdamat, _product),
                DrinkView(KDrink , _product),
                DessertView(KDessert , _product),
                LambView(KLamb , _product)

              ],
            ),
          ),
        ),
        Material(
          color: KMainColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslate(context, "menu"), style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  GestureDetector(
                    child: Icon(Icons.shopping_cart, size: 30,), onTap: () {
                    Navigator.pushNamed(context, CartScreen.id );
                  },),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    getCurrentUser();
  }

  getCurrentUser() async
  {
    _loggedUser = await _auth.getUser();
  }


  Widget ChickenView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data();
            products.add(Product(
              pId: doc.documentID,
              pName: data[KProductName],
              pFPrice: data[KProductFPrice],
              pMPrice: data[KProductMPrice],
              pSPrice: data[KProductSPrice],
              pDescription: data[KProductDescription],
              pDetails: data[KProductDetails],
              pCategory: data[KProductCategory],
              pLocation: data[KProductLocation],
            ));
          }
          _product = [...products];
          products.clear();
          products = getProductByCategory(KChicken, _product);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1
                , childAspectRatio: 1.5),

            itemBuilder:
                (context, index) =>
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ProductInfo.id, arguments: products[index]);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          child: Card(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                  child: Image(image: AssetImage(
                                      products[index].pLocation),
                                    width: 200,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                ListTile(title: Text(
                                  products[index].pName, style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                                ),
                                  subtitle: Text(
                                    "SR ${products[index].pFPrice}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text("Cal ${products[index].pDescription}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            itemCount: products.length,
          );
        } else {
          return Center(child: Text("Loading..."));
        }
      },
    );
  }
  Widget MeatView(String pCategory, List<Product> allproducts) {
    List<Product> products;
    products = getProductByCategory(pCategory, allproducts);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1
          , childAspectRatio: 1.5),

      itemBuilder:
          (context, index) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, ProductInfo.id, arguments: products[index]);
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Card(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                            child: Image(
                              image: AssetImage(products[index].pLocation),
                              width: 200,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                          ListTile(title: Text(
                            products[index].pName, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ),
                            subtitle: Text("SR ${products[index].pFPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("Cal ${products[index].pDescription}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      itemCount: products.length,
    );
  }
  Widget GrillView(String pCategory, List<Product> allproducts) {
    List<Product> products;
    products = getProductByCategory(pCategory, allproducts);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1
          , childAspectRatio: 1.5),

      itemBuilder:
          (context, index) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, ProductInfo.id, arguments: products[index]);
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                            child: Image(
                              image: AssetImage(products[index].pLocation),
                              width: 200,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                          ListTile(title: Text(
                            products[index].pName, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ),
                            subtitle: Text("SR ${products[index].pFPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("Cal ${products[index].pDescription}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      itemCount: products.length,
    );
  }
  Widget AppetizerView(String pCategory, List<Product> allproducts) {
    List<Product> products;
    products = getProductByCategory(pCategory, allproducts);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1
          , childAspectRatio: 1.5),

      itemBuilder:
          (context, index) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, ProductInfo.id, arguments: products[index]);
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                            child: Image(
                              image: AssetImage(products[index].pLocation),
                              width: 200,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          ListTile(title: Text(
                            products[index].pName, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ),
                            subtitle: Text("SR ${products[index].pFPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("Cal ${products[index].pDescription}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      itemCount: products.length,
    );
  }
  Widget idamatView(String pCategory, List<Product> allproducts) {
    List<Product> products;
    products = getProductByCategory(pCategory, allproducts);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1
          , childAspectRatio: 1.5),

      itemBuilder:
          (context, index) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, ProductInfo.id, arguments: products[index]);
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                            child: Image(
                              image: AssetImage(products[index].pLocation),
                              width: 200,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          ListTile(title: Text(
                            products[index].pName, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ),
                            subtitle: Text("SR ${products[index].pFPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("Cal ${products[index].pDescription}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      itemCount: products.length,
    );
  }
  Widget DrinkView(String pCategory, List<Product> allproducts) {
    List<Product> products;
    products = getProductByCategory(pCategory, allproducts);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1
          , childAspectRatio: 1.5),

      itemBuilder:
          (context, index) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, ProductInfo.id, arguments: products[index]);
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Card(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                            child: Image(
                              image: AssetImage(products[index].pLocation),
                              width: 200,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                          ListTile(title: Text(
                            products[index].pName, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ),
                            subtitle: Text("SR ${products[index].pFPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("Cal ${products[index].pDescription}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      itemCount: products.length,
    );
  }
  Widget DessertView(String pCategory, List<Product> allproducts) {
    List<Product> products;
    products = getProductByCategory(pCategory, allproducts);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1
          , childAspectRatio: 1.5),

      itemBuilder:
          (context, index) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, ProductInfo.id, arguments: products[index]);
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Card(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                            child: Image(
                              image: AssetImage(products[index].pLocation),
                              width: 200,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                          ListTile(title: Text(
                            products[index].pName, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ),
                            subtitle: Text("SR ${products[index].pFPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("Cal ${products[index].pDescription}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      itemCount: products.length,
    );
  }
  Widget LambView(String pCategory, List<Product> allproducts) {
    List<Product> products;
    products = getProductByCategory(pCategory, allproducts);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1
          , childAspectRatio: 1.5),

      itemBuilder:
          (context, index) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, ProductInfo.id, arguments: products[index]);
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Card(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                            child: Image(
                              image: AssetImage(products[index].pLocation),
                              width: 200,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          ListTile(title: Text(
                            products[index].pName, style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ),
                            subtitle: Text("SR ${products[index].pFPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("Cal ${products[index].pDescription}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      itemCount: products.length,
    );
  }

  }


