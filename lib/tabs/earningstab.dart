import '../brand_colors.dart';
import '../datamodels/history.dart';
import '../dataprovider.dart';
import '../screens/historypage.dart';
import '../widgets/BrandDivier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EarningTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: BrandColors.colorPrimary,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 70),
            child: Column(
              children: [
                Text(
                  'Total Earning',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '\₹${Provider.of<AppData>(context).earnings}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Brand-Bold'),
                )
              ],
            ),
          ),
        ),
        FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HistoryPage()));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            child: Row(
              children: [
                Image.asset(
                  'images/ambl.png',
                  width: 70,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Treatments',
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                    child: Container(
                  child: Text(
                    Provider.of<AppData>(context).treatmentCount.toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 18),
                  ),
                ))
              ],
            ),
          ),
        ),
        BrandDivider(),
      ],
    );
  }
}
