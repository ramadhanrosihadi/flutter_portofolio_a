import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/Urls.dart';
import 'package:flutter_starter_b/api/model/api_event.dart';
import 'package:flutter_starter_b/api/model/api_model.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/constant/Var.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/data/User.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_password.dart';

class PinChangePage extends StatefulWidget {
  @override
  _PinChangePageState createState() => _PinChangePageState();
}

class _PinChangePageState extends State<PinChangePage> {
  User currentUser = User();
  bool isGunakanPin = false;
  final apiModel = ApiModel();
  final TextEditingController _pinOldController = TextEditingController();
  final TextEditingController _pinNewController = TextEditingController();
  final TextEditingController _pinNewConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    UserPref.loadUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    UserPref.loadGunakanPin().then((value) {
      setState(() {
        isGunakanPin = value;
      });
    });
    super.initState();
    apiModel.apiState.forEach((element) {
      handleResponse(element);
    });
  }

  void handleResponse(ApiState state) async {
    if (state is SuccessState) {
      User currentUser = await UserPref.loadUser();
      currentUser.pin = _pinNewController.text;
      await UserPref.saveUser(currentUser);
      Fun.createDialog(context, title: "Berhasil", message: "PIN berhasil diubah.", withBackButton: false).then((value) {
        Nav.pop(context);
      });
    } else if (state is ErrorState) {
      FlushbarHelper.createError(message: state.error).show(context);
    }
  }

  Future setGunakanPin(bool value) async {
    await UserPref.saveGunakanPin(value);
    setState(() {
      isGunakanPin = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: "Ubah PIN",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
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
                            Visibility(
                              visible: currentUser.pin != null ? true : false,
                              child: Column(
                                children: [
                                  FormPassword(
                                    controller: _pinOldController,
                                    label: "PIN lama",
                                    textInputType: TextInputType.number,
                                    maxLength: Var.pin_length,
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                            FormPassword(
                              controller: _pinNewController,
                              label: "PIN baru",
                              textInputType: TextInputType.number,
                              maxLength: Var.pin_length,
                            ),
                            Divider(),
                            FormPassword(
                              controller: _pinNewConfirmationController,
                              label: "Konfirmasi PIN",
                              textInputType: TextInputType.number,
                              maxLength: Var.pin_length,
                              validator: (value) {
                                if (value != _pinNewController.text) {
                                  return "PIN tidak cocok";
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
                                url: Urls.profile_update,
                                payload: {
                                  'pin': _pinNewConfirmationController.text,
                                },
                              );
                              apiModel.dispose(CallApi(dataRequest));
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          activeColor: VColor.colorPrimary,
                          value: isGunakanPin,
                          onChanged: (value) async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setGunakanPin(value);
                          },
                        ),
                        Flexible(
                          child: Text(
                            'Gunakan PIN',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
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
