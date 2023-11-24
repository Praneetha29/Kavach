
import 'package:flutter/material.dart';

class CustomizedButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  const CustomizedButton({
    Key? key,
    this.buttonText,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.all(6.0),
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(width: 1, color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              buttonText!,
              style: TextStyle(
                color: textColor!,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
