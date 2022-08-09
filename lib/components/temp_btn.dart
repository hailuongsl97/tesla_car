import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constrains.dart';

class TempBtn extends StatelessWidget {
  const TempBtn({
    Key? key,
    this.isActive = false,
    required this.press,
    required this.svgSrc,
    required this.title,
    this.activeColor = primaryColor,
  }) : super(key: key);
  final String svgSrc, title;
  final bool isActive;
  final VoidCallback press;
  final Color activeColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AnimatedContainer(
            duration: defaultDuration * 0.75,
            curve: Curves.easeInOutBack,
            height: isActive ? 76 : 50,
            width: isActive ? 76 : 50,
            child: SvgPicture.asset(
              svgSrc,
              color: isActive ? activeColor : Colors.white38,
            ),
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          AnimatedDefaultTextStyle(
            style: TextStyle(
              fontSize: 16,
              color: isActive ? activeColor : Colors.white38,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            duration: defaultDuration * 0.75,
            curve: Curves.easeInOutBack,
            child: Text(
              title.toUpperCase(),
            ),
          )
        ],
      ),
    );
  }
}
