import '../DataRequest.dart';

class ApiEvent {}

class CallApi extends ApiEvent {
  final DataRequest dataRequest;

  CallApi(this.dataRequest);
}
