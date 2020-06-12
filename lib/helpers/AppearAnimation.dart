import 'dart:async';

import 'package:flutter/cupertino.dart';

class AppearAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  AppearAnimation({@required this.child, this.delay});

  @override
  State<StatefulWidget> createState() {
    return _AppearState();
  }
}

class _AppearState extends State<AppearAnimation>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animationController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

  if(widget.delay == null){
    _animationController.forward();
  }else {
    Timer(Duration (milliseconds: widget.delay),(){
      _animationController.forward();
    });
  }

  }

  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animationController,
    );
  }
}
