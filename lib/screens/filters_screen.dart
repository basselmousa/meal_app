import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreens extends StatefulWidget {
  static const String FiltersScreensRouteName = '/filters_screens';

  final bool fromOnBoarding;

  FiltersScreens({this.fromOnBoarding = false});

  @override
  _FiltersScreensState createState() => _FiltersScreensState();
}

class _FiltersScreensState extends State<FiltersScreens> {
  Widget buildSwitchListTile(
      String title, String subTitle, bool value, Function updateValue) {
    return SwitchListTile(
      value: value,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(subTitle),
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilter =
        Provider.of<MealProvider>(context, listen: true).filters;

    return Scaffold(
      appBar: widget.fromOnBoarding
          ? AppBar(
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0,
            )
          : AppBar(
              title: Text("Filters"),
            ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                    "Gluten-free",
                    "Only include gluten-free meals.",
                    currentFilter['gluten'], (v1) {
                  setState(() {
                    currentFilter['gluten'] = v1;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                }),
                buildSwitchListTile(
                    "Lactose-free",
                    "Only include lactose-free meals.",
                    currentFilter['lactose'], (v2) {
                  setState(() {
                    currentFilter['lactose'] = v2;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                }),
                buildSwitchListTile("Vegan", "Only include vegan meals.",
                    currentFilter['vegan'], (v3) {
                  setState(() {
                    currentFilter['vegan'] = v3;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                }),
                buildSwitchListTile(
                    "Vegetarian",
                    "Only include vegetarian meals.",
                    currentFilter['vegetarian'], (v4) {
                  setState(() {
                    currentFilter['vegetarian'] = v4;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                }),
                SizedBox(
                  height: widget.fromOnBoarding ? 80 : 0,
                )
              ],
            ),
          )
        ],
      ),
      drawer: widget.fromOnBoarding ? null : MainDrawer(),
    );
  }
}
