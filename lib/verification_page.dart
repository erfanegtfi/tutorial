import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tutorial/complete_profile.dart';
import 'package:tutorial/repository/authentication_repository.dart';
import 'package:tutorial/shared/styles/app_fonts.dart';
import 'package:tutorial/shared/styles/app_string.dart';
import 'model/response/login_response.dart';
import 'model/response/verify_response.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({this.email, this.id});

  static String tag = 'verification-page';

  String email;
  int id;

  @override
  State<StatefulWidget> createState() {
    return new _VerificationPageState();
  }
}

class _VerificationPageState extends State<VerificationPage> {
  AuthenticationRepository authRepository = new AuthenticationRepository();
  Text bodyText = Text(
    AppStrings.verificationCheckYourEmail,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: AppFonts.verificationCodeText(),
  );

  String code;
  ProgressDialog pr;
  Text titleText = Text(
    AppStrings.verificationEnterVerificationCode,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: AppFonts.verificationCodeTitle(),
  );


  Image _headerImage = new Image.asset(
    'assets/pictures/security.png',
    height: 100,
    width: 100,
  );

  Widget _getFormUI() {
    return Column(
      children: <Widget>[
        _headerImage,
        SizedBox(height: 50.0),
        Divider(),
        titleText,
        SizedBox(height: 10.0),
        bodyText,
        Divider(),
        SizedBox(height: 50.0),
        VerificationCodeInput(
          keyboardType: TextInputType.number,
          length: 6,
          autofocus: true,
          onCompleted: (String value) {
            code = value;
          },
        ),
        new SizedBox(height: 40.0),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onPressed: _sendToServer,
          color: Colors.lightBlueAccent,
          padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
          child: Text(AppStrings.verificationBtnVerify, style: AppFonts.loginBtn()),
        ),
      ],
    );
  }

  _sendToServer() async {
    if (code != null) {
      pr.show();
      VerfyResponse loginResponse = await authRepository.verifyUser(widget.email, code, widget.id.toString());
      pr.dismiss();
      if (loginResponse.meta.status == 'Success') {
          print(loginResponse.data.language[0].toString());
        if(loginResponse.data.user.languageId==0)
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompleteProfilePage(
               
                 loginResponse.data.language,
              ),
            ));

        // Navigator.pushNamed(context, CompleteProfilePage.tag);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    ModalRoute.of(context).settings.arguments;

    pr = new ProgressDialog(context);
    return new Scaffold(
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: Center(
              child: new Form(
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
