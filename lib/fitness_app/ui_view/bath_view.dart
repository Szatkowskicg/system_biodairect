import 'package:system_biodairect/main.dart';
import 'package:flutter/material.dart';
import '../fitness_app_theme.dart';

class BathView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const BathView({Key? key, this.animationController, this.animation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 0, bottom: 24),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48.0),
                            bottomLeft: Radius.circular(48.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.grey.withOpacity(0.2),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                                  child: SizedBox(),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Kąpiel lhotse',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Row(
                                    children: const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 4),
                                        child: Icon(
                                          Icons.timer,
                                          color: FitnessAppTheme.etap1,
                                          size: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          '2 Dni temu',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FitnessAppTheme.etap1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    left: 12,
                    child: SizedBox(
                      height: 100,
                      width: 80,
                      child: Image.asset("assets/fitness_app/bath.png"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}