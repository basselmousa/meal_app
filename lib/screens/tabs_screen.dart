import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorite_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const String TabsScreenRouteName = '/tabs_screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectpage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).getFilterData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();

    // TODO: implement initState
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(),
        'title': 'Your Favorite',
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          onTap: _selectpage,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text("Category"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text("Favorite"),
            )
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
