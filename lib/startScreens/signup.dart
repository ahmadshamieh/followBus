// import 'package:flutter/material.dart';
// import 'package:followbus/animation/FadeAnimation.dart';

// import 'logIn.dart';

// class SignupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var screenheight = MediaQuery.of(context).size.height;
//     var screenwidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/backGroundLogIn.jpg'),
//                 fit: BoxFit.cover),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 30),
//           height: MediaQuery.of(context).size.height,
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: screenheight * .03,
//                 ),
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(
//                         Icons.arrow_back_ios,
//                         size: 30,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: <Widget>[
//                   FadeAnimation(
//                       1,
//                       Text(
//                         "Sign up",
//                         style: TextStyle(
//                             fontSize: screenwidth * .14,
//                             fontWeight: FontWeight.bold),
//                       )),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   FadeAnimation(
//                       1.2,
//                       Text(
//                         "Create an account, It's free",
//                         style: TextStyle(fontSize: 15, color: Colors.grey[700]),
//                       )),
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   FadeAnimation(1.2, makeInput(label: "Email")),
//                   FadeAnimation(
//                       1.3, makeInput(label: "Password", obscureText: true)),
//                   FadeAnimation(1.4,
//                       makeInput(label: "Confirm Password", obscureText: true)),
//                 ],
//               ),
//               FadeAnimation(
//                   1.5,
//                   Container(
//                     padding: EdgeInsets.only(top: 3, left: 3),
//                     decoration: BoxDecoration(
//                         color: Colors.orange[800],
//                         borderRadius: BorderRadius.circular(50),
//                         border: Border(
//                           bottom: BorderSide(color: Colors.black),
//                           top: BorderSide(color: Colors.black),
//                           left: BorderSide(color: Colors.black),
//                           right: BorderSide(color: Colors.black),
//                         )),
//                     child: MaterialButton(
//                       minWidth: double.infinity,
//                       height: 50,
//                       onPressed: () {},
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50)),
//                       child: Text(
//                         "Sign up",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18,
//                             color: Colors.white),
//                       ),
//                     ),
//                   )),
//               FadeAnimation(
//                   1.6,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         "Already have an account ? ",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18,
//                             color: Colors.black),
//                       ),
//                       new GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginPage()));
//                         },
//                         child: new Text(
//                           "Sign In",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 20,
//                               color: Colors.red),
//                         ),
//                       )
//                     ],
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget makeInput({label, obscureText = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           label,
//           style: TextStyle(
//               fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         TextField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(
//                   const Radius.circular(15.0),
//                 ),
//                 borderSide: BorderSide(
//                     color: Colors.grey[400], style: BorderStyle.solid)),
//             border: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(
//                   const Radius.circular(20.0),
//                 ),
//                 borderSide: BorderSide(color: Colors.grey[400])),
//           ),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//       ],
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:followbus/animation/FadeAnimation.dart';

import 'logIn.dart';

class SignupPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignupPage> {
  var email;
  var username;
  var password;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  trueReg(msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert Dialog"),
            content: Text(msg),
          );
        });
  }

  void _trysubmit() async {
    BuildContext context;
    bool isvalid;
    isvalid = _formkey.currentState.validate();

    if (isvalid) {
      _formkey.currentState.save();

      try {
        final Authresult = await auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        trueReg("The driver has been registered successfully");
      } catch (err) {
        String message = '';
        if (err.message != null) {
          message = err.message;
          trueReg(message);
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/backGroundLogIn.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
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
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Registration",
                        style: TextStyle(
                            fontSize: screenwidth * .12,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.2,
                      Text(
                        "driver registration",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: screenheight * .05),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
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
                                  if (value.isEmpty || !value.contains('@')) {
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
                                    labelText: "User Name"),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 5) {
                                    return 'Enter a valid name';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  username = value;
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
                                  if (value.isEmpty || value.length < 7) {
                                    return 'add true';
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
                            Padding(
                              padding: EdgeInsets.only(top: screenheight * .08),
                              child: FadeAnimation(
                                  1.5,
                                  Container(
                                    padding: EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.orange[800],
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
                                          top: BorderSide(color: Colors.black),
                                          left: BorderSide(color: Colors.black),
                                          right:
                                              BorderSide(color: Colors.black),
                                        )),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 50,
                                      onPressed: _trysubmit,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                    color: Colors.grey[400], style: BorderStyle.solid)),
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
