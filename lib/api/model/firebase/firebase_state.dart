enum StateCode { LOADING, SUCCESS, ERROR }

class FirebaseState {
  StateCode stateCode;
  dynamic data;

  FirebaseState({
    this.stateCode,
    this.data,
  });
}
