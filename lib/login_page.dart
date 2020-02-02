import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/repository/authentication_repository.dart';
import 'package:tutorial/shared/styles/app_fonts.dart';
import 'package:tutorial/shared/styles/app_string.dart';
import 'package:tutorial/shared/utils/form_validator.dart';
import 'package:tutorial/shared/utils/utils_dialog.dart';
import 'package:tutorial/shared/utils/utils_prefrence.dart';
import 'package:tutorial/verification_page.dart';

import 'model/response/login_response.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final user = GetIt.instance<User>();
  // AuthenticationRepository authRepository = new AuthenticationRepository();
  Text helloText = Text(
    AppStrings.loginHello,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: AppFonts.loginHello(),
  );

  Image _headerImage = new Image.asset(
    'assets/pictures/login.png',
    height: 100,
    width: 100,
  );

  Text header = Text(
    AppStrings.loginTitle,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: AppFonts.titleBold(),
  );

  GlobalKey<FormState> _key = new GlobalKey();
 
  // bool _obscureText = true;
  // bool _validate = false;

  // Future<void> navigateSomewhere(BuildContext context) async {
  //   await Future<void>.microtask(() {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => VerificationPage(
  //             email: user.email,
  //             id: user.id,
  //           ),
  //         ));
  //   });
  // }

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        // Container(
        //   child: Observer(
        //     builder: (_) {
        //       // if (user.state == LoadingState.loading) Future(() => pr.show());
        //       if (user.state == LoadingState.error) {
        //         // Future(() { pr.dismiss();});
        //         Future(() => UtilsDialog.showErrorDialog(context, "Error", "An error ecoured"));
        //       } else if (user.state == LoadingState.loaded) {
        //         // Future(() {

        //           // return VerificationPage(
        //           //       email: user.email,
        //           //       id: user.id,
        //           //     );
        //            WidgetsBinding.instance.addPostFrameCallback((_){
        //   Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => VerificationPage(
        //                 email: user.email,
        //                 id: user.id,
        //               ),
        //             ));

        // });

        //       }

        //       return Container();
        //     },
        //   ),
        // ),
        header,
        new SizedBox(height: 40.0),
        _headerImage,
        new SizedBox(height: 40.0),
        Divider(),
        helloText,
        Divider(),
        new SizedBox(height: 40.0),
        new TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
            hintText: AppStrings.loginHintEmail,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateEmail,
          onSaved: (String value) {
            user.setEmail = value;
          },
        ),
        new SizedBox(height: 20.0),
        // new TextFormField(
        //     autofocus: false,
        //     obscureText: _obscureText,
        //     keyboardType: TextInputType.text,
        //     decoration: InputDecoration(
        //       hintText: 'Password',
        //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        //       suffixIcon: GestureDetector(
        //         onTap: () {
        //           setState(() {
        //             _obscureText = !_obscureText;
        //           });
        //         },
        //         child: Icon(
        //           _obscureText ? Icons.visibility : Icons.visibility_off,
        //           semanticLabel: _obscureText ? 'show password' : 'hide password',
        //         ),
        //       ),
        //     ),
        //     validator: FormValidator().validatePassword,
        //     onSaved: (String value) {
        //       _loginData.password = value;
        //     }),
        new SizedBox(height: 15.0),
        new SizedBox(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: _sendToServer,
            padding: EdgeInsets.all(12),
            color: Colors.lightBlueAccent,
            child: Text(AppStrings.loginBtnLogin, style: AppFonts.loginBtn()),
          ),
        ),
        // new FlatButton(
        //   child: Text(
        //     'Forgot password?',
        //     style: TextStyle(color: Colors.black54),
        //   ),
        //   onPressed: _showForgotPasswordDialog,
        // ),
        // new FlatButton(
        //   onPressed: _sendToRegisterPage,
        //   child: Text('Not a member? Sign up now', style: TextStyle(color: Colors.black54)),
        // ),
      ],
    );
  }

  _sendToRegisterPage() {
    // Navigator.pushNamed(context, Home.tag);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => RegisterPage()),
    // );
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      user.login(user.email).then((it) {
        user.id= it.user.id;
 
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationPage(
                email: user.email,
                id: it.user.id,
              ),
            ));
      }).catchError((onError) {
        UtilsDialog.showErrorDialog(context, "Error", "An error ecoured");
      });
      // LoginResponse loginResponse = await authRepository.loginUser(email);
      // if (loginResponse.meta.status == 'Success') {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => VerificationPage(
      //           email: email,
      //           id: loginResponse.user.id,
      //         ),
      //       ));

      // Navigator.pushNamed(
      //   context,
      //   VerificationPage.tag,
      //   arguments: {
      //      email,
      //     loginResponse.user.id,
      //   },
      // );
    }
    // print("Password ${_loginData.password}");
    // } else {
    // validation error
    // setState(() {
    //   _validate = true;
    // });
    // }
  }

//   Future<Null> _showForgotPasswordDialog() async {
//     await showDialog<String>(
//         context: context,
//         builder: (BuildContext context) {
//           return new AlertDialog(
//             title: const Text('Please enter your eEmail'),
//             contentPadding: EdgeInsets.all(5.0),
//             content: new TextField(
//               decoration: new InputDecoration(hintText: "Email"),
//               onChanged: (String value) {
//                 _loginData.email = value;
//               },
//             ),
//             actions: <Widget>[
//               new FlatButton(
//                 child: new Text("Ok"),
//                 onPressed: () async {
//                   _loginData.email = "";
//                   Navigator.pop(context);
//                 },
//               ),
//               new FlatButton(
//                 child: new Text("Cancel"),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ],
//           );
//         });
//   }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: Center(
              child: new Form(
                key: _key,
                autovalidate: false,
                child: _getFormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
