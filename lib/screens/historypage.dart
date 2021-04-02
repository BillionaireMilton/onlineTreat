import 'package:cab_driver/brand_colors.dart';
import 'package:cab_driver/dataprovider.dart';
import 'package:cab_driver/globalvaribles.dart';
import 'package:cab_driver/screens/mainpage.dart';
import 'package:cab_driver/widgets/BrandDivier.dart';
import 'package:cab_driver/widgets/HistoryTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  static const String id = 'history';
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Provider.of<AppData>(context).tripHistory.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return HistoryTile(
                    history: Provider.of<AppData>(context).tripHistory[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    BrandDivider(),
                itemCount: Provider.of<AppData>(context).tripHistory.length,
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
                          // '${Provider.of<AppData>(context).tripHistory}',
                          "${currentDoctorInfo.fullName}",
                          style: TextStyle(fontSize: 25.0, color: Colors.green),
                        ),
                        Text(
                          // '${Provider.of<AppData>(context).tripHistory}',
                          "You have not made any treatment",
                          style: TextStyle(fontSize: 25.0, color: Colors.green),
                        ),
                        Text(
                          // '${Provider.of<AppData>(context).tripHistory}',
                          "Welcome to Pet Ambulance ",
                          style: TextStyle(fontSize: 25.0, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
