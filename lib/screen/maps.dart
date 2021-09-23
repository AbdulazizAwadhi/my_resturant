import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/model/product.dart';
import 'package:resturantapp_abdu/provider/cart_item.dart';
import 'package:resturantapp_abdu/screen/user/cart_screen.dart';
import 'package:resturantapp_abdu/services/store.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {

  static String id = "Maps";
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps>  {

  var mark = HashSet<Marker>(); //this is collection to add marker
  var currentLocation;
  bool mapToggle = false ;
  GoogleMapController mapController;
  Set latlong ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.getCurrentPosition().then((curloc) {
      setState(() {
        currentLocation = curloc;
        mapToggle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    return Scaffold(
      appBar: AppBar(
        backgroundColor : Color(0xff864128), title: Text(getTranslate(context, "location")),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 80 ,
            width: double.infinity,
            child: mapToggle ? 
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation.latitude, currentLocation.longitude),
                zoom: 16.0
              ),
              mapType: MapType.hybrid,
              onMapCreated: onMpCre,
              markers: mark,
              onTap: _handleTap,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            )
                :
            Center (child: Text(getTranslate(context, "loading..._please_wait"),style: TextStyle(fontSize: 20),),)
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ButtonTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: RaisedButton(
                color: KMainColor,
                onPressed: ()
                {

                  showCustomDialogaddress(context);

                },
                child: Text(getTranslate(context, "save"),style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(getTranslate(context, "to_change_location_move_red_mark"),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300),),
            ),
          )
        ],
      )
    );
  }

  void onMpCre(controller)
  {
      mapController = controller;
      setState(() {
        mapController = controller;
        mark.add(Marker(markerId: MarkerId("1"),
          draggable: true,
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          //Color of marker icon: BitmapDescriptor.defaultMarkerWithHue(150),
        ),);
        latlong = { currentLocation.latitude , currentLocation.longitude } ;
        print("Current Location $latlong");
      });


  }
  _handleTap(LatLng tappedPoint)
  {
    setState(() {
      mark = HashSet();
      mark.add(Marker(markerId: MarkerId(tappedPoint.toString()),
        draggable: true,
        position: tappedPoint,
        onDragEnd: (dragEndPosition)
        {
          setState(() {
            latlong = {dragEndPosition.latitude, dragEndPosition.longitude};
            //print(" NEW Drag TAP $latlong");
          });
        }

      ),);
      latlong = {tappedPoint.latitude , tappedPoint.longitude};
      //print(" NEW TAP $latlong");
    });


  }
  void showCustomDialogaddress(context) async
  {

   Set address = latlong;
   String temp;
    AlertDialog alertDialog = AlertDialog(
      actions: [
        MaterialButton(
          child: Text(getTranslate(context, "confirm")),
          onPressed: ()
          {
            setState(() {
              address.add(temp);
            });
            Navigator.of(context).push(MaterialPageRoute(
                    builder: (_){return CartScreen(addressDetails: address,);}),
                );
          },
        ),
      ],
      content: TextField(
        onChanged: (value)
        {
          temp = value;
        },

        decoration: InputDecoration(hintText: getTranslate(context, "enter_your_address")),
      ),
      title: Text(getTranslate(context, "address")),
    );
    await showDialog(context: context,builder:(context)
    {
      return alertDialog;

    });
  }
}
