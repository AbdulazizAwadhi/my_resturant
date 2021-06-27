import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/provider/modal_hud.dart';
import 'package:resturantapp_abdu/screen/login_screen.dart';
import 'package:resturantapp_abdu/widgets/custom_text_field.dart';
import 'package:resturantapp_abdu/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  static String id="SignupScreen";
  final _auth = Auth();
  String _email , _password ,_name , _number;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xffFEA209),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black, size: 30,)
        ),
      ), // top of page that has arrow back
      backgroundColor: Color(0xffFEA209),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(height: 50,),
              Column(
                children: [
                  CustomTextField(OnClick: (value){_name=value;},hint: getTranslate(context, "enter_your_name"), icon: Icons.person,),
                  SizedBox(height: height * .02,),
                  CustomTextField(OnClick: (value){_number=value;},hint: getTranslate(context,"enter_your_phone_number"), icon: Icons.smartphone,),
                  SizedBox(height: height * .02,),
                  CustomTextField(OnClick: (value){_email=value;},hint: getTranslate(context, "enter_your_email"), icon: Icons.email,),
                  SizedBox(height: height * .02,),
                  CustomTextField(OnClick: (value){_password=value;},hint: getTranslate(context, "enter_your_password"), icon: Icons.vpn_key,),
                  SizedBox(height: height * .05,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 130),
                    child: Builder(
                      builder:(context) => FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        onPressed: () async
                        {
                          final modalhud = Provider.of<ModalHud>(context,listen: false);
                          modalhud.changeisLoading(true); //this step to appear blue circle for user until finish all logic steps than  value will change to hide this blue circle
                          if(_globalKey.currentState.validate())
                            {
                              _globalKey.currentState.save();
                              try {
                                final usercredential = await _auth.signUp(
                                    _email.trim(), _password.trim());
                                modalhud.changeisLoading(false);
                                Navigator.pushNamed(context, LoginScreen.id);
                              }
                              //here i used catch error to show user type of error if he insert incorrect inputs
                              catch(e)
                              {
                                modalhud.changeisLoading(false); // here i changed value of method that defined previously to hide blue circle
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      e.message
                                  ),
                                ),

                                );
                                modalhud.changeisLoading(false);
                              }

                            }

                        },

                        color: Colors.black,
                        child: Text(
                          getTranslate(context, "sign_up"), style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ), //sign up button and logic validate for sign up with handle exception
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
