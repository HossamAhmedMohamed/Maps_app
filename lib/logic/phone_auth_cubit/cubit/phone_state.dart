// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'phone_cubit.dart';

@immutable
sealed class PhoneState {}

final class PhoneInitial extends PhoneState {}

class Loading extends PhoneState {}

class ErrorOcurred extends PhoneState {
  final String errorMsg;
  ErrorOcurred({
    required this.errorMsg,
  });
}

class PhoneNumberSubmitted extends PhoneState {}

class PhoneOtpVerified extends PhoneState {}


