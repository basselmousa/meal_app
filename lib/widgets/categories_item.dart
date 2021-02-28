import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_meal_screen.dart';

class CategoryItems extends StatelessWidget {
  final String title;
  final String id;
  final Color color;

  CategoryItems(this.title, this.id, this.color);

  void selectCategory(BuildContext buildContext) {
    Navigator.of(buildContext).pushNamed(
      CategoryMealsScreen.categoryMealsScreenName,
      arguments: {
        'id':id,
        'title':title
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectCategory(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color.withOpacity(0.4), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
