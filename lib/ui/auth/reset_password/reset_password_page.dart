import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/Urls.dart';
import 'package:flutter_starter_b/api/model/api_event.dart';
import 'package:flutter_starter_b/api/model/api_model.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/data/ConfirmationData.dart';
import 'package:flutter_starter_b/ui/auth/reset_password/reset_password_confirmation_page.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_phone.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ApiModel apiModel = ApiModel();

  @override
  void initState() {
    super.initState();
    apiModel.apiState.forEach((element) {
      handleResponse(element);
    });
  }

  void handleResponse(ApiState apiState) {
    if (apiState is SuccessState) {
      Nav.push(
          context,
          ResetPasswordConfirmationPage(data: {
            'username': phoneController.text,
            'code': ConfirmationData.fromJson(apiState.dataResponse.data).code,
          }));
    } else if (apiState is ErrorState) {
      FlushbarHelper.createError(message: apiState.error).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: "Reset Password",
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Masukkan nomor hp anda',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                      ),
                    ),
                    FormPhone(controller: phoneController),
                    const SizedBox(height: 25),
                    StreamBuilder(
                      stream: apiModel.apiState,
                      builder: (context, snapshot) {
                        if (snapshot.data is LoadingState) {
                          return CircularProgressIndicator();
                        }
                        return ButtonPrimary(
                          text: 'Kirim',
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            bool isNoError = _formKey.currentState.validate();
                            if (isNoError) {
                              DataRequest dataRequest = DataRequest(
                                url: Urls.autentikasi_reset_password,
                                payload: {
                                  'email': phoneController.text,
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
