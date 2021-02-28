import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];

  List<Category> availableCategory = [];

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if(cat.id == catId)
            if(!ac.any((categ) => categ.id == catId))
              ac.add(cat);
        });
      });
    });
    availableCategory = ac;

    notifyListeners();

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("gluten", filters['gluten']);
    pref.setBool("lactose", filters['lactose']);
    pref.setBool("vegan", filters['vegan']);
    pref.setBool("vegetarian", filters['vegetarian']);
  }

  void getFilterData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    filters['gluten'] = pref.getBool("gluten") ?? false;
    filters['lactose'] = pref.getBool("lactose") ?? false;
    filters['vegan'] = pref.getBool("vegan") ?? false;
    filters['vegetarian'] = pref.getBool("vegetarian") ?? false;
    setFilters();
    prefsMealId = pref.getStringList('prefsId') ?? [];

    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    List<Meal> fm = [];
    favoriteMeals.forEach((favMeal) {
      availableMeals.forEach((avMeal) {
        if(favMeal.id == avMeal.id)
          fm.add(favMeal);
      });
    });
    favoriteMeals = fm;

    notifyListeners();
  }

  void toggleFavorite(String mealId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    notifyListeners();

    pref.setStringList('prefsId', prefsMealId);
  }

  bool isMealFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }
}
