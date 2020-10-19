import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/model/api_model.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/common/constant/VString.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/ImageUtil.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/cached_image.dart';
import 'package:flutter_starter_b/common/widget/image_circle.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/common/widget/text_rounded.dart';
import 'package:flutter_starter_b/data/User.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_email.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_phone.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_text.dart';
import 'package:flutter_starter_b/ui/profile/edit/profile_edit_vm.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final apiModel = ApiModel();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User currentUser = User();
  File _imageProfile;
  ProfileEditViewModel viewModel;

  @override
  void initState() {
    viewModel = ProfileEditViewModel(context, apiModel);
    UserPref.loadUser().then((value) {
      setState(() {
        _phoneController.text = value.phone;
        _emailController.text = value.email;
        _nameController.text = value.name;
        currentUser = value;
      });
    });
    super.initState();
    apiModel.apiState.forEach((element) {
      viewModel.handleResponse(element, getPayload());
    });
  }

  Map<String, dynamic> getPayload() {
    return {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: "Edit Profile",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              ImageCircle(
                size: 100,
                child: _imageProfile == null
                    ? CachedImage(
                        height: 100,
                        width: 100,
                        url: currentUser.profilePath(),
                        emptyImage: "user.png",
                      )
                    : Image(
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                        image: FileImage(_imageProfile),
                      ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  ImageUtil.createDialogAmbilGambar(
                    context,
                    (path) {
                      Fun.log.v("path: $path");
                      if (path != null) {
                        setState(() {
                          _imageProfile = File(path);
                        });
                      }
                    },
                  );
                },
                child: TextRounded(text: "Ubah"),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormText(controller: _nameController, icon: Icons.person),
                    FormPhone(controller: _phoneController, enabled: false),
                    FormEmail(controller: _emailController),
                    const SizedBox(height: 25),
                    StreamBuilder(
                      stream: apiModel.apiState,
                      builder: (context, snapshot) {
                        if (snapshot.data is LoadingState) {
                          return Text(VString.please_wait);
                        }
                        return ButtonPrimary(
                          text: 'Simpan',
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            bool isNoError = _formKey.currentState.validate();
                            if (isNoError) {
                              if (_imageProfile == null) {
                                viewModel.callApiUpdateProfile(getPayload());
                              } else {
                                viewModel.callApiUploadFile(_imageProfile);
                              }
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
