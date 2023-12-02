import 'package:convert_unit_currency/constant/color.dart';
import 'package:convert_unit_currency/features/settings/screen/constants/constant_keys.dart';
import 'package:convert_unit_currency/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';

import 'common/widget/bottom_nav.dart';

Future<void> main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueChangeObserver<bool>(
        cacheKey: ConstantKeys.keyDarkMode,
        defaultValue: true,
        builder: (_,isDarkMode,__) {
          return MaterialApp(
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            title: 'Ultimate Converter',
            theme:isDarkMode ? ThemeData.dark().copyWith(
              primaryColor: GlobalColor.secondaryColor,
              colorScheme: ColorScheme.dark(),
              scaffoldBackgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.black)
            ) : ThemeData.light().copyWith(colorScheme: ColorScheme.light(), primaryColor: GlobalColor.secondaryColor,scaffoldBackgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.white)
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a blue toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.

             , useMaterial3: true,
            ),
            home:  const BottomNav(),
            onGenerateRoute: (settings) => generateRoute(settings),
          );
        },
      ),
    );
  }
}


