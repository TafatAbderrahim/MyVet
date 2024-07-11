part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  String firstName, lastName, email, password,phoneNumber;

  RegisterEvent(this.firstName, this.lastName, this.email, this.password,this.phoneNumber);

  @override
  List<Object> get props => [firstName, lastName, email, password,phoneNumber];
}
