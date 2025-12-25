import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
    final controller = Get.find<CalculateController>();
    final themeController = Get.find<ThemeController>();
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    return GetBuilder<ThemeController>(builder: (context) {
      return Scaffold(
        backgroundColor: themeController.isDark
            ? DarkColors.scaffoldBgColor
            : LightColors.scaffoldBgColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  // Output Section - Dynamic height
                  Expanded(
                    flex: isTablet ? 1 : 1,
                    child: GetBuilder<CalculateController>(builder: (context) {
                      return _buildOutputSection(
                        themeController,
                        controller,
                        constraints,
                        isTablet,
                      );
                    }),
                  ),
                  // Input Section - Takes remaining space
                  Expanded(
                    flex: isTablet ? 2 : 2,
                    child: _buildInputSection(
                      themeController,
                      controller,
                      constraints,
                      isTablet,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildOutputSection(
    ThemeController themeController,
    CalculateController controller,
    BoxConstraints constraints,
    bool isTablet,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isTablet ? 32 : 20,
        right: isTablet ? 32 : 20,
        top: isTablet ? 20 : 16,
        bottom: isTablet ? 16 : 12,
      ),
      child: Column(
        children: [
          // Theme Toggle Switch - Top right corner
          Align(
            alignment: Alignment.topRight,
            child: _buildThemeToggle(themeController, isTablet),
          ),

          // Spacer to push results to bottom
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: _buildResultsDisplay(
                themeController,
                controller,
                constraints,
                isTablet,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(ThemeController themeController, bool isTablet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            themeController.isDark
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
            color: themeController.isDark ? Colors.grey[400] : Colors.grey[600],
            size: isTablet ? 20 : 18,
          ),
          const SizedBox(width: 8),
          Transform.scale(
            scale: isTablet ? 0.9 : 0.8,
            child: CupertinoSwitch(
              value: themeController.switcherController.value,
              onChanged: (value) {
                themeController.switcherController.value = value;
              },
              activeTrackColor:
                  themeController.isDark ? Colors.blue[400] : Colors.blue[600],
              inactiveTrackColor:
                  themeController.isDark ? Colors.grey[700] : Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsDisplay(
    ThemeController themeController,
    CalculateController controller,
    BoxConstraints constraints,
    bool isTablet,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 20,
        vertical: isTablet ? 16 : 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // User Input Display
          if (controller.userInput.isNotEmpty)
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  controller.userInput,
                  style: GoogleFonts.ubuntu(
                    color: themeController.isDark
                        ? Colors.grey[400]
                        : Colors.grey[600],
                    fontSize: _getInputFontSize(
                      controller.userInput.length,
                      isTablet,
                    ),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),

          if (controller.userInput.isNotEmpty) SizedBox(height: 8),

          // User Output Display
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                controller.userOutput.isEmpty ? "0" : controller.userOutput,
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w300,
                  color: themeController.isDark ? Colors.white : Colors.black87,
                  fontSize: _getOutputFontSize(
                    controller.userOutput.length,
                    isTablet,
                  ),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection(
    ThemeController themeController,
    CalculateController controller,
    BoxConstraints constraints,
    bool isTablet,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isTablet ? 20 : 12,
        isTablet ? 16 : 12,
        isTablet ? 20 : 12,
        isTablet ? 24 : 16,
      ),
      decoration: BoxDecoration(
        color: themeController.isDark
            ? DarkColors.sheetBgColor
            : LightColors.sheetBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, buttonConstraints) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: buttons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: isTablet ? 16 : 8,
              mainAxisSpacing: isTablet ? 16 : 8,
              childAspectRatio:
                  _getButtonAspectRatio(buttonConstraints, isTablet),
            ),
            itemBuilder: (context, index) {
              return _buildCalculatorButton(
                themeController,
                controller,
                index,
                isTablet,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCalculatorButton(
    ThemeController themeController,
    CalculateController controller,
    int index,
    bool isTablet,
  ) {
    Color buttonColor;
    Color textColor;

    switch (index) {
      case 0: // Clear
      case 1: // Delete
      case 19: // Equals
        buttonColor = themeController.isDark
            ? DarkColors.leftOperatorColor
            : LightColors.leftOperatorColor;
        textColor = themeController.isDark
            ? DarkColors.btnBgColor
            : LightColors.btnBgColor;
        break;
      default:
        if (isOperator(buttons[index])) {
          buttonColor = LightColors.operatorColor;
          textColor = Colors.white;
        } else {
          buttonColor = themeController.isDark
              ? DarkColors.btnBgColor
              : LightColors.btnBgColor;
          textColor = themeController.isDark ? Colors.white : Colors.black87;
        }
    }

    return CustomAppButton(
      buttonTapped: () => _handleButtonTap(controller, index),
      color: buttonColor,
      textColor: textColor,
      text: buttons[index],
    );
  }

  void _handleButtonTap(CalculateController controller, int index) {
    switch (index) {
      case 0: // Clear
        controller.clearInputAndOutput();
        break;
      case 1: // Delete
        controller.deleteBtnAction();
        break;
      case 19: // Equal
        controller.equalPressed();
        break;
      default:
        controller.onBtnTapped(buttons, index);
    }
  }

  double _getInputFontSize(int textLength, bool isTablet) {
    if (isTablet) {
      if (textLength > 20) return 24;
      if (textLength > 15) return 28;
      if (textLength > 10) return 32;
      return 36;
    } else {
      if (textLength > 15) return 20;
      if (textLength > 10) return 24;
      if (textLength > 8) return 28;
      return 32;
    }
  }

  double _getOutputFontSize(int textLength, bool isTablet) {
    if (isTablet) {
      if (textLength > 12) return 36;
      if (textLength > 8) return 42;
      if (textLength > 6) return 48;
      return 54;
    } else {
      if (textLength > 10) return 32;
      if (textLength > 8) return 36;
      if (textLength > 6) return 42;
      return 48;
    }
  }

  double _getButtonAspectRatio(BoxConstraints constraints, bool isTablet) {
    // Calculate optimal aspect ratio based on available space
    final availableHeight = constraints.maxHeight - 32; // Account for padding
    final availableWidth = constraints.maxWidth - 32; // Account for padding

    // Calculate button dimensions for 5 rows and 4 columns
    final buttonHeight =
        (availableHeight - (4 * (isTablet ? 16 : 8))) / 5; // 5 rows
    final buttonWidth =
        (availableWidth - (3 * (isTablet ? 16 : 8))) / 4; // 4 columns

    return buttonWidth / buttonHeight;
  }

  bool isOperator(String y) {
    return y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=";
  }
}
