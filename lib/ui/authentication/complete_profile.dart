import 'package:easy_dialogs/single_choice_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial/model/language.dart';
import 'package:tutorial/model/user.dart';
import 'package:tutorial/repository/authentication_repository.dart';
import 'package:tutorial/shared/styles/app_fonts.dart';
import 'package:tutorial/shared/styles/app_string.dart';
import 'package:tutorial/shared/utils/form_validator.dart';
import 'package:tutorial/shared/utils/utils_dialog.dart';
import 'package:tutorial/ui/course/course_list_page.dart';

class CompleteProfilePage extends StatefulWidget {
  static String tag = 'CompleteProfilePage-page';
  List<Language> _labguages;
  int userID;
  CompleteProfilePage(this._labguages, this.userID);

  @override
  State<StatefulWidget> createState() {
    return new _CompleteProfilePageState();
  }
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  GlobalKey<FormState> _key = new GlobalKey();
  // bool _validate = false;
  final user = GetIt.instance<User>();
  // bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    // user.languageName = _selectedDialogLanguage.name;

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

  Text helloText = Text(
    AppStrings.profileCompleteTitle,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: AppFonts.loginHello(),
  );

  Text chooseLanguageText = Text(
    AppStrings.profileCompleteLanguage,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: AppFonts.loginHello(),
  );

  Text languageText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.loginHello(),
    );
  }

  Image _headerImage = new Image.asset(
    'assets/pictures/user.png',
    height: 100,
    width: 100,
  );

  // Widget _buildDialogItem(Language language) => Row(
  //       children: <Widget>[Text(language.name), SizedBox(width: 8.0), Flexible(child: Text("(${language.isoCode})"))],
  //     );

  // Language _selectedDialogLanguage = LanguagePickerUtils.getLanguageByIsoCode('en');

  // void _openLanguagePickerDialog() => showDialog(
  //       context: context,
  //       builder: (context) => Theme(
  //           data: Theme.of(context).copyWith(primaryColor: Colors.pink),
  //           child: LanguagePickerDialog(
  //               titlePadding: EdgeInsets.all(8.0),
  //               searchCursorColor: Colors.pinkAccent,
  //               searchInputDecoration: InputDecoration(hintText: 'Search...'),
  //               isSearchable: true,
  //               title: Text('Select your language'),
  //               onValuePicked: (Language language) {
  //                 _selectedDialogLanguage = language;
  //                 user.languageName = language.name;
  //               },
  //               itemBuilder: _buildDialogItem)),
  //     );

  _openLanguagePickerDialog() {
    showDialog(
        context: context,
        builder: (context) => SingleChoiceConfirmationDialog<Language>(
            title: Text('Select your language'),
            items: widget._labguages,
            onSelected: _onSelected,
            onSubmitted: _onSubmitted));
  }

  void _onSelected(Language value) {
    print('Selected $value');
    setState(() {
      user.language = value;
    });
  }

  // Language language;
  void _onSubmitted(Language value) {
    print('Submitted $value');
    setState(() {
      user.language = value;
    });
  }

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        _headerImage,
        new SizedBox(height: 30.0),
        Divider(),
        helloText,
        Divider(),
        new SizedBox(height: 30.0),
        new TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            hintText: AppStrings.profileName,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateFullName,
          onSaved: (String value) {
            user.setName = value;
          },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
          keyboardType: TextInputType.phone,
          autofocus: false,
          decoration: InputDecoration(
            hintText: AppStrings.profileMobile,
            contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: FormValidator().validateMobile,
          onSaved: (String value) {
            // _loginData.setMobile = value;
          },
        ),
        SizedBox(height: 20.0),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent,
              ),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(15.0),
          child: InkWell(
              onTap: () {
                _openLanguagePickerDialog();
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(8.0),
                child: chooseLanguageText,
              )),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Observer(
            builder: (_) {
              return languageText(
                user.language?.name ?? "",
              );
            },
          ),
        ),
        new SizedBox(height: 15.0),
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: _sendToServer,
            padding: EdgeInsets.all(12),
            color: Colors.lightBlueAccent,
            child: Text(AppStrings.profileCompleteBtnSubmit, style: AppFonts.loginBtn()),
          ),
        ),
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
      if (user.language == null) {
        UtilsDialog.showErrorDialog(context, "Language is required", "Please select your language.");
      } else
        user.updateUserProfile(user.fullName, user.language.id.toString(), widget.userID.toString()).then((it) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseListPage(),
              ));
        }).catchError((onError) {
          UtilsDialog.showErrorDialog(context, "Error", "An error ecoured");
        });

      //   AuthenticationRepository authenticationRepository = AuthenticationRepository();
      //   authenticationRepository
      //       .updateUserProfile(_loginData.fullName, language.id.toString(), "1")
      //       .then((c) => {

      //           })
      //       .catchError((onError) => {});

      //   print("Email ${_loginData.fullName}");
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
  }
}
