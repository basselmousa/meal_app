import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const String mealDetailScreenRouteName = "/meal_detail";

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child , BuildContext context) {
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: isLandScape ? dh*0.5 : dh *0.25,
      width: isLandScape ? (dw*0.5-30) : dw,
      child: child,
    );
  }

  bool useWhiteForeground(Color backgroundColor) =>
      1.05 / (backgroundColor.computeLuminance() + 0.05) > 4.5;

  @override
  Widget build(BuildContext context) {
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).accentColor;

    var liSteps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text("# ${index + 1}"),
            ),
            title: Text(
              selectedMeal.steps[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider()
        ],
      ),
      itemCount: selectedMeal.steps.length,
    );

    var liIngredients = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            selectedMeal.ingredients[index],
            style: TextStyle(
                color: useWhiteForeground(accentColor)
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
      itemCount: selectedMeal.ingredients.length,
    );

    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(selectedMeal.title),
              background: Hero(
                tag: mealId,
                child: InteractiveViewer(
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/a2.png'),
                    image: NetworkImage(
                      selectedMeal.imageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      buildSectionTitle(context, "Ingredients"),
                      buildContainer(liIngredients, context),
                    ],
                  ),
                  Column(
                    children: [
                      buildSectionTitle(context, "Steps"),
                      buildContainer(liSteps, context)
                    ],
                  )
                ],
              ),
            if (! isLandScape) buildSectionTitle(context, "Ingredients"),
            if (! isLandScape) buildContainer(liIngredients, context),
            if (! isLandScape) buildSectionTitle(context, "Steps"),
            if (! isLandScape) buildContainer(liSteps, context)
          ])),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(mealId);
        },
        child: Icon(Provider.of<MealProvider>(context, listen: true)
                .isMealFavorite(mealId)
            ? Icons.star
            : Icons.star_border),
      ),
    );
  }
}
