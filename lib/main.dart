// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters, unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/app_router.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/firebase_options.dart';
import 'package:maps_app/presentation/screens/done_screen/done.dart';
import 'package:maps_app/presentation/screens/information_screen/information.dart';

late String initialRoute;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = loginScreen;
    } else {
      initialRoute = mapScreen;
      // initialRoute = infoScreen;
    }
  });
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
          ),
          //  home: Information(),
          onGenerateRoute: appRouter.generationRoute,
          initialRoute: initialRoute,
        );
      },
    );
  }
}
