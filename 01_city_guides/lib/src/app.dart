import 'package:challenges/data/constants.dart';
import 'package:challenges/src/screens/destination/destination_screen.dart';
import 'package:challenges/src/screens/story/stories_screen.dart';
import 'package:challenges/src/widgets/route_animations.dart';
import "package:flutter/material.dart";
import 'screens/home/home_screen.dart';
import 'package:challenges/src/screens/home/search_screen.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.grey),
        primaryColor:AppColors.darkGrey,
      ),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name.contains("destination")) {
          final destinationId =
              int.parse(settings.name.replaceAll("destination", ""));

          return FadeInRoute(builder: (context) {
            return DestinationScreen(destinationId);
          });
        }
        if (settings.name.contains("story")) {
          final int storyId =
              int.parse(settings.name.replaceAll("story", ""));

          return SlideLeftRoute(builder: (context) {
            return StoryScreen(id: storyId,);
          });
        }

        switch (settings.name) {
          case "/":
            {
              return MaterialPageRoute(builder: (context) {
                return HomeScreen();
              });
            }
            break;
          case "/search":
            {
              return FadeInRoute(builder: (context) {
                return SearchScreen();
              });
            }
        }
      },
    );
  }
}
