import '../brand_colors.dart';
import '../dataprovider.dart';
import '../globalvaribles.dart';
import '../screens/mainpage.dart';
import '../widgets/BrandDivier.dart';
import '../widgets/HistoryTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  static const String id = 'history';
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit Pet Ambulance'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, MainPage.id, (route) => false);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Treatment History'),
            backgroundColor: Colors.green,
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, MainPage.id, (route) => false);
              },
              icon: Icon(Icons.keyboard_arrow_left),
            ),
          ),
          body: Provider.of<AppData>(context).treatmentHistory.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return HistoryTile(
                      history:
                          Provider.of<AppData>(context).treatmentHistory[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      BrandDivider(),
                  itemCount:
                      Provider.of<AppData>(context).treatmentHistory.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                )
              : Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // '${Provider.of<AppData>(context).treatmentHistory}',
                            // "${currentDoctorInfo.fullName}",
                            "",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.green),
                          ),
                          Text(
                            // '${Provider.of<AppData>(context).treatmentHistory}',
                            "You have not made any treatment",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.green),
                          ),
                          Text(
                            // '${Provider.of<AppData>(context).treatmentHistory}',
                            "",
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
