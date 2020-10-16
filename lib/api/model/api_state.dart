import '../DataResponse.dart';

class ApiState {}

class InitialState extends ApiState {}

class SuccessState extends ApiState {
  final DataResponse dataResponse;

  SuccessState(this.dataResponse);
}

class ErrorState extends ApiState {
  final String error;
  ErrorState(this.error);
}

class LoadingState extends ApiState {}
