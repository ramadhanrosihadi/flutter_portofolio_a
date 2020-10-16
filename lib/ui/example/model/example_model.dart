import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_starter_b/api/ApiProvider.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/DataResponse.dart';
import 'package:flutter_starter_b/ui/example/model/example_event.dart';
import 'package:flutter_starter_b/ui/example/model/example_state.dart';

class ExampleModel {
  final StreamController<ExampleState> _stateController = StreamController<ExampleState>.broadcast();
  Stream<ExampleState> get exampleState => _stateController.stream;

  void dispose(ExampleEvent event) {
    if (event is ExampleCallApi) {
      _callApi(event.dataRequest);
    }
  }

  Future _callApi(DataRequest dataRequest) async {
    _stateController.add(ExampleLoadingState());
    DataResponse dataResponse = await ApiProvider.callApi(dataRequest);
    if (dataResponse.isSuccess()) {
      _stateController.add(ExampleSuccessState(dataResponse));
    } else {
      _stateController.add(ExampleErrorState(dataResponse.errors));
    }
  }
}
