import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp_abdu/constant.dart';
import 'package:resturantapp_abdu/localization/localization_method.dart';
import 'package:resturantapp_abdu/provider/modal_hud.dart';
import 'package:resturantapp_abdu/provider/admin_mode.dart';
import 'package:resturantapp_abdu/screen/admin/admin_home.dart';
import 'package:resturantapp_abdu/screen/first_page.dart';
import 'package:resturantapp_abdu/screen/forget_pass.dart';
import 'package:resturantapp_abdu/screen/signup_screen.dart';
import 'package:resturantapp_abdu/screen/user/home_page.dart';
import 'package:resturantapp_abdu/widgets/custom_text_field.dart';
import 'package:resturantapp_abdu/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final _auth = Auth();
  final _adminPassword = "Admin12345";
  bool isAdmin = false;
  bool keepmeLoggedin = false;
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
              Navigator.pushNamed(context , FirstPage.id);
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
          key: widget._globalKey,
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
                            .height * 0.2,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: AssetImage("images/icon/icon.jpg"),
                        ),
                      ),
                    ],
                  ), //here Logo of apps and its features
                  SizedBox(height: height * .1,),
                  CustomTextField(OnClick: (value) {_email = value;}, hint: getTranslate(context, "enter_your_email"), icon: Icons.email,),

                  Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.white
                          ),
                          child: Checkbox(
                            checkColor: KSecondaryColor,
                            activeColor: KMainColor,
                            value: keepmeLoggedin,
                            onChanged: (value)
                            {
                              setState(() {
                                keepmeLoggedin = value;
                              });
                            },
                          ),
                        ),
                        Text(getTranslate(context, "remember_me"),style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                  CustomTextField(OnClick: (value) {_password = value;}, hint: getTranslate(context, "enter_your_password"), icon: Icons.vpn_key,),
                  Padding(
                    padding: const EdgeInsets.only(right: 200,top: 15),
                    child: GestureDetector(
                        child: Text(getTranslate(context, "forgot_password"),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15 ,color: KMainColor),),
                      onTap:()
                      {
                        Navigator.pushNamed(context,ForgetPassword.id);
                      }
                      ),

                  ), // (Forgot password button)
                  SizedBox(height: height * .05,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 130),
                    child: Builder(
                      builder: (context) =>
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            onPressed: ()
                            {
                              if(keepmeLoggedin == true)
                              {
                                keepUserLoggedin();
                              }
                              //here i used function to detected whether user is a user or an admin and check input of login then validate
                              _validate(context);

                            },
                            color: KMainColor,
                            child: Text(
                              getTranslate(context, "login"), style: TextStyle(color: Colors.white),
                            ),
                          ),
                    ), //login button
                  ), //login button and logic and validate with handle exception
                  SizedBox(height: height * .02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslate(context, "do_not_have_an_account?"), style: TextStyle(
                          color: Colors.white, fontSize: 16
                      ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignupScreen.id);
                          },
                          child: Text(getTranslate(context, "sign_up"), style: TextStyle(
                              fontSize: 20 , color: KMainColor ,fontWeight: FontWeight.bold
                          ),)) //sign up button
                    ],
                  ), //sign up button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(true);
                            },
                            child: Text(getTranslate(context, "i_am_an_admin"), style: TextStyle(
                                color: Provider
                                    .of<AdminMode>(context)
                                    .isAdmin ? Color(0xffFEA209) : Colors.white
                            ), textAlign: TextAlign.center,),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(false);
                            },
                            child: Text(getTranslate(context, "i_am_a_user"), style: TextStyle(
                                color: Provider
                                    .of<AdminMode>(context)
                                    .isAdmin ? Colors.white : Color(0xffFEA209)
                            ), textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),// here the place pf button when user want to login as admin or user
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async
  {

    final modalHud = Provider.of<ModalHud>(context,listen: false);
    modalHud.changeisLoading(true); //this step to appear blue circle for user until finish all logic steps than  value will change to hide this blue circle
    if(widget._globalKey.currentState.validate())
    {
      widget._globalKey.currentState.save();
      //here if the user click on admin button and i handle exception
      if (Provider.of<AdminMode>(context,listen: false).isAdmin)
      {
        if(_password == _adminPassword) // here i check if admin insert a true password to let him login
          {
          try{
            await _auth.signIn(_email.trim(), _password.trim());
            Navigator.pushNamed(context, AdminHome.id);
          }catch (e)
          {
            modalHud.changeisLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }

          }
        else
          {
            modalHud.changeisLoading(false);
           Scaffold.of(context).showSnackBar(SnackBar(
             content: Text(getTranslate(context, "password_of_admin_is_wrong")),
           ));
          }

      }
      //here if the user click on user button and i handle exception
      else
        {
          try{
         await _auth.signIn(_email.trim(), _password.trim());
          Navigator.pushNamed(context, HomePage.id);
        }catch (e)
          {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        }
    }
    modalHud.changeisLoading(false); // here i changed value of method that defined previously to hide blue circle

  }

  void keepUserLoggedin() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(KKeepMeLoggedIn, keepmeLoggedin);
  }
}


