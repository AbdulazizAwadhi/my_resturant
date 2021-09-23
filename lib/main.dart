import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/localization/set_localization.dart';
import 'package:resturantapp_abdu/provider/cart_item.dart';
import 'package:resturantapp_abdu/provider/modal_hud.dart';
import 'package:resturantapp_abdu/screen/admin/add_product.dart';
import 'package:resturantapp_abdu/screen/admin/admin_home.dart';
import 'package:resturantapp_abdu/provider/admin_mode.dart';
import 'package:resturantapp_abdu/screen/admin/edit_product.dart';
import 'package:resturantapp_abdu/screen/admin/manage_product.dart';
import 'package:resturantapp_abdu/screen/admin/order_details.dart';
import 'package:resturantapp_abdu/screen/admin/order_screen.dart';
import 'package:resturantapp_abdu/screen/first_page.dart';
import 'package:resturantapp_abdu/screen/forget_pass.dart';
import 'package:resturantapp_abdu/screen/login_screen.dart';
import 'package:resturantapp_abdu/screen/maps.dart';
import 'package:resturantapp_abdu/screen/menu.dart';
import 'package:resturantapp_abdu/screen/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resturantapp_abdu/screen/user/cart_screen.dart';
import 'package:resturantapp_abdu/screen/user/home_page.dart';
import 'package:resturantapp_abdu/screen/user/order_view.dart';
import 'package:resturantapp_abdu/screen/user/product_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isUserLoggedIn = false;
  Locale _local;
  void setLocale( Locale locale){
    setState(() {
      _local = locale;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklocationserviceindevice();

  }
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  //this method to check if location service is on
  Future<void> checklocationserviceindevice()async{
    Location location = new Location();
    _serviceEnabled = await location.serviceEnabled();
    if(_serviceEnabled){
      _permissionGranted = await location.hasPermission();
      if(_permissionGranted == PermissionStatus.granted)
        {
          print("GRANTED");
        }else{
        _permissionGranted = await location.requestPermission();
        if(_permissionGranted == PermissionStatus.granted)
        {

          print("GRANTED NEW");
        }else{
          SystemNavigator.pop();
        }
      }
    }else{
      _serviceEnabled = await location.requestService();
      if(_serviceEnabled){
        _permissionGranted = await location.hasPermission();
        if(_permissionGranted == PermissionStatus.granted)
        {
          print("GRANTED");
        }else{
          _permissionGranted = await location.requestPermission();
          if(_permissionGranted == PermissionStatus.granted)
          {
            print("GRANTED AFTER EDIT");
          }else{
            SystemNavigator.pop();
          }
        }
      }else{
        SystemNavigator.pop();
      }
    }
  }


  @override
  Widget build(BuildContext context) {


    return FutureBuilder<SharedPreferences>
      (
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot)
      {
        if(!snapshot.hasData)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
            body: Center( child: Text("Loading.....")
            ),
          ),
          );
        }else{
          isUserLoggedIn = snapshot.data.getBool(KKeepMeLoggedIn) ?? false ;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModalHud>(
                create: (context) => ModalHud(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
            ],
            child: MaterialApp(
              locale: _local,
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ar','SA')
              ],
              localizationsDelegates: [
                SetLocalization.localizationsDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              localeResolutionCallback: (deviceLocal , supportedLocales ){
                for(var local in supportedLocales){
                  if(local.languageCode == deviceLocal.languageCode && local.countryCode == deviceLocal.countryCode){
                    return deviceLocal;
                  }
                }
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? HomePage.id : FirstPage.id,
              routes: {
                FirstPage.id: (context) => FirstPage(),
                LoginScreen.id: (context) => LoginScreen(),
                SignupScreen.id: (context) => SignupScreen(),
                ForgetPassword.id: (context) => ForgetPassword(),
                HomePage.id: (context) => HomePage(),
                AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
                ManageProduct.id: (context) => ManageProduct(),
                EditProduct.id: (context) => EditProduct(),
                OrderScreen.id: (context) => OrderScreen(),
                OrderDetails.id: (context) => OrderDetails(),
                ProductInfo.id: (context) => ProductInfo(),
                CartScreen.id: (context) => CartScreen(),
                OrderView.id: (context) => OrderView(),
                Maps.id: (context) => Maps(),
                Menu.id: (context) => Menu(),
              },

            ),
          ) ;
        }
      },

    );

  }
}

