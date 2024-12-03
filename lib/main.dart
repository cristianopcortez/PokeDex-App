import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_pokedex/Helpers/api_helper.dart';
import 'package:my_pokedex/routes/app_pages.dart';
import 'package:my_pokedex/routes/routes.dart';
import 'package:my_pokedex/utitliy/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GetIt getIt = GetIt.instance;

// Setting Up GetIt for Dependency Injection (DI)
void setup() {
  getIt.registerSingleton<APIHelper>(APIHelper());
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  setup();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokeDex',
      initialRoute: Routes.SPLASH,
      getPages: AppPages.appPages,
      defaultTransition: Transition.fade,
      theme: ThemeData(
        fontFamily: FONT,
      ),
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
