import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faizan_tentwenty_assignment/contracts/i_button_clicked.dart';
import 'package:faizan_tentwenty_assignment/enums/button_type.dart';
import 'package:faizan_tentwenty_assignment/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static void showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );
  }

  static push(context, object) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => object),
    );
  }

  static pushReplacement(context, object) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => object),
    );
  }

  static double getScreenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static loadingContainer(context) {
    return Container(
      width: Utils.getScreenWidth(context),
      height: Utils.getScreenHeight(context),
      color: Colors.black12,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  static errorBody(String error) {
    return Center(
      child: Text(
        error,
      ),
    );
  }

  static getOutlinedButton(
    String label,
    IButtonClicked iButtonClicked,
    ButtonType buttonType, {
    double radius = 0.0,
    Color color = Colors.lightBlueAccent,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              iButtonClicked.onButtonClicked(buttonType);
            },
            child: Text(
              label,
              style: TextStyle(
                color: color,
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                  side: BorderSide(
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget getAdultLabel({required bool adult}) {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: adult ? Colors.red : Colors.green,
          width: 1.5,
        ),
      ),
      child: Text(
        adult ? 'Adult' : 'Non Adult',
        style: TextStyle(
          color: adult ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  static Widget getOutlineBox(String label) {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
      margin: EdgeInsets.only(right: 4, top: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  static Widget getSantamHeaderCarousal(List scrollerItems) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1.0,
      ),
      items: scrollerItems.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return CachedNetworkImage(
              imageUrl: '$BASE_POSTER_IMAGE_URL/$imagePath',
              width: Utils.getScreenWidth(context),
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  JumpingDotsProgressIndicator(
                fontSize: 32.0,
                color: Colors.blue,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  static Future<bool> booked(int id) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getInt(id.toString()) != null;
  }
}
