import 'package:convert_unit_currency/features/conversion/screen/conversion_screen.dart';
import 'package:flutter/material.dart';

import 'common/widget/bottom_nav.dart';
import 'features/conversion/screen/cc_conversion_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case HomeScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const HomeScreen(),
    //   );
    case BottomNav.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNav(),
      );

    case ConversionScreen.routeName:
      var convert = routeSettings.arguments as String;
      return PageRouteBuilder(
        settings: routeSettings,
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: ConversionScreen(itemTitle: convert),
        ),
      );

    case CCConversionScreen.routeName:
      var index = routeSettings.arguments as int;
      return PageRouteBuilder(
        settings: routeSettings,
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: CCConversionScreen(start: index),
        ),
      );


    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
