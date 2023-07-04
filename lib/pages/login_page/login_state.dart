abstract class LoginState {}

class LoginInitial extends LoginState {
  // List<Map<String, dynamic>>? result;

  // LoginInitial(this.result);
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

// class LoginError extends LoginState {
//   String message;

//   LoginError(this.message);
// }


///// LOGIN ERROR İÇİN STATE KULLANILMADI UYARI CUBİTTE GÖSTERİRLİYOR