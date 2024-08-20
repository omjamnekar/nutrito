import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {}

class AuthenticationFailed extends AuthState {
  final String error;

  AuthenticationFailed(this.error);

  @override
  List<Object> get props => [error];
}
