import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_car/constrains.dart';

import '../components/battery_status.dart';
import '../components/door_lock.dart';
import '../components/temp_details.dart';
import '../components/tesla_bottom_navigationbar.dart';
import '../home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _homeController = HomeController();

  late AnimationController _batteryAnimationController;

  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  void _setupBatteryAnimation() {
    _batteryAnimationController =
        AnimationController(vsync: this, duration: defaultDuration * 2);
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,

      // Here the animation end on 0.5
      // it ends on 300 miliseconds [total duration is 600]
      curve: const Interval(0.0, 1),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      // after delay 0.6*defaultDuration we start this animation
      // end on 600 milliseconds
      curve: const Interval(0.6, 1),
    );
  }

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationTempCoolGlow;
  void _setupTempAnimation() {
    _tempAnimationController =
        AnimationController(vsync: this, duration: defaultDuration * 5);
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );
    _animationTempCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  @override
  void initState() {
    super.initState();
    _setupBatteryAnimation();
    _setupTempAnimation();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _homeController,
          _animationBattery,
          _animationBatteryStatus,
          _animationCarShift,
          _animationTempShowInfo,
          _animationTempCoolGlow,
        ]),
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavigationBar(
                onTap: (index) {
                  if (index == 1) {
                    _batteryAnimationController.forward();
                  } else if (_homeController.selectBottomTab == 1 &&
                      index != 1) {
                    _batteryAnimationController.reverse(from: 0.7);
                  }
                  if (index == 2) {
                    _tempAnimationController.forward();
                  } else if (_homeController.selectBottomTab == 2 &&
                      index != 2) {
                    _tempAnimationController.reverse(from: 0.4);
                  }
                  _homeController.onBottomNavigationTabChange(index);
                },
                selectedTab: _homeController.selectBottomTab),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constrain) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: constrain.maxHeight,
                      width: constrain.maxWidth,
                    ),
                    Positioned(
                      left: constrain.maxWidth / 2 * _animationCarShift.value,
                      height: constrain.maxHeight,
                      width: constrain.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrain.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _homeController.selectBottomTab == 0
                          ? constrain.maxWidth * 0.05
                          : constrain.maxWidth * 0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _homeController.selectBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          homeController: _homeController,
                          isLock: _homeController.isRightDoorLock,
                          press: _homeController.updateRightDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _homeController.selectBottomTab == 0
                          ? constrain.maxWidth * 0.05
                          : constrain.maxWidth * 0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _homeController.selectBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          homeController: _homeController,
                          isLock: _homeController.isLeftDoorLock,
                          press: _homeController.updateleftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _homeController.selectBottomTab == 0
                          ? constrain.maxHeight * 0.17
                          : constrain.maxHeight * 0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _homeController.selectBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          homeController: _homeController,
                          isLock: _homeController.isBottomDoorLock,
                          press: _homeController.updateBottomDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _homeController.selectBottomTab == 0
                          ? constrain.maxHeight * 0.13
                          : constrain.maxHeight * 0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _homeController.selectBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          homeController: _homeController,
                          isLock: _homeController.isTopDoorLock,
                          press: _homeController.updateTopDoorLock,
                        ),
                      ),
                    ),
                    // Battery
                    Positioned(
                      height: constrain.maxHeight,
                      width: constrain.maxWidth * 0.4,
                      top: 1500 * (1 - _animationBattery.value),
                      child: Opacity(
                        opacity: _animationBattery.value,
                        child: SvgPicture.asset(
                          'assets/icons/Battery.svg',
                          width: constrain.maxWidth * 0.4,
                        ),
                      ),
                    ),
                    Positioned(
                      // animation value start at 0 and end on 1 * 50
                      top: 150 * (1 - _animationBatteryStatus.value),
                      height: constrain.maxHeight,
                      width: constrain.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(
                          constrain: constrain,
                        ),
                      ),
                    ),
                    // Temp
                    Positioned(
                      height: constrain.maxHeight,
                      width: constrain.maxWidth,
                      top: 60 * (1 - _animationTempShowInfo.value),
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetail(homeController: _homeController),
                      ),
                    ),
                    Positioned(
                      right: -180 * (1 - _animationTempCoolGlow.value),
                      child: Visibility(
                        visible: _animationTempCoolGlow.value > 0,
                        child: Opacity(
                          opacity: _animationTempCoolGlow.value,
                          child: AnimatedSwitcher(
                            duration: defaultDuration,
                            child: _homeController.isCoolSelected
                                ? Image.asset(
                                    'assets/images/Cool_glow_2.png',
                                    key: UniqueKey(),
                                  )
                                : Image.asset(
                                    'assets/images/Hot_glow_4.png',
                                    key: UniqueKey(),
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        });
  }
}
