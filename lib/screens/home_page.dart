import 'package:floating_action_button_animation/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  late Animation rotationAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
    degOneTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 75),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 25)
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.4), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 45)
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.75), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 1.75, end: 1.0), weight: 65)
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void tapped() {
    print('clicked');
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  double getRadiansFromDegree(double degree) {
    double unitRad = 57.295779513;
    return degree / unitRad;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  IgnorePointer(
                    child: Container(
                      color: Colors.transparent,
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(270),
                        degOneTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degOneTranslationAnimation.value),
                      child: CircularButton(
                        width: 50,
                        height: 50,
                        color: Colors.blue,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        callback: () {},
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(225),
                        degTwoTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degTwoTranslationAnimation.value),
                      child: CircularButton(
                        width: 50,
                        height: 50,
                        color: Colors.purple,
                        icon: const Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                        callback: () {},
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(180),
                        degThreeTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degThreeTranslationAnimation.value),
                      child: CircularButton(
                        width: 50,
                        height: 50,
                        color: Colors.green[400]!,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        callback: () {},
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value)),
                    alignment: Alignment.center,
                    child: CircularButton(
                      width: 50,
                      height: 50,
                      color: Colors.indigo[800]!,
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      callback: tapped,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
