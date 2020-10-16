import 'package:flutter_starter_b/api/DataResponse.dart';

class ExampleState {}

class InitialState extends ExampleState {}

class ExampleSuccessState extends ExampleState {
  final DataResponse dataResponse;

  ExampleSuccessState(this.dataResponse);
}

class ExampleErrorState extends ExampleState {
  final String error;
  ExampleErrorState(this.error);
}

class ExampleLoadingState extends ExampleState {}
