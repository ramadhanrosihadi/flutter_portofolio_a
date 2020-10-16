import 'dart:async';

import 'package:flutter_starter_b/api/model/api_state.dart';

import '../ApiProvider.dart';
import '../DataRequest.dart';
import '../DataResponse.dart';
import 'api_event.dart';

class ApiModel {
  final StreamController<ApiState> _stateController = StreamController<ApiState>.broadcast();
  Stream<ApiState> get apiState => _stateController.stream;

  void dispose(ApiEvent event) {
    if (event is CallApi) {
      _callApi(event.dataRequest);
    }
  }

  Future _callApi(DataRequest dataRequest) async {
    _stateController.add(LoadingState());
    DataResponse dataResponse = await ApiProvider.callApi(dataRequest);
    if (dataResponse.isSuccess()) {
      _stateController.add(SuccessState(dataResponse));
    } else {
      _stateController.add(ErrorState(dataResponse.errors));
    }
  }
}
