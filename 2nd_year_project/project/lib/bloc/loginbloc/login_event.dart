part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  String email = '', password = '';
  LoginEvent({
    required this.email,
    required this.password,
  });

  // LoginEvent copyWith({String? email, String? password, bool? isConnected}) =>
  //     LoginEvent(
  //       email: email ?? this.email,
  //       password: password ?? this.password,
  //       isConnected: isConnected ?? this.isConnected,
  //     );

  @override
  // TODO: implement props
  List<Object> get props {
    return [email, password];
  }
}
