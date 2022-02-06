import 'package:cashrich_app/services/percent_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class CircularPercentWidget extends StatelessWidget {
  final Color orange = Color(0xFFfd9840);
  final Color blue = Color(0xFF409efd);
  @override
  Widget build(BuildContext context) {
    return Consumer<PercentProvider>(
      builder: (context, provider, child) => CircularPercentIndicator(
        radius: 100.0,
        lineWidth: 30.0,
        percent: provider.shareValue / 100,
        center: Wrap(
          spacing: 10.0,
          children: [
            Column(
              children: [
                TweenAnimationBuilder(
                  duration: const Duration(
                    seconds: 1,
                  ),
                  tween: IntTween(
                    begin: 0,
                    end: provider.shareValue,
                  ),
                  builder: (context, value, child) => Text(
                    '$value %',
                    // provider.shareValue.toString() + "%",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  "Share value",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 1),
                  tween: IntTween(
                    begin: 0,
                    end: provider.fixedValue,
                  ),
                  builder: (context, value, child) => Text(
                    '$value %',
                    // provider.fixedValue.toString() + "%",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  "Fixed value",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        progressColor: blue,
        backgroundColor: orange,
        animateFromLastPercent: true,
        animationDuration: 500,
        animation: true,
        circularStrokeCap: CircularStrokeCap.butt,
        // linearGradient: LinearGradient(
        //   colors: [
        //     Color(0xffee0000),
        //     Color(0xffeeee00),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
    );
  }
}
