import 'package:flutter/material.dart';

import '../constrains.dart';
import '../home_controller.dart';
import 'temp_btn.dart';

class TempDetail extends StatelessWidget {
  const TempDetail({
    Key? key,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TempBtn(
                key: UniqueKey(),
                isActive: _homeController.isCoolSelected,
                press: () => _homeController.updateCoolSelectedTab(),
                svgSrc: 'assets/icons/coolShape.svg',
                title: 'cool',
                activeColor: primaryColor,
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              TempBtn(
                key: UniqueKey(),
                isActive: !_homeController.isCoolSelected,
                press: _homeController.updateCoolSelectedTab,
                svgSrc: 'assets/icons/heatShape.svg',
                title: 'Heat',
                activeColor: redColor,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: _homeController.upTemp,
                icon: const Icon(
                  Icons.arrow_drop_up,
                  size: 48,
                ),
              ),
               Text(
                '${_homeController.tempValue} ' '\u2103',
                style: const TextStyle(fontSize: 86),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: _homeController.downTemp,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 48,
                ),
              ),
            ],
          ),
          Text(
            'current temperature'.toUpperCase(),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          const Spacer(),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'inside'.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    '29 ' + '\u2103'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'outside'.toUpperCase(),
                    style: const TextStyle(color: Colors.white54),
                  ),
                  Text(
                    '35 ' + '\u2103'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
