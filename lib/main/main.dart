import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:survey/main/factories/pages/splash/splash_page_factory.dart';

import '../ui/components/components.dart';
import 'factories/factories.dart';

void main() {
  // R.load(Locale('en', 'US'));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'Enquete',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: makeSplashPage,
          transition: Transition.fade,
        ),
        GetPage(
          name: '/login',
          page: makeLoginPage,
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/surveys',
          page: () => Scaffold(body: Text('Enquetes')),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
