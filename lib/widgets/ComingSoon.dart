import 'package:cab_driver/brand_colors.dart';
import 'package:cab_driver/screens/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:cab_driver/widgets/TaxiOutlineButton.dart';
import 'package:cab_driver/widgets/TaxiButton.dart';

class ComingSoonDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Coming Soon',
                  style: TextStyle(fontSize: 22.0, fontFamily: 'Brand-Bold'),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'This feature is still being developed!',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 200,
                  child: TaxiOutlineButton(
                    title: 'HOME PAGE',
                    color: BrandColors.colorLightGrayFair,
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, MainPage.id, (route) => false);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
