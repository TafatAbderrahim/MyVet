import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/models/user.dart';
import 'package:http/http.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  User user;
  RegisterBloc(this.user)
      : super(RegisterState(
            firstName: '',
            lastName: '',
            email: '',
            password: '',
            loading: false,
            success: false,
            error: false,
            exist: false)) {
    on<RegisterEvent>((event, emit) async {
      emit(state.copyWith(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
          loading: true));
      try {
        var host = '192.168.34.133';

        var url = "http://$host:5000/register";
        // var uri = Uri.parse("$url/register");
        // var response = await post(uri, body: {"email": "${event.email}"});
        // var data = response.body;
        // var donnees = jsonDecode(data);
        // print(donnees);
        // bool availble = donnees["isAvailable"];
        if (true) {
          print('user dont exist');
          var uri = Uri.parse(url);
          var response = await post(uri,
              headers: {
                "Content-Type": "application/json",
              },
              body: json.encode(
                {
                  "firstName": "${event.firstName}",
                  "lastName": " ${event.lastName}",
                  "email": "${event.email}",
                  "password": "${event.password}",
                  "avatar": "https://picsum.photos/800",
                },
              ));
          var data = response.body;
          var donnees = jsonDecode(data);
          print(donnees);
          emit(state.copyWith(loading: false, success: true));
          print('user logged in');
          user.toHive();
          print('user saved');
        }
      } catch (e) {
        emit(state.copyWith(loading: false, error: true));
        print('error= $e');
      }
      state.copyWith(
          loading: false, success: false, error: false, exist: false);
    });
  }
}
