import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/home.dart';
import 'package:noteapp/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class setting extends StatefulWidget
{
  @override
  State<setting> createState()=>settingState();
}
class settingState extends State<setting>
{
  Future<void> setvalue(bool value) async{
    var prefs=await SharedPreferences.getInstance();

    prefs.setBool("mode",value);

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
          body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text("Dark Mode"),
              subtitle: Text("Click here to change ThemeMode of this Application"),
              trailing: Switch.adaptive(value:Provider.of<themeProvider>(context).getThemeMode()
                  , onChanged:(value)
                  async{
                    setState(() {
                      Provider.of<themeProvider>(context,listen: false).updateTheme(value: value);

                    });
                    await setvalue(value);
                  }),
            ),
          )
        ],
    ),
    );
  }
}