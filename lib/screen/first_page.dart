import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/localization/set_localization.dart';
import 'package:resturantapp_abdu/main.dart';
import 'package:resturantapp_abdu/model/language.dart';
import 'package:resturantapp_abdu/screen/maps.dart';
import 'package:resturantapp_abdu/screen/menu.dart';
import '../constant.dart';
import 'login_screen.dart';

class FirstPage extends StatefulWidget {
  static String id = "FirstPage";

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff864128),
        title: Text(getTranslate(context, "welcome")
          ,style: TextStyle(color: Colors.grey),),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: DropdownButton(
              underline: SizedBox(),
              hint: Text(getTranslate(context, "language"),style: TextStyle(color: Colors.grey,fontSize: 16),),
              icon: Icon(Icons.language , color: Color(0xffFEA209), size: 40,),
              items:
                Language.LanguageList().map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                  value: lang,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(lang.flag,style: TextStyle(fontSize: 30),),
                      Text(lang.name,style: TextStyle(fontSize: 20),)
                    ],
                  ),
                )
                ).toList(),
              onChanged: (Language lang){
                _changeLanguage(lang);
              },
            ),
          ),
        ],
      ),// Language icon
      backgroundColor: Color(0xff864128),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xff864128),
                radius: 200,
                backgroundImage: AssetImage("images/res_logo.jpg"),
              ), // Logo of res
              Divider(
                color: Color(0xffFEA209),
                indent: 50,
                endIndent: 50,
                thickness: 3,
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFEA209),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    width: 400,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.restore, size: 40,),
                        SizedBox(width: 80,),
                        Text(getTranslate(context, "order_receive"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ), // first button (order receive)
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFEA209),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    width: 400,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.drive_eta, size: 40,),
                        SizedBox(width: 110,),
                        Text(getTranslate(context, "delivery"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ), // second button (delivery)
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Menu.id);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFEA209),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    width: 200,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.restaurant_menu, size: 40,),
                        SizedBox(width: 35,),
                        Text(getTranslate(context, "menu"),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),// third button (menu)
            ],
          ),
        ],
      ),
    );
  }
  void _changeLanguage(Language lang) {
    Locale _temp;

    switch(lang.languageCode){
      case "en" :
        _temp = Locale(lang.languageCode, "US");
        break;
      case "ar" :
        _temp = Locale(lang.languageCode, "SA");
        break;
      default:
        _temp = Locale("en", "US");
        break;

    }
    MyApp.setLocale(context, _temp);
  }
}
