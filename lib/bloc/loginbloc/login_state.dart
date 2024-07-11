part of 'login_bloc.dart';

class LoginState extends Equatable {
  String email = '', password = '';
  bool loading = false, error = false, succes = false,isConnected;

  LoginState({required this.email, required this.password, required this.loading, required this.succes, required this.error,required this.isConnected});
  @override
  // TODO: implement props
  List<Object> get props => [email, password, loading, succes, error];

  LoginState copyWith( {
    String? email, 
    String? password, 
    bool? loading, 
    bool? error, 
    bool? succes, 
    bool?isConneted,

  }) => LoginState(
    email : email ?? this.email, 
    password : password ?? this.password, 
    loading : loading ?? false, 
    error : error ?? false, 
    succes : succes ??false, 
    isConnected:isConnected,

  );

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};

  //   result.addAll({'email': email});

  //   return result;
  // }

  // factory LoginState.fromMap(Map<String, dynamic> map) {
  //   return LoginState(map['email'], map['password'],map[]);
  // }

  // String toJson() => json.encode(toMap());

  // factory LoginState.fromJson(String source) =>
  //     LoginState.fromMap(json.decode(source));
}
