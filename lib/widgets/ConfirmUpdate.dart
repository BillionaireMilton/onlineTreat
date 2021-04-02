import 'package:cab_driver/brand_colors.dart';
import 'package:cab_driver/widgets/TaxiButton.dart';
import 'package:cab_driver/widgets/TaxiOutlineButton.dart';
import 'package:flutter/material.dart';

class ConfirmUpdate extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onPressed;

  ConfirmUpdate({this.title, this.subtitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 15.0, //soften the shadow
                spreadRadius: 0.5, //extend the shadow
                offset: Offset(
                  0.7, //move to right 10 horizontally
                  0.7, //move to bottom 10 vertically
                ))
          ],
        ),
        height: 220,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Brand-Bold',
                    color: BrandColors.colorText),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: BrandColors.colorTextLight),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: TaxiButton(
                        title: 'BACK',
                        color: Colors.pink[900],
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Container(
                    child: TaxiButton(
                      onPressed: onPressed,
                      color: Colors.green,
                      title: 'CONFIRM',
                    ),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}
