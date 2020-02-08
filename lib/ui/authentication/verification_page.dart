import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/repository/authentication_repository.dart';
import 'package:tutorial/shared/styles/app_fonts.dart';
import 'package:tutorial/shared/styles/app_string.dart';
import 'package:tutorial/shared/utils/utils_dialog.dart';
import 'package:tutorial/shared/utils/utils_prefrence.dart';
import 'package:tutorial/ui/course/course_list.dart';
import 'package:tutorial/ui/course/course_list_page.dart';

import 'complete_profile.dart';

class VerificationPage extends StatefulWidget {
  static String tag = 'verification-page';

  String email;
  int id;

  VerificationPage({this.email, this.id});

  @override
  State<StatefulWidget> createState() {
    return new _VerificationPageState();
  }
}

class _VerificationPageState extends State<VerificationPage> {
  // AuthenticationRepository authRepository = new AuthenticationRepository();
  final user = GetIt.instance<User>();
  String code;
  ProgressDialog pr;

  @override
  void initState() {
    pr = new ProgressDialog(context);
    super.initState();
  }

  Text bodyText = Text(
    AppStrings.verificationCheckYourEmail,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: AppFonts.verificationCodeText(),
  );

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
        // Container(
        //   child: Observer(
        //     builder: (_) {
        //       if (user.state == LoadingState.loading) Future(() => pr.show());
        //       if (user.state == LoadingState.error) {
        //         Future(() {
        //           pr.dismiss();
        //         });
        //         Future(() => UtilsDialog.showErrorDialog(context, "Invaid code", "Please enter code again"));
        //       }

        //       return Container();
        //     },
        //   ),
        // ),
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
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: _sendToServer,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
            child: Text(AppStrings.verificationBtnVerify, style: AppFonts.loginBtn()),
          ),
        ),
      ],
    );
  }

  _sendToServer() {
    if (code != null) {
      pr.show();
      user.verifyUser(code).then((it) {
       
        UtilsPrefrence.storeUserToken(it.data.token).then((val) {
           pr.dismiss();
          if (it.data.user.languageId == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompleteProfilePage(it.data.language, widget.id),
                ));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseListPage(),
                ));
          }
        });
      }).catchError((onError) {
        pr.dismiss();
        UtilsDialog.showErrorDialog(context, "Invaid code", "Please enter code again");
      });
      // VerfyResponse loginResponse = await authRepository.verifyUser(widget.email, code, widget.id.toString());

      // if (loginResponse.meta.status == 'Success') {
      //     print(loginResponse.data.language[0].toString());
      //   if(loginResponse.data.user.languageId==0)
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => CompleteProfilePage(

      //            loginResponse.data.language,
      //         ),
      //       ));

      //   // Navigator.pushNamed(context, CompleteProfilePage.tag);
      // }

    }
  }

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context).settings.arguments;

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
