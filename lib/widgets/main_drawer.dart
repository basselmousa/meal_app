import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(IconData icon, String text, Function tapHandler,
      BuildContext buildContext) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(buildContext).buttonColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          color: Theme.of(buildContext).textTheme.bodyText1.color,
        ),
      ),
      onTap: tapHandler,
    );
  }


  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).accentColor,
              child: Text(
                lan.getTexts("drawer_name"),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              alignment: lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile(Icons.restaurant, lan.getTexts('drawer_item1'), () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.TabsScreenRouteName);
            }, context),
            buildListTile(Icons.settings, lan.getTexts('drawer_item2'), () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreens.FiltersScreensRouteName);
            }, context),
            buildListTile(Icons.color_lens, lan.getTexts('drawer_item3'), () {
              Navigator.of(context)
                  .pushReplacementNamed(ThemeScreen.ThemesScreenRouteName);
            }, context),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Text(
                lan.getTexts('drawer_switch_title'),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: (lan.isEn ? 0 : 20),
                  left: (lan.isEn ? 20 : 0),
                  bottom: (lan.isEn ? 20 : 10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lan.getTexts('drawer_switch_item2'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                      value: Provider.of<LanguageProvider>(context, listen: true)
                          .isEn,
                      onChanged: (newValue) {
                        Provider.of<LanguageProvider>(context, listen: false)
                            .changeLan(newValue);
                      }),
                  Text(
                    lan.getTexts('drawer_switch_item1'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Divider(height: 10,color: Colors.black54,)
          ],
        ),
      ),
    );
  }
}
