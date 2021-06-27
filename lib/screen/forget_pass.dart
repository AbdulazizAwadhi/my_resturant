import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/provider/modal_hud.dart';
import 'package:resturantapp_abdu/provider/admin_mode.dart';
import 'package:resturantapp_abdu/screen/admin/admin_home.dart';
import 'package:resturantapp_abdu/screen/login_screen.dart';
import 'package:resturantapp_abdu/screen/signup_screen.dart';
import 'package:resturantapp_abdu/screen/user/home_page.dart';
import 'package:resturantapp_abdu/widgets/custom_text_field.dart';
import 'package:resturantapp_abdu/services/auth.dart';
class ForgetPassword extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = "ForgetPassword";
  String _email ;
  final _auth = Auth();


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
      ), //top of page that has arrow back
      backgroundColor: Color(0xffFEA209),
      body: ModalProgressHUD(
        inAsyncCall: Provider
            .of<ModalHud>(context)
            .isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.3,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text(getTranslate(context, "forgot_password") ,style: TextStyle(
                              fontSize: 30,fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 15,),
                           Container(
                              width: 200,
                              child: Text(getTranslate(context, "please_enter_your_email_to_receive_a_link_to_create_a_new_password_Note_some_time_you_will_receive_the_email_in_your_junk_email"),
                                style:TextStyle(fontSize: 16,fontWeight: FontWeight.w300) ,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ), //here Text of forget password
                  SizedBox(height: height * .01,),
                  CustomTextField(OnClick: (value) {_email = value;}, hint: getTranslate(context, "enter_your_email"), icon: Icons.email,),
                  SizedBox(height: height * .05,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 130),
                    child: Builder(
                      builder: (context) =>
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            onPressed: () async
                            {
                              final modalhud = Provider.of<ModalHud>(context,listen: false);
                              modalhud.changeisLoading(true); //this step to appear blue circle for user until finish all logic steps than  value will change to hide this blue circle
                              if(_globalKey.currentState.validate())
                                _globalKey.currentState.save();
                              {

                                try {
                                  final usercredential = await _auth.resetPassword(_email.trim());
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
                                  )
                                  );
                                }
                              }

                            },
                            color: Colors.black,
                            child: Text(
                              getTranslate(context, "send"), style: TextStyle(color: Colors.white),
                            ),
                          ),
                    ),
                  ), //Send button for receive link to user to get new password
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
