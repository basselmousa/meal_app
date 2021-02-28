import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';
class CategoryMealsScreen extends StatefulWidget {
  static const String categoryMealsScreenName = '/category_meals';
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  @override
  void didChangeDependencies() {
    final List<Meal> filteredMeals = Provider.of<MealProvider>(context, listen: true).availableMeals;
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final categoryId = routeArguments['id'];
    categoryTitle = routeArguments['title'];
    displayedMeals = filteredMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <= 400 ? 400 : 500,
          childAspectRatio: isLandScape? dw / (dw * 0.8) : dw/(dw *0.75),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            url: displayedMeals[index].imageUrl,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            duration: displayedMeals[index].duration,
            title: displayedMeals[index].title,
            id: displayedMeals[index].id,

          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
