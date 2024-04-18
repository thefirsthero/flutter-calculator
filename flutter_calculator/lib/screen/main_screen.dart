import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import Cupertino library
import 'package:flutter_calculator/controller/calculate_controller.dart';
import 'package:flutter_calculator/controller/theme_controller.dart';
import 'package:flutter_calculator/utils/colors.dart';
import 'package:flutter_calculator/widget/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CalculateController>();
    var themeController = Get.find<ThemeController>();

    return GetBuilder<ThemeController>(builder: (context) {
      return Scaffold(
        backgroundColor: themeController.isDark
            ? DarkColors.scaffoldBgColor
            : LightColors.scaffoldBgColor,
        body: Column(
          children: [
            GetBuilder<CalculateController>(builder: (context) {
              return outPutSection(themeController, controller);
            }),
            inPutSection(themeController, controller),
          ],
        ),
      );
    });
  }

  Widget inPutSection(
      ThemeController themeController, CalculateController controller) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: themeController.isDark
            ? DarkColors.sheetBgColor
            : LightColors.sheetBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: buttons.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          switch (index) {
            /// CLEAR BTN
            case 0:
              return CustomAppButton(
                buttonTapped: () {
                  controller.clearInputAndOutput();
                },
                color: themeController.isDark
                    ? DarkColors.leftOperatorColor
                    : LightColors.leftOperatorColor,
                textColor: themeController.isDark
                    ? DarkColors.btnBgColor
                    : LightColors.btnBgColor,
                text: buttons[index],
              );

            /// DELETE BTN
            case 1:
              return CustomAppButton(
                buttonTapped: () {
                  controller.deleteBtnAction();
                },
                color: themeController.isDark
                    ? DarkColors.leftOperatorColor
                    : LightColors.leftOperatorColor,
                textColor: themeController.isDark
                    ? DarkColors.btnBgColor
                    : LightColors.btnBgColor,
                text: buttons[index],
              );

            /// EQUAL BTN
            case 19:
              return CustomAppButton(
                buttonTapped: () {
                  controller.equalPressed();
                },
                color: themeController.isDark
                    ? DarkColors.leftOperatorColor
                    : LightColors.leftOperatorColor,
                textColor: themeController.isDark
                    ? DarkColors.btnBgColor
                    : LightColors.btnBgColor,
                text: buttons[index],
              );

            default:
              return CustomAppButton(
                buttonTapped: () {
                  controller.onBtnTapped(buttons, index);
                },
                color: isOperator(buttons[index])
                    ? LightColors.operatorColor
                    : themeController.isDark
                        ? DarkColors.btnBgColor
                        : LightColors.btnBgColor,
                textColor: isOperator(buttons[index])
                    ? Colors.white
                    : themeController.isDark
                        ? Colors.white
                        : Colors.black,
                text: buttons[index],
              );
          }
        },
      ),
    );
  }

  Widget outPutSection(
      ThemeController themeController, CalculateController controller) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Modern day-night switch using CupertinoSwitch
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: SwitchListTile(
            title: Text(
              themeController.isDark ? 'Night' : 'Day',
              style:
                  GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
            activeTrackColor: Colors.green.withOpacity(0.5),
            inactiveTrackColor: Colors.grey.withOpacity(0.5),
            secondary: Icon(
              themeController.isDark ? Icons.nightlight_round : Icons.wb_sunny,
              color: themeController.isDark ? Colors.yellow : Colors.orange,
            ),
            value: themeController.switcherController.value,
            onChanged: (value) {
              themeController.switcherController.value = value;
            },
          ),
        ),

        /// Main Result - user input and output
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 70),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  controller.userInput,
                  style: GoogleFonts.ubuntu(
                      color:
                          themeController.isDark ? Colors.white : Colors.black,
                      fontSize: 38),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  controller.userOutput,
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    color: themeController.isDark ? Colors.white : Colors.black,
                    fontSize: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  /// is Operator Check
  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=") {
      return true;
    }
    return false;
  }
}
