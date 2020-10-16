import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/Urls.dart';
import 'package:flutter_starter_b/api/model/api_event.dart';
import 'package:flutter_starter_b/api/model/api_model.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/util/Validator.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_password.dart';

class UbahPasswordPage extends StatefulWidget {
  @override
  _UbahPasswordPageState createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final apiModel = ApiModel();
  final TextEditingController _passwordOldController = TextEditingController();
  final TextEditingController _passwordNewController = TextEditingController();
  final TextEditingController _passwordNewConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    apiModel.apiState.forEach((element) {
      handleResponse(element);
    });
  }

  void handleResponse(ApiState state) {
    if (state is SuccessState) {
      Fun.createDialog(context, title: "Berhasil", message: "Kata sandi berhasil diubah.", withBackButton: false).then((value) {
        Nav.pop(context);
      });
    } else if (state is ErrorState) {
      FlushbarHelper.createError(message: state.error).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: "Ubah Kata Sandi",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Form(
                key: _formKey,
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
                            FormPassword(
                              controller: _passwordOldController,
                              label: "Kata sandi lama",
                            ),
                            Divider(),
                            FormPassword(
                              controller: _passwordNewController,
                              label: "Kata sandi baru",
                            ),
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
                              DataRequest dataRequest = DataRequest(
                                url: Urls.profile_change_password,
                                payload: {
                                  'old_password': _passwordOldController.text,
                                  'new_password': _passwordNewController.text,
                                  'new_password_confirmation': _passwordNewConfirmationController.text,
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
