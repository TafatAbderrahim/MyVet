import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:project/models/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Map<String, String> headers = {};
  User user;
  LoginBloc(this.user)
      : super(LoginState(
          email: '',
          password: '',
          loading: false,
          succes: false,
          error: false,
          isConnected: false,
        )) {
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(
          email: event.email, password: event.password, loading: true));

      try {
        //fetch with event.email event.password
        var host = '192.168.122.133';
        var url = Uri.parse('http://$host:5000/login');
        var response = await post(
          url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(
            {
              "email": "${event.email}",
              "password": "${event.password}",
            },
          ),
        );
        updateCookie(response);
        print('resopnse=${response.headers}');
        print('resopnse=${response.body}');
        //LoginBloc.fromJson(data);
        var donnes = json.decode(response.body);
        print(donnes['user']);
        user.fromMap(donnes['user'], donnes["jwt"]);
        user.isConnected = true;
        user.toHive();
        // emit(LoginState(event.email, event.password,false,true,false));
        emit(state.copyWith(loading: false, succes: true));
        print(user.firstName + ' + ' + user.email);
      } catch (e) {
        print(e);
        print('error fetching data');
        // emit(LoginState(event.email, event.password, false, false, true));
        emit(state.copyWith(loading: false, error: true));
      }
      emit(state.copyWith(loading: false, error: false, succes: false));
    });
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({});

    return result;
  }

  void updateCookie(var response) {
    String? rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');

      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  // factory LoginBloc.fromMap(Map<String, dynamic> map) {
  //   return LoginBloc(
  //     User.fromMap(map),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory LoginBloc.fromJson(String source) =>
  //     LoginBloc.fromMap(json.decode(source));
}
