import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/Urls.dart';
import 'package:flutter_starter_b/api/model/api_event.dart';
import 'package:flutter_starter_b/api/model/api_model.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/util/Validator.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/ui/auth/signin/signin_page.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_password.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_text.dart';

class ResetPasswordConfirmationPage extends StatefulWidget {
  const ResetPasswordConfirmationPage({Key key, this.data}) : super(key: key);

  @override
  _ResetPasswordConfirmationPageState createState() => _ResetPasswordConfirmationPageState();

  final Map<String, dynamic> data;
}

class _ResetPasswordConfirmationPageState extends State<ResetPasswordConfirmationPage> {
  TextEditingController _codeController = new TextEditingController();
  TextEditingController _passwordNewController = new TextEditingController();
  TextEditingController _passwordNewConfirmationController = new TextEditingController();
  final ApiModel apiModel = ApiModel();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    apiModel.apiState.forEach((element) {
      handleResponse(element);
    });
  }

  void handleResponse(ApiState apiState) async {
    if (apiState is SuccessState) {
      await Fun.createDialog(context, title: "Berhasil", message: "Password anda berhasil dirubah, silahkan login untuk melanjutkan.", withBackButton: false);
      Nav.pushAndRemoveUntil(context, SigninPage());
    } else if (apiState is ErrorState) {
      FlushbarHelper.createError(message: apiState.error).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: "Konfirmasi Reset Password",
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 50),
              Text(
                'Kode verifikasi sudah dikirim ke nomor hp',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 2),
              Text(widget.data['username'], style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              FormText(
                                controller: _codeController,
                                label: "Kode verifikasi",
                                textInputType: TextInputType.number,
                                icon: Icons.vpn_key,
                                validator: (value) {
                                  String isTextValid = Validator.isTextValid(value, label: "Kode verifikasi");
                                  if (isTextValid != null) {
                                    return isTextValid;
                                  } else if (value != widget.data['code']) {
                                    return "Kode verifikasi tidak cocok";
                                  }
                                  return null;
                                },
                              ),
                              Divider(),
                              FormPassword(controller: _passwordNewController, label: "Kata sandi baru"),
                              Divider(),
                              FormPassword(
                                controller: _passwordNewConfirmationController,
                                label: "Konfirmasi kata sandi",
                                validator: (value) {
                                  if (value != _passwordNewController.text) {
                                    return "Kata sandi tidak cocok";
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      StreamBuilder(
                        stream: apiModel.apiState,
                        builder: (context, snapshot) {
                          if (snapshot.data is LoadingState) {
                            return CircularProgressIndicator();
                          }
                          return ButtonPrimary(
                            text: 'Simpan',
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              bool isNoError = _formKey.currentState.validate();
                              if (isNoError) {
                                Fun.log.wtf("noError bro");
                                DataRequest dataRequest = DataRequest(
                                  url: Urls.autentikasi_reset_password_confirmation,
                                  payload: {
                                    'code': _codeController.text,
                                    'email': widget.data['username'],
                                    'password': _passwordNewController.text,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
