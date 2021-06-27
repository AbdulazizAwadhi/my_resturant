import 'package:flutter/material.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function OnClick;
  String _errorMessage (String str){
    switch(hint)
    {
      case "Enter your name" : return "Name is empty ! ";
      case "ادخل اسمك" : return "الاسم فارغ ! ";
      case "Enter your phone number" : return "Number is empty ! ";
      case "ادخل رقم جوالك" : return "رقم الجوال فارغ ! ";
      case "Enter your email" : return "Email is empty ! ";
      case "ادخل الايميل" : return "الايميل فارغ ! ";
      case "Enter your password" : return "Password is empty ! ";
      case "ادخل كلمة المرور" : return "كلمة المرور فارغة ! ";
      default: "error in switch";
    }
  }
  const CustomTextField({@required this.hint, @required this.icon , @required this.OnClick});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value)
        {
          if(value.isEmpty)
            {
              return _errorMessage(hint);
            }

        },
        onSaved: OnClick,

        // here i used this method to secure password when writing by user via hint condition
        obscureText: hint ==getTranslate(context, "enter_your_password")  ? true : false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Color(0xffFEA209),),
          filled: true,
          fillColor: Color(0xFFFFE6AC),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Colors.white
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Colors.white
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
