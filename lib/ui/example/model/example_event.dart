import 'package:flutter_starter_b/api/DataRequest.dart';

class ExampleEvent {}

class ExampleCallApi extends ExampleEvent {
  final DataRequest dataRequest;

  ExampleCallApi(this.dataRequest);
}
