// ignore_for_file: public_member_api_docs, sort_constructors_first, empty_constructor_bodies, unreachable_switch_case
// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/data/repository/maps_repo.dart';
import 'package:maps_app/data/web_services/places_webservices.dart';
import 'package:maps_app/logic/maps_cubit/cubit/maps_cubit.dart';
import 'package:maps_app/logic/phone_auth_cubit/cubit/phone_cubit.dart';
import 'package:maps_app/presentation/screens/done_screen/done.dart';
import 'package:maps_app/presentation/screens/information_screen/information.dart';
import 'package:maps_app/presentation/screens/login_screen/login_screen.dart';
import 'package:maps_app/presentation/screens/map_screen/map_screen.dart';
import 'package:maps_app/presentation/screens/verify_screen.dart/verify.dart';

class AppRouter {
  PhoneCubit? phoneCubit;

  AppRouter() {
    phoneCubit = PhoneCubit();
  }

  Route? generationRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneCubit>.value(
                  value: phoneCubit!,
                  child: LoginScreen(),
                ));

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => (BlocProvider<PhoneCubit>.value(
                  value: phoneCubit!,
                  child: VerifyScreen(phoneNumber: phoneNumber),
                )));

      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MapsCubit(MapsRepository(PlacesWebservices())),
            child: MapScreen(),
          ),
        );

      case infoScreen:
        return MaterialPageRoute(
            builder: (_) => (BlocProvider<PhoneCubit>.value(
                  value: phoneCubit!,
                  child: Information(),
                ))

            // child: Information(),

            );

      case doneScreen:
        return MaterialPageRoute(
          builder: (context) => Done(),
        );
    }
  }
}
