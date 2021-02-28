import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';
class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    final List<Meal> favoriteMeal = Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if (favoriteMeal.isEmpty) {
      return Center(
        child: Text("You have no favorites yet - start add some!"),
      );
    }
    else{
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <= 400 ? 400 : 500,
          childAspectRatio: isLandScape? dw / (dw * 0.8) : dw/(dw *0.75),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            url: favoriteMeal[index].imageUrl,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
            duration: favoriteMeal[index].duration,
            title: favoriteMeal[index].title,
            id: favoriteMeal[index].id,
          );
        },
        itemCount: favoriteMeal.length,
      );
    }
  }
}
