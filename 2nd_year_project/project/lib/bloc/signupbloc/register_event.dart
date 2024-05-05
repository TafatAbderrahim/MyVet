part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  String firstName, lastName, email, password;

  RegisterEvent(this.firstName, this.lastName, this.email, this.password);

  @override
  List<Object> get props => [firstName, lastName, email, password];
}
