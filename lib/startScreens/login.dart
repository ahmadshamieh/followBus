import 'package:flutter/material.dart';
import 'package:followbus/adminPage/adminScreen.dart';
import 'package:followbus/animation/FadeAnimation.dart';
import 'package:followbus/homeScreenDriver.dart';
import 'package:followbus/model/modelLogin.dart';
import 'package:followbus/mservice/ApiDriverList.dart';
import 'package:followbus/mservice/ApiStudentsList.dart';
import 'package:followbus/mservice/Apilogin.dart';
import 'package:followbus/startScreens/forgetPassword.dart';
import 'package:followbus/startScreens/introScreen.dart';
import 'package:followbus/startScreens/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  var email;
  var username;
  var password;
  Future<loginData> _futureloginData;
  bool _isloading = true;
  String msgV = "";
  NavigatorMethodStateserorr(String msg) {
    print(msg);
    setState(() {
      msgV = msg;
    });
  }

  final _formkey = GlobalKey<FormState>();
  trueRegadmin(msg) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => adminScreen()));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert Dialog"),
            content: Text(msg),
          );
        });
  }

  trueReguser(msg) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePageDriver()));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert Dialog"),
            content: Text(msg),
          );
        });
    createStudentListData();
    createDriverListData();
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => adminScreen()));
  }

  void _trysubmit() async {
    BuildContext context;
    bool isvalid;
    isvalid = _formkey.currentState.validate();

    if (isvalid) {
      _formkey.currentState.save();

      try {
        _futureloginData = createAlbum(
          email.trim(),
          password.trim(),
        ).then((value) => (value.error.toString() == "false")
            ? value.data.isAdmin == "1"
                ? trueRegadmin(value.message)
                : trueReguser(value.message)
            : NavigatorMethodStateserorr(value.message));
        //  trueReg("The driver has been registered successfully");
      } catch (err) {
        String message = '';
        if (err.message != null) {
          message = err.message;
          trueReguser(message);
        }
        print(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backGroundLogIn.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: screenheight * .04,
                  left: screenwidth * .04,
                  right: screenwidth * .04),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: screenwidth * .14,
                                fontWeight: FontWeight.bold),
                          )),

                      SizedBox(
                        height: 10,
                      ),

                      FadeAnimation(
                          1.2,
                          Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),

                      SizedBox(
                        height: 10,
                      ),

                      // FadeAnimation(1.2, Container(
                      //   height: MediaQuery.of(context).size.height / 5,
                      //   decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //           image: AssetImage('assets/image.png'),
                      //           fit: BoxFit.cover
                      //       )
                      //   ),
                      // )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(15.0),
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid)),
                                      border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      labelText: "Email"),
                                  validator: (value) {
                                    //|| !value.contains('@')
                                    if (value.isEmpty) {
                                      return 'Enter a valid email';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    email = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(15.0),
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid)),
                                      border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      labelText: "Password"),
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 5) {
                                      return 'Enter a valid Password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    password = value;
                                  },
                                  obscureText: true,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: FutureBuilder<loginData>(
                      future: _futureloginData,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          _isloading = false;
                          return Column(
                            children: [
                              // test(snapshot.data.status.toString()),
                              // Text(msgV),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Text(
                            'Loading...',
                            style: TextStyle(color: Colors.black),
                          ));
                        }
                        return Container(
                          child: Text(msgV),
                        );
                      },
                    ),
                  ),
                  FadeAnimation(
                      1.4,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              color: Colors.orange[800],
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            onPressed: _trysubmit,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                  // FadeAnimation(
                  //     1.5,
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         Text(
                  //           "Don't have an account ? ",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600, fontSize: 18),
                  //         ),
                  //         new GestureDetector(
                  //           onTap: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => SignupPage()));
                  //           },
                  //           child: new Text(
                  //             "Sign up",
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //                 fontSize: 20,
                  //                 color: Colors.red),
                  //           ),
                  //         )
                  //       ],
                  //     )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                    },
                    child: new Text(
                      "forgot Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
                borderSide: BorderSide(
                  color: Colors.grey[400],
                )),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(20.0),
                ),
                borderSide: BorderSide(color: Colors.grey[400])),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
