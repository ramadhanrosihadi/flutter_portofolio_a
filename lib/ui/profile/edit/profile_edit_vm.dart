import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/Urls.dart';
import 'package:flutter_starter_b/api/model/api_event.dart';
import 'package:flutter_starter_b/api/model/api_model.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/ImageUtil.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/data/Berkas.dart';
import 'package:flutter_starter_b/data/User.dart';

class ProfileEditViewModel {
  ProfileEditViewModel(this.context, this.apiModel);
  final BuildContext context;
  final ApiModel apiModel;
  Berkas _uploadedFile;

  void handleResponse(ApiState state, Map<String, dynamic> payload) async {
    if (state is SuccessState) {
      if (state.dataResponse.isCalled(Urls.profile_update)) {
        var updatedUser = User.fromJson(state.dataResponse.data);
        var currentUser = await UserPref.loadUser();
        updatedUser.access = currentUser.access;
        updatedUser.roles = currentUser.roles;
        await UserPref.saveUser(updatedUser);
        Fun.createDialog(context, title: "Berhasil", message: "Perubahan yang anda lakukan berhasil disimpan", withBackButton: false).then((value) {
          Nav.pop(context, true);
        });
      } else if (state.dataResponse.isCalled(Urls.upload_image)) {
        _uploadedFile = Berkas.fromJson(state.dataResponse.data);
        callApiUpdateProfile(payload);
      }
    } else if (state is ErrorState) {
      FlushbarHelper.createError(message: state.error).show(context);
    }
  }

  void callApiUpdateProfile(Map<String, dynamic> payload) {
    if (_uploadedFile != null) {
      payload['file_id'] = _uploadedFile.id;
    }
    DataRequest dataRequest = DataRequest(
      url: Urls.profile_update,
      payload: payload,
    );
    apiModel.dispose(CallApi(dataRequest));
  }

  void callApiUploadFile(File imageProfile) async {
    File compressedFile = await ImageUtil.compressImage(imageProfile);
    MultipartFile multipartFile = await MultipartFile.fromFile(compressedFile.path, filename: imageProfile.path.split('/').last);
    DataRequest dataRequest = DataRequest(
      url: Urls.upload_image,
      formData: FormData.fromMap(
        {
          'file': multipartFile,
          'folder': "profile_picture",
        },
      ),
    );
    apiModel.dispose(CallApi(dataRequest));
  }
}
