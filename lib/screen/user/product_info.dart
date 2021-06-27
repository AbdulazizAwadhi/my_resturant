import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/functions.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/provider/cart_item.dart';
import 'package:resturantapp_abdu/screen/user/cart_screen.dart';
import 'package:resturantapp_abdu/services/store.dart';
class ProductInfo extends StatefulWidget {
  static String id = "ProductInfo" ;
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  double _radioValue = 0;
  int _radioValue2 = 0;
  int _radioValue3 = 0;
  String quantityofproduct = "" ;
  String radioItemtype = "pepsi";



  @override
  Widget build(BuildContext context) {

    Product product = ModalRoute
        .of(context)
        .settings
        .arguments;
    Widget typeOFrice() {
      if (product.pCategory == KChicken || product.pCategory == KGrill ||
          product.pCategory == KLamb) {
        if (product.pName == "mthaot chicken- ‏دجاج ‏مضغوط") {
          setState(() {
            product.pDetails = " ";
          });
          return Column(children: [SizedBox(height: 5,)],);
        }
        else if (product.pName == "shoaya chicken- ‏دجاج ‏شواية"){
          return Column(
            children: [
              Text(getTranslate(context, "type_of_rice"),
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KMainColor),),
              RadioListTile(
                value: 1,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KAppetizer) {
                      product.pDetails = "";
                    } else {
                      _radioValue2 = val;
                      product.pDetails = KRiceShabi;
                    }
                  });
                },
                title: Text(KRiceShabi),
                subtitle: Text("SR 0+"),
              ), //Shabi button
              RadioListTile(
                value: 2,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductFCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 40;
                      product.pDetails = KRiceBashawri;
                    }
                    else if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductMCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 20;
                      product.pDetails = KRiceBashawri;
                    }
                    else if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductSCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 10;
                      product.pDetails = KRiceBashawri;
                    }
                    else {
                      if (product.pCategory == KChicken ||
                          product.pCategory == KGrill &&
                              quantityofproduct == KQuantityofProductFCM ||
                          quantityofproduct == KQuantityofProductFG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 2;
                        product.pDetails = KRiceBashawri;
                      } else if (product.pCategory == KChicken || product
                          .pCategory == KGrill &&
                          quantityofproduct == KQuantityofProductMCM ||
                          quantityofproduct == KQuantityofProductSCM ||
                          quantityofproduct == KQuantityofProductMG ||
                          quantityofproduct == KQuantityofProductSG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 1;
                        product.pDetails = KRiceBashawri;
                      }
                    }
                  });
                },
                title: Text(KRiceBashawri),
                subtitle: Text("SR 2+"),
              ), //Bashawri button
              RadioListTile(
                value: 3,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KAppetizer) {
                      product.pDetails = "";
                    } else {
                      _radioValue2 = val;
                      product.pDetails = KRiceMndy;
                    }
                  });
                },
                title: Text(KRiceMndy),
                subtitle: Text("SR 0+"),
              ), //Mndy button
              RadioListTile(
                value: 4,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductFCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 40;
                      product.pDetails = KRiceMthlotha;
                    }
                    else if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductMCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 20;
                      product.pDetails = KRiceMthlotha;
                    }
                    else if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductSCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 10;
                      product.pDetails = KRiceMthlotha;
                    } else {
                      if (product.pCategory == KChicken ||
                          product.pCategory == KGrill &&
                              quantityofproduct == KQuantityofProductFCM ||
                          quantityofproduct == KQuantityofProductFG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 2;
                        product.pDetails = KRiceMthlotha;
                      } else if (product.pCategory == KChicken || product
                          .pCategory == KGrill &&
                          quantityofproduct == KQuantityofProductMCM ||
                          quantityofproduct == KQuantityofProductSCM ||
                          quantityofproduct == KQuantityofProductMG ||
                          quantityofproduct == KQuantityofProductSG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 1;
                        product.pDetails = KRiceMthlotha;
                      }
                    }
                  });
                },
                title: Text(KRiceMthlotha),
                subtitle: Text("SR 2+"),
              ), //Mthlotha button
              RadioListTile(
                value: 5,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KChicken &&
                        quantityofproduct == KQuantityofProductFCM ) {
                      _radioValue2 = val;
                      _radioValue = _radioValue - 12;
                      product.pDetails = KWithoutrice;
                    } else if (product.pCategory == KChicken &&
                        quantityofproduct == KQuantityofProductMCM ) {
                      _radioValue2 = val;
                      _radioValue = _radioValue -6 ;
                      product.pDetails = KWithoutrice;
                    }
                    else if ( product.pCategory == KGrill &&
                        quantityofproduct == KQuantityofProductFG ||
                        quantityofproduct == KQuantityofProductMG ||
                        quantityofproduct == KQuantityofProductSG) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 0;
                      product.pDetails = KWithoutrice;
                    }
                  });
                },
                title: Text(KWithoutrice),
                subtitle: Text(product.pCategory == KChicken ? "SR -12" : "SR 0"),
              ),
              Divider(color: Color(0xffFEA209), indent: 50, endIndent: 50, thickness: 3, height: 50,),
              Text(getTranslate(context, "type"),
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KMainColor),),
              RadioListTile(
                value: 1,
                groupValue: _radioValue3,
                activeColor: Colors.green,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KAppetizer) {
                      product.pDetails = "";
                    } else {
                      _radioValue3 = val;
                      product.pDetails += " حراق";
                    }
                  });
                },
                title: Text(getTranslate(context, "spicy")),
                subtitle: Text("SR 0+"),
              ),
              RadioListTile(
                value: 2,
                groupValue: _radioValue3,
                activeColor: Colors.green,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KAppetizer) {
                      product.pDetails = "";
                    } else {
                      _radioValue3 = val;
                      product.pDetails += " عادي";
                    }
                  });
                },
                title: Text(getTranslate(context, "normal")),
                subtitle: Text("SR 0+"),
              ),

            ],
          );
        }
        else {
          return Column(
            children: [
              Text(getTranslate(context, "type_of_rice"),
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KMainColor),),
              RadioListTile(
                value: 1,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KAppetizer) {
                      product.pDetails = "";
                    } else {
                      _radioValue2 = val;
                      product.pDetails = KRiceShabi;
                    }
                  });
                },
                title: Text(KRiceShabi),
                subtitle: Text("SR 0+"),
              ), //Shabi button
              RadioListTile(
                value: 2,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductFCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 40;
                      product.pDetails = KRiceBashawri;
                    }
                    else if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductMCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 20;
                      product.pDetails = KRiceBashawri;
                    }
                    else if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductSCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 10;
                      product.pDetails = KRiceBashawri;
                    }
                    else {
                      if (product.pCategory == KChicken ||
                          product.pCategory == KGrill &&
                              quantityofproduct == KQuantityofProductFCM ||
                          quantityofproduct == KQuantityofProductFG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 2;
                        product.pDetails = KRiceBashawri;
                      } else if (product.pCategory == KChicken || product
                          .pCategory == KGrill &&
                          quantityofproduct == KQuantityofProductMCM ||
                          quantityofproduct == KQuantityofProductSCM ||
                          quantityofproduct == KQuantityofProductMG ||
                          quantityofproduct == KQuantityofProductSG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 1;
                        product.pDetails = KRiceBashawri;
                      }
                    }
                  });
                },
                title: Text(KRiceBashawri),
                subtitle: Text("SR 2+"),
              ), //Bashawri button
              RadioListTile(
                value: 3,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KAppetizer) {
                      product.pDetails = "";
                    } else {
                      _radioValue2 = val;
                      product.pDetails = KRiceMndy;
                    }
                  });
                },
                title: Text(KRiceMndy),
                subtitle: Text("SR 0+"),
              ), //Mndy button
              RadioListTile(
                value: 4,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                    if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductFCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 40;
                      product.pDetails = KRiceMthlotha;
                    }
                    else if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductMCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 20;
                      product.pDetails = KRiceMthlotha;
                    }
                    else if (product.pCategory == KLamb &&
                        quantityofproduct == KQuantityofProductSCM) {
                      _radioValue2 = val;
                      _radioValue = _radioValue + 10;
                      product.pDetails = KRiceMthlotha;
                    } else {
                      if (product.pCategory == KChicken ||
                          product.pCategory == KGrill &&
                              quantityofproduct == KQuantityofProductFCM ||
                          quantityofproduct == KQuantityofProductFG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 2;
                        product.pDetails = KRiceMthlotha;
                      } else if (product.pCategory == KChicken || product
                          .pCategory == KGrill &&
                          quantityofproduct == KQuantityofProductMCM ||
                          quantityofproduct == KQuantityofProductSCM ||
                          quantityofproduct == KQuantityofProductMG ||
                          quantityofproduct == KQuantityofProductSG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 1;
                        product.pDetails = KRiceMthlotha;
                      }
                    }
                  });
                },
                title: Text(KRiceMthlotha),
                subtitle: Text("SR 2+"),
              ), //Mthlotha button
              RadioListTile(
                value: 5,
                groupValue: _radioValue2,
                activeColor: Colors.red,
                onChanged: (val) {
                  setState(() {
                      if (product.pCategory == KChicken &&
                          quantityofproduct == KQuantityofProductFCM ) {
                        _radioValue2 = val;
                        _radioValue = _radioValue - 12;
                        product.pDetails = KWithoutrice;
                      } else if (product.pCategory == KChicken &&
                          quantityofproduct == KQuantityofProductMCM ) {
                        _radioValue2 = val;
                        _radioValue = _radioValue -6 ;
                        product.pDetails = KWithoutrice;
                      }
                      else if ( product.pCategory == KGrill &&
                          quantityofproduct == KQuantityofProductFG ||
                          quantityofproduct == KQuantityofProductMG ||
                          quantityofproduct == KQuantityofProductSG) {
                        _radioValue2 = val;
                        _radioValue = _radioValue + 0;
                        product.pDetails = KWithoutrice;
                      }
                  });
                },
                title: Text(KWithoutrice),
                subtitle: Text(product.pCategory == KChicken ? "SR -12" : "SR 0"),
              ), //Mthlotha button

            ],
          );
        }
      }
      else if (product.pCategory == KMeat) {
        return Column(
          children: [
            Text(getTranslate(context, "type_of_rice"),
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KMainColor),),
            RadioListTile(
              value: 1,
              groupValue: _radioValue2,
              activeColor: Colors.red,
              onChanged: (val) {
                setState(() {
                  _radioValue2 = val;
                  product.pDetails = KRiceShabi;
                });
              },
              title: Text(KRiceShabi),
              subtitle: Text("SR 0+"),
            ), //Shabi button
            RadioListTile(
              value: 2,
              groupValue: _radioValue2,
              activeColor: Colors.red,
              onChanged: (val) {
                setState(() {
                  if (product.pCategory == KMeat &&
                      quantityofproduct == KQuantityofProductFCM) {
                    _radioValue2 = val;
                    _radioValue = _radioValue + 3;
                    product.pDetails = KRiceBashawri;
                  }
                });
              },
              title: Text(KRiceBashawri),
              subtitle: Text("SR 3+"),
            ), //Bashawri button
            RadioListTile(
              value: 3,
              groupValue: _radioValue2,
              activeColor: Colors.red,
              onChanged: (val) {
                setState(() {
                  _radioValue2 = val;
                  product.pDetails = KRiceMndy;
                });
              },
              title: Text(KRiceMndy),
              subtitle: Text("SR 0+"),
            ), //Mndy button
            RadioListTile(
              value: 4,
              groupValue: _radioValue2,
              activeColor: Colors.red,
              onChanged: (val) {
                setState(() {
                  if (product.pCategory == KMeat &&
                      quantityofproduct == KQuantityofProductFCM) {
                    _radioValue2 = val;
                    _radioValue = _radioValue + 3;
                    product.pDetails = KRiceMthlotha;
                  }
                });
              },
              title: Text(KRiceMthlotha),
              subtitle: Text("SR 3+"),
            ), //Mthlotha button
          ],
        );
      }
      else {
        return SizedBox(height: 1,);
      }
    }
    Widget typeOFpepsi(){
      return Column(
        children: [
          Text(getTranslate(context, "type"), style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
              color: KMainColor),),
          RadioListTile(
            groupValue: radioItemtype,
            activeColor: KMainColor,
            title: Text(getTranslate(context, "pepsi")),
            value: getTranslate(context, "pepsi"),
            onChanged: (val) {
              setState(() {
                radioItemtype = val;
                product.pDetails= val;
              });
            },
          ),RadioListTile(
            groupValue: radioItemtype,
            activeColor: KMainColor,
            title: Text(getTranslate(context, "seven_up")),
            value: getTranslate(context, "seven_up"),
            onChanged: (val) {
              setState(() {
                radioItemtype = val;
                product.pDetails= val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItemtype,
            activeColor: KMainColor,
            title: Text(getTranslate(context, "mirinda_citrus")),
            value: getTranslate(context, "mirinda_citrus"),
            onChanged: (val) {
              setState(() {
                radioItemtype = val;
                product.pDetails= val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItemtype,
            activeColor: KMainColor,
            title: Text(getTranslate(context, "mirinda_orange")),
            value: getTranslate(context, "mirinda_orange"),
            onChanged: (val) {
              setState(() {
                radioItemtype = val;
                product.pDetails= val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItemtype,
            activeColor: KMainColor,
            title: Text(getTranslate(context, "dew")),
            value: getTranslate(context, "dew"),
            onChanged: (val) {
              setState(() {
                radioItemtype = val;
                product.pDetails= val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItemtype,
            activeColor: KMainColor,
            title: Text(getTranslate(context, "shani")),
            value: getTranslate(context, "shani"),
            onChanged: (val) {
              setState(() {
                radioItemtype = val;
                product.pDetails= val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItemtype,
            activeColor: KMainColor,
            title: Text(getTranslate(context, "pepsi_diet")),
            value: getTranslate(context, "pepsi_diet"),
            onChanged: (val) {
              setState(() {
                radioItemtype = val;
                product.pDetails= val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItemtype,
            activeColor: KMainColor,
            title: Text(getTranslate(context, "seven_up_diet")),
            value: getTranslate(context, "seven_up_diet"),
            onChanged: (val) {
              setState(() {
                radioItemtype = val;
                product.pDetails= val;
              });
            },
          ),
        ],
      );
    }
    Widget quantOFproduct() {

      if (product.pCategory == KChicken ) {
        return Column(
            children: [
              Text(getTranslate(context, "quantity"), style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KMainColor),),
              RadioListTile(
                value: double.parse(product.pFPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductFCM;
                      if ( product.pDetails == KRiceMthlotha ||
                          product.pDetails == KRiceBashawri) {
                        _radioValue = _radioValue + 2;
                      }
                      else if (product.pDetails == KWithoutrice){
                        _radioValue = _radioValue - 12;
                      }

                  });
                },
                title: Text(KQuantityofProductFCM),
                subtitle: Text("SR ${product.pFPrice}"),
              ), //Whole button
              RadioListTile(
                value: double.parse(product.pMPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductMCM;
                    if ( product.pDetails == KRiceMthlotha ||
                          product.pDetails == KRiceBashawri) {
                        _radioValue = _radioValue + 1;
                      }
                    else if (product.pDetails == KWithoutrice){
                      _radioValue = _radioValue - 6;
                    }
                  });
                },
                title: Text(KQuantityofProductMCM),
                subtitle: Text("SR ${product.pMPrice}"),

              ), //half button
              RadioListTile(
                value: double.parse(product.pSPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductSCM;

                    if (product.pDetails == KRiceMthlotha ||
                        product.pDetails == KRiceBashawri) {
                      _radioValue = _radioValue + 1;
                  }
                    else if (product.pDetails == KWithoutrice){
                      _radioValue = _radioValue - 0 ;
                    }
                  });
                },
                title: Text(KQuantityofProductSCM),
                subtitle: Text("SR ${product.pSPrice}"),
              ), //Quarter button}
            ]
        );
      }
      else if (product.pCategory == KLamb ) {
        return Column(
            children: [
            Text(getTranslate(context, "quantity"), style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KMainColor),),
              RadioListTile(
                value: double.parse(product.pFPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductFCM;
                    if ( product.pDetails == KRiceMthlotha ||
                        product.pDetails == KRiceBashawri) {
                      _radioValue = _radioValue + 40;
                    }

                  });
                },
                title: Text(KQuantityofProductFCM),
                subtitle: Text("SR ${product.pFPrice}"),
              ), //Whole button
              RadioListTile(
                value: double.parse(product.pMPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductMCM;
                    if ( product.pDetails == KRiceMthlotha ||
                        product.pDetails == KRiceBashawri) {
                      _radioValue = _radioValue + 20;
                    }
                  });
                },
                title: Text(KQuantityofProductMCM),
                subtitle: Text("SR ${product.pMPrice}"),

              ), //half button
              RadioListTile(
                value: double.parse(product.pSPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductSCM;

                    if (product.pDetails == KRiceMthlotha ||
                        product.pDetails == KRiceBashawri) {
                      _radioValue = _radioValue + 10;
                    }});
                },
                title: Text(KQuantityofProductSCM),
                subtitle: Text("SR ${product.pSPrice}"),
              ), //Quarter button}
            ]
        );
      }
      else if (product.pCategory == KMeat ) {
        return Column(
            children: [
              Text(getTranslate(context, "quantity"), style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KMainColor),),
              RadioListTile(
                value: double.parse(product.pFPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductFCM;
                    if ( product.pDetails == KRiceMthlotha ||
                        product.pDetails == KRiceBashawri) {
                      _radioValue = _radioValue + 3;
                    }

                  });
                },
                title: Text(KQuantityofProductFCM),
                subtitle: Text("SR ${product.pFPrice}"),
              ), //Whole button
            ]
        );
      }
      else if(product.pCategory == KAppetizer || product.pCategory == KDrink || product.pCategory == KIdamat || product.pCategory == KDessert) {
        if(product.pName == " ‏appetizers- ‏مقبلات" || product.pName == "green ‎salad ‎- ‏سلطة ‏خضراء" || product.pName == "ftosh ‎- ‏فتوش"
        || product.pName == "labn ‎- لبن ‏المراعي" || product.pName == "water ‎- ماء"  ) {
          return Column(
              children: [
                Text(getTranslate(context, "quantity"), style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KMainColor),),
                RadioListTile(
                  value: double.parse(product.pFPrice),
                  groupValue: _radioValue,
                  onChanged: (val) {
                    setState(() {
                      _radioValue = val;
                      quantityofproduct = KQuantityofProductFAD;
                      product.pDetails = "";
                    });
                  },
                  title: Text(KQuantityofProductFAD),
                  subtitle: Text("SR ${product.pFPrice}"),
                ), //Large button
                RadioListTile(
                  value: double.parse(product.pMPrice),
                  groupValue: _radioValue,
                  onChanged: (val) {
                    setState(() {
                      _radioValue = val;
                      quantityofproduct = KQuantityofProductMAD;
                      product.pDetails = "";
                    });
                  },
                  title: Text(KQuantityofProductMAD),
                  subtitle: Text("SR ${product.pMPrice}"),

                ), //Medium button
                RadioListTile(
                  value: double.parse(product.pSPrice),
                  groupValue: _radioValue,
                  onChanged: (val) {
                    setState(() {
                      _radioValue = val;
                      quantityofproduct = KQuantityofProductSAD;
                      product.pDetails = "";
                    });
                  },
                  title: Text(KQuantityofProductSAD),
                  subtitle: Text("SR ${product.pSPrice}"),
                ), //Small button
              ]
          );
        }
        else if (product.pName == "pepsi ‎- مشروب ‏غازي") {
          return Column(
              children: [
                typeOFpepsi(),
                Divider(color: Color(0xffFEA209), indent: 50, endIndent: 50, thickness: 3, height: 50,),
                Text(getTranslate(context, "quantity"), style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KMainColor),),
                RadioListTile(
                  value: double.parse(product.pFPrice),
                  groupValue: _radioValue,
                  onChanged: (val) {
                    setState(() {
                      _radioValue = val;
                      quantityofproduct = KQuantityofProductFAD;
                    });
                  },
                  title: Text(KQuantityofProductFAD),
                  subtitle: Text("SR ${product.pFPrice}"),
                ), //Large button
                RadioListTile(
                  value: double.parse(product.pMPrice),
                  groupValue: _radioValue,
                  onChanged: (val) {
                    setState(() {
                      _radioValue = val;
                      quantityofproduct = KQuantityofProductMAD;
                    });
                  },
                  title: Text(KQuantityofProductMAD),
                  subtitle: Text("SR ${product.pMPrice}"),

                ), //Medium button
                RadioListTile(
                  value: double.parse(product.pSPrice),
                  groupValue: _radioValue,
                  onChanged: (val) {
                    setState(() {
                      _radioValue = val;
                      quantityofproduct = KQuantityofProductSAD;
                    });
                  },
                  title: Text(KQuantityofProductSAD),
                  subtitle: Text("SR ${product.pSPrice}"),
                ), //Small button
              ]
          );
        }
        else if (product.pName == "pepsi tall ‎- مشروب ‏غازي ‏طويل") {
          return Column(
              children: [
                typeOFpepsi(),
                Divider(color: Color(0xffFEA209), indent: 50, endIndent: 50, thickness: 3, height: 50,),
                Text(getTranslate(context, "quantity"), style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KMainColor),),
                RadioListTile(
                  value: double.parse(product.pSPrice),
                  groupValue: _radioValue,
                  onChanged: (val) {
                    setState(() {
                      _radioValue = val;
                      quantityofproduct = KQuantityofProductSAD;

                    });
                  },
                  title: Text(KQuantityofProductSAD),
                  subtitle: Text("SR ${product.pSPrice}"),
                ), //Small button
              ]
          );
        }
        else{
          return Column(
            children: [
              Text(getTranslate(context, "quantity"), style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KMainColor),),
              RadioListTile(
                value: double.parse(product.pSPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductSAD;
                    product.pDetails = "";
                  });
                },
                title: Text(KQuantityofProductSAD),
                subtitle: Text("SR ${product.pSPrice}"),
              ),
            ],
          );
        }
      }
      else if (product.pCategory == KGrill) {
        return Column(
            children: [
              Text(getTranslate(context, "quantity"), style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KMainColor),),
              RadioListTile(
                value: double.parse(product.pFPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductFG;
                    if ( product.pDetails == KRiceMthlotha ||
                        product.pDetails == KRiceBashawri) {
                      _radioValue = _radioValue + 2;
                    }
                  });
                },
                title: Text(KQuantityofProductFG),
                subtitle: Text("SR ${product.pFPrice}"),
              ), //1K button
              RadioListTile(
                value: double.parse(product.pMPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductMG;
                    if (product.pDetails == KRiceMthlotha ||
                        product.pDetails == KRiceBashawri) {
                      _radioValue = _radioValue + 1;
                    }
                  });
                },
                title: Text(KQuantityofProductMG),
                subtitle: Text("SR ${product.pMPrice}"),

              ), //1/2K button
              RadioListTile(
                value: double.parse(product.pSPrice),
                groupValue: _radioValue,
                onChanged: (val) {
                  setState(() {
                    _radioValue = val;
                    quantityofproduct = KQuantityofProductSG;
                    if (product.pDetails == KRiceMthlotha ||
                        product.pDetails == KRiceBashawri) {
                      _radioValue = _radioValue + 1;
                    }
                  });
                },
                title: Text(KQuantityofProductSG),
                subtitle: Text("SR ${product.pSPrice}"),
              ), //1/4K button
            ]
        );

      }
      else {
        return SizedBox(height: 5,);
      }
    }
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back, size: 30,), onTap: () {
                    Navigator.pop(context);
                  },),
                  GestureDetector(
                    child: Icon(Icons.shopping_cart, size: 30,), onTap: () {
                    Navigator.pushNamed(context, CartScreen.id , arguments: {
                      product.pFPrice= _radioValue.toString(), product.pDescription = quantityofproduct , product.pDetails});
                  },),
                ],
              ),
            ),
          ), //arrow back icon and shopping cart icon
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * .6,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Card(
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(product.pLocation),
              ),
            ),
          ), // here image of product
          Column(
            children: [
              Container(
                color: Colors.white,

                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child:Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${product.pName} ${product.pDetails}", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text("SR ${_radioValue}", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(quantityofproduct, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text("Cal ${product.pDescription}", style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),),
                      SizedBox(height: 10,),
                      quantOFproduct(),
                      Divider(color: Color(0xffFEA209), indent: 50, endIndent: 50, thickness: 3, height: 50,),
                      typeOFrice(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Material(
                              color: KMainColor,
                              child: GestureDetector(
                                  onTap: add,
                                  child: SizedBox(
                                    child: Icon(Icons.add),
                                    height: 28,
                                    width: 28,)),
                            ),
                          ), // add button
                          Text(_quantity.toString(), style: TextStyle(
                              fontSize: 60),),
                          ClipOval(
                            child: Material(
                              color: KMainColor,
                              child: GestureDetector(
                                  onTap: subtract,
                                  child: SizedBox(
                                    child: Icon(Icons.remove),
                                    height: 28,
                                    width: 28,)),
                            ),
                          ), // mines button
                        ],), //increment and decrement button
                    ],
                  ),
                ),
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                minWidth: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .09,
                child: Builder(
                  builder: (context) =>
                      RaisedButton(
                        color: KMainColor,
                        child: Text(getTranslate(context, "add_to_cart"), style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold
                        ),),
                        onPressed: ()  {
                          if(_radioValue == 0 || product.pDetails == null) {
                            Scaffold.of(context).showSnackBar(SnackBar
                              (content: Text(getTranslate(context, "please_select_quantity_or_type_of_rice")),));
                          }else{
                            addToCart(context, product);
                            Navigator.pushNamed(
                                context, CartScreen.id, arguments: {
                              product.pFPrice = _radioValue.toString(), product
                                  .pDescription = quantityofproduct});
                          }
                          },

                      ),
                ),
              ), // this ( Add to cart ) button
            ],
          ), // here details of product
        ],
      ),
    );



  }


  //this method to decrement quantity
  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity --;
      });
    }
  }

  //this method to increment quantity
  add() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(context, product)  {
    CartItem cartItem =  Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart == product) {
        exist = true;
      }
    }
    if (exist) {
      Scaffold.of(context).showSnackBar(SnackBar
        (content: Text("you have added this item before"),));
    } else {
      cartItem.addProduct(product);
      Scaffold.of(context).showSnackBar(SnackBar
        (content: Text("Added to Cart"),));
    }
  }


}
