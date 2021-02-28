import 'package:flutter/material.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemeScreen extends StatelessWidget {
  static const String ThemesScreenRouteName = '/theme';

  final bool fromOnBoarding;
  ThemeScreen({this.fromOnBoarding = false});

  Widget buildRadioListTile(ThemeMode themeVal, String title, IconData icon,
      BuildContext buildContext) {
    return RadioListTile(
      secondary: Icon(icon, color: Theme.of(buildContext).buttonColor,),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(buildContext, listen: true).tm,
      onChanged: (newThemeVal) {
        Provider.of<ThemeProvider>(buildContext, listen: false).themeModeChanged(newThemeVal);
      },
      title: Text(title),
    );
  }

  Widget buildListTile(BuildContext context, txt){
    var primaryColor = Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context, listen: true).accentColor;

    return ListTile(
      title: Text("Choose your $txt color", style: Theme.of(context).textTheme.headline6,),
      trailing: CircleAvatar(
        backgroundColor: txt == 'primary' ? primaryColor : accentColor,
      ),
      onTap: (){
        showDialog(context: context, builder: (BuildContext ctx){
          return AlertDialog(
            elevation: 4,
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: txt == 'primary' ? Provider.of<ThemeProvider>(context, listen: true).primaryColor : Provider.of<ThemeProvider>(context, listen: true).accentColor ,
                onColorChanged: (newColor){
                  return Provider.of<ThemeProvider>(context, listen: false).onChenged(newColor, txt == 'primary' ? 1 : 2);
                },
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
                showLabel: false,
              ),
            ),
          );
        });
      },

    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fromOnBoarding
          ? AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      )
          :AppBar(title: Text("Your Theme"),),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust your themes selection", style: Theme.of(context).textTheme.headline6,),
          ),
          Expanded(child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text("Choose your theme Mode", style: Theme.of(context).textTheme.headline6,),
              ),
              buildRadioListTile(ThemeMode.system, "System Default Theme", null, context),
              buildRadioListTile(ThemeMode.light, "Light Theme", Icons.wb_sunny_outlined, context),
              buildRadioListTile(ThemeMode.dark, "Dark Theme", Icons.nights_stay_outlined, context),
              buildListTile(context, "primary"),
              buildListTile(context, "accent"),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
