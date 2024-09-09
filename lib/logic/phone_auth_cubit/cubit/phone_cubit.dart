// ignore_for_file: avoid_print, unused_local_variable, depend_on_referenced_packages, unnecessary_this

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  late String verificationId;
  late String url;

  PhoneCubit() : super(PhoneInitial());

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print("verificationCompleted");
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print("verificationFailed : ${error.toString()}");
    emit(ErrorOcurred(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print("codeAutoRetrievalTimeout");
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOtpVerified());
    } catch (error) {
      emit(ErrorOcurred(errorMsg: error.toString()));
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInuser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

  sendInfoToDataBase(
      String firstName, String lastName, String? imgName, File? imgPath) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    final storageRef = FirebaseStorage.instance.ref(imgName);

    if (imgPath != null) {
      await storageRef.putFile(imgPath);
      url = await storageRef.getDownloadURL();
    } else {
      url = '';
    }

    users
        .doc(firebaseUser.uid)
        .set({'img-link': url, 'first_name': firstName, 'last_name': lastName})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // sendPhotoToStorage(String imgName , File imgPath) async{
  //   final storageRef = FirebaseStorage.instance.ref(imgName);
  //     await storageRef.putFile(imgPath);
  // }
}
