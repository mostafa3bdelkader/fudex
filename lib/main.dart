import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/presentation/widgets/navigation_bar.dart';
import 'package:fudex/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'helpers/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => HomeProvider(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', 'AE'),
            ],
            locale: const Locale('ar', 'AE'),
            debugShowCheckedModeBanner: false,
            title: 'Kortobaa',
            theme: ThemeData(
              primaryColor: kPrimaryOrange,
              fontFamily: 'Tajawal',
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: child,
          ),
        );
      },
      child: const AnimatedNavigationBar(),
    );
  }
}
