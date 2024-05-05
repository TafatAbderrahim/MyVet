part of 'register_bloc.dart';

class RegisterState extends Equatable {
  String firstName , lastName, email, password ;
  bool loading =false, success =false, error =false, exist=false ;
  RegisterState(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.loading,
      required this.success,
      required this.error,
      required this.exist
      });
  @override
  List<Object> get props => [firstName, lastName, email, password,loading,success,error];

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    bool? loading,
    bool? success,
    bool? error,
    bool? exist,
  }) =>
      RegisterState(
        email: email ?? this.email,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        loading: loading ?? this.loading,
        error: error ?? this.error,
        success: success ?? this.success,
        exist: exist?? this.exist,
      );
}
