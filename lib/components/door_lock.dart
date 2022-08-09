import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constrains.dart';
import '../home_controller.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required HomeController homeController,
    required this.press,
    required this.isLock,
  }) : super(key: key);

  final VoidCallback press;
  final bool isLock;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      onLongPress: press,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animaition) {
          return ScaleTransition(
            scale: animaition,
            child: child,
          );
        },
        child: isLock
            ? SvgPicture.asset('assets/icons/door_lock.svg',
                key: const ValueKey('lock'))
            : SvgPicture.asset('assets/icons/door_unlock.svg',
                key: const ValueKey('un lock')),
      ),
    );
  }
}
