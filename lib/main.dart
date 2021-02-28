import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';

import 'package:meal_app/screens/categories_meal_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen = (prefs.getBool("watched") ?? false) ? TabsScreen() : OnBoardingScreen();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MealProvider>(
        create: (providerContest) => MealProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
        create: (providerContext) => ThemeProvider(),
      ),
      ChangeNotifierProvider<LanguageProvider>(
        create: (providerContext) => LanguageProvider(),
      ),
    ],
    child: MyApp(homeScreen),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Widget homeScreen;
  MyApp(this.homeScreen);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: tm,
      theme: ThemeData(
          primarySwatch: primaryColor,
          accentColor: accentColor,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          buttonColor: Colors.black87,
          cardColor: Colors.white,
          shadowColor: Colors.white60,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                headline6: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              )),
      darkTheme: ThemeData(
          primarySwatch: primaryColor,
          accentColor: accentColor,
          canvasColor: Color.fromRGBO(14, 22, 33, 1),
          buttonColor: Colors.white,
          cardColor: Color.fromRGBO(35, 34, 39, 1),
          shadowColor: Colors.white60,
          fontFamily: 'Raleway',
          unselectedWidgetColor: Colors.white70,
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyText2: TextStyle(
                  color: Colors.white60,
                ),
                headline6: TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              )),
      /**
       * When You add a specific route for home page delete the {home} property
       */
      // home: MyHomePage(),
      routes: {
        '/' : (context) => homeScreen,
        TabsScreen.TabsScreenRouteName: (context) => TabsScreen(),
        CategoryMealsScreen.categoryMealsScreenName: (context) =>
            CategoryMealsScreen(),
        MealDetailScreen.mealDetailScreenRouteName: (context) =>
            MealDetailScreen(),
        FiltersScreens.FiltersScreensRouteName: (context) => FiltersScreens(),
        ThemeScreen.ThemesScreenRouteName : (context) => ThemeScreen(),
      },
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return TabsScreen();
//   }
// }
