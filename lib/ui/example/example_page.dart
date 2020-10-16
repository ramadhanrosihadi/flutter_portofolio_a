import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/DataResponse.dart';
import 'package:flutter_starter_b/api/Urls.dart';
import 'package:flutter_starter_b/common/constant/VKey.dart';
import 'package:flutter_starter_b/common/constant/VTheme.dart';
import 'package:flutter_starter_b/common/constant/Var.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/data/User.dart';
import 'package:flutter_starter_b/ui/example/model/example_model.dart';
import 'package:flutter_starter_b/ui/example/model/example_state.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_phone.dart';

import 'model/example_event.dart';
import '../auth/signin/widgets/form_email.dart';
import '../auth/signin/widgets/form_password.dart';
import '../auth/signin/widgets/item_lupa_kata_sandi.dart';

class ExamplePage extends StatefulWidget {
  ExamplePage({Key key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final exampleModel = ExampleModel();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    exampleModel.exampleState.forEach((element) {
      if (element is ExampleSuccessState) {
        handleSuccess(element.dataResponse);
        if (element.dataResponse.isCalled(Urls.autentikasi_signin)) {}
      } else if (element is ExampleErrorState) {
        FlushbarHelper.createError(message: element.error).show(context);
      }
    });
    if (Var.isDebugMode) {
      phoneController.text = "082245947379";
      passwordController.text = "123456";
    }
  }

  void handleSuccess(DataResponse dataResponse) {
    if (dataResponse.isCalled(Urls.autentikasi_signin)) {
      UserPref.saveUser(User.fromJson(dataResponse.data)).then((value) {
        FlushbarHelper.createSuccess(message: "Selamat Datang ${value.name}").show(context);
      });
      Future.delayed(Duration(seconds: 2)).then((value) {
        DataRequest dataRequest = DataRequest(
          url: Urls.autentikasi_signout,
          payload: null,
        );
        exampleModel.dispose(ExampleCallApi(dataRequest));
      });
    } else if (dataResponse.isCalled(Urls.autentikasi_signout)) {
      FlushbarHelper.createSuccess(message: "Signout berhasil").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Center(
                child: Text(
                  "Example.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                    letterSpacing: 4,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        FormPhone(controller: phoneController),
                        FormPassword(controller: passwordController),
                        ItemLupaKataSandi(),
                        const SizedBox(height: 25),
                        StreamBuilder(
                          stream: exampleModel.exampleState,
                          builder: (context, snapshot) {
                            if (snapshot.data is ExampleLoadingState) {
                              return CircularProgressIndicator();
                            }
                            return ButtonPrimary(
                              text: 'Masuk',
                              onPressed: () async {
                                FocusScope.of(context).requestFocus(FocusNode());
                                bool isNoError = _formKey.currentState.validate();
                                if (isNoError) {
                                  DataRequest dataRequest = DataRequest(
                                    url: Urls.autentikasi_signin,
                                    payload: {
                                      'username': phoneController.text,
                                      'password': passwordController.text,
                                      'grant_type': 'password',
                                      'client_id': VKey.getClientId(),
                                      'client_secret': VKey.getClientSecret(),
                                    },
                                  );
                                  exampleModel.dispose(ExampleCallApi(dataRequest));
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
