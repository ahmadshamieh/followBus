import 'package:flutter/material.dart';
import 'package:followbus/adminPage/adminScreen.dart';
import 'package:followbus/animation/FadeAnimation.dart';
import 'package:followbus/homeScreenDriver.dart';
import 'package:followbus/model/modelLogin.dart';
import 'package:followbus/mservice/ApiaddStudents.dart';
import 'package:followbus/mservice/Apilogin.dart';
import 'package:followbus/startScreens/forgetPassword.dart';
import 'package:followbus/startScreens/introScreen.dart';
import 'package:followbus/startScreens/signup.dart';

class addStudantAdmain extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<addStudantAdmain> {
  var name;
  var latitude;
  var longitude;
  var location;
  var classR;
  var phone;
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
        context, MaterialPageRoute(builder: (context) => adminScreen()));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert Dialog"),
            content: Text(msg),
          );
        });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => adminScreen()));
  }

  void _trysubmit() async {
    BuildContext context;
    bool isvalid;
    isvalid = _formkey.currentState.validate();

    if (isvalid) {
      _formkey.currentState.save();
      // setState(() {
      //   msgV = 'Loading...';
      // });
      try {
        createStudents(
          name.trim(),
          latitude.trim(),
          longitude.trim(),
          location.trim(),
          classR.trim(),
          phone.trim(),
        ).then((value) => (value.error.toString() == "false")
            ? trueReguser(value.message)
            : NavigatorMethodStateserorr(value.message));
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
        child: ListView(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "student Info",
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
                            "Add student information",
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
                                      labelText: "Name"),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a valid Name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    name = value;
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
                                      labelText: "latitude"),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a valid latitude';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    latitude = value;
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
                                      labelText: "longitude"),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a valid longitude';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    longitude = value;
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
                                      labelText: "location"),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a valid location';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    location = value;
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
                                      labelText: "class"),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a valid class';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    classR = value;
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
                                      labelText: "phone"),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a valid phone';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    phone = value;
                                  },
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
                              "Add",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )),
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
