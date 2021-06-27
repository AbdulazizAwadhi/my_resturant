import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/localization/set_localization.dart';
String getTranslate(BuildContext context , String key){
  return SetLocalization.of(context).getTranslateValue(key);
}