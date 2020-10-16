import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/DataResponse.dart';
import 'package:flutter_starter_b/api/Urls.dart';
import 'package:flutter_starter_b/api/model/api_event.dart';
import 'package:flutter_starter_b/api/model/api_model.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/common/constant/VKey.dart';
import 'package:flutter_starter_b/common/constant/Var.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/data/User.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_password.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_phone.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/item_lupa_kata_sandi.dart';
import 'package:flutter_starter_b/ui/dashboard/dashboard_page.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final apiModel = ApiModel();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    apiModel.apiState.forEach((element) {
      if (element is SuccessState) {
        handleSuccess(element.dataResponse);
      } else if (element is ErrorState) {
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
        Nav.pushReplacement(context, DashboardPage());
      });
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
                  "Sign in.",
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
                          stream: apiModel.apiState,
                          builder: (context, snapshot) {
                            if (snapshot.data is LoadingState) {
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
                                  apiModel.dispose(CallApi(dataRequest));
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
