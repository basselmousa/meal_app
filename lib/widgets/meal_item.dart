import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;

  final String url;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    @required this.url,
    @required this.title,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.id,
  });

  String get _complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return "Simple";
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
      default:
        return "Unknown";
    }
  }

  String get _affordabilitytext {
    switch (affordability) {
      case Affordability.Pricey:
        return "Pricy";
      case Affordability.Affordable:
        return "Affordable";
      case Affordability.Luxurious:
        return "Luxurios";
      default:
        return "Unknown";
    }
  }

  void selectMeal(BuildContext buildContext) {
    Navigator.of(buildContext).pushNamed(
      MealDetailScreen.mealDetailScreenRouteName,
      arguments: id
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Hero(
                    tag: id,
                    child: InteractiveViewer(
                      child: FadeInImage(
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/images/a2.png'),
                        image: NetworkImage(
                          url,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule , color: Theme.of(context).buttonColor,),
                      SizedBox(
                        width: 6,
                      ),
                      Text("$duration min", style: Theme.of(context).textTheme.headline6)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work , color: Theme.of(context).buttonColor),
                      SizedBox(
                        width: 6,
                      ),
                      Text(_complexityText, style: Theme.of(context).textTheme.headline6)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money , color: Theme.of(context).buttonColor),
                      SizedBox(
                        width: 6,
                      ),
                      Text("$_affordabilitytext", style: Theme.of(context).textTheme.headline6)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
