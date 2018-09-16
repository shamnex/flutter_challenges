import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

class FadeInRoute<T> extends MaterialPageRoute<T> {
  FadeInRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }

    // timeDilation = 50.0;

    Animation opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: opacity,
      child: child,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.value,
          child: child,
        );
      },
    );
  }
}



class SlideLeftRoute<T> extends MaterialPageRoute<T> {
  SlideLeftRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

      

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    


    Animation opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.linear,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    Animation slideUp = Tween<double>(
      begin: 400.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Cubic(.06,1.21,.26,.68),
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve:Cubic(.06,1.21,.26,.68),
        ),
      ),
    );
  
    return AnimatedBuilder(
      animation: opacity,
      child: child,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform(
            transform: Matrix4.identity()..translate(slideUp.value),
            // child: child,
            child: child,
          ),
        );
      },
    );
  }
}

class SlideUpRoute<T> extends MaterialPageRoute<T> {
  SlideUpRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

      

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    


    Animation opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.linear,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    Animation slideUp = Tween<double>(
      begin: 400.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Cubic(.06,1.21,.26,.68),
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve:Cubic(.06,1.21,.26,.68),
        ),
      ),
    );
  
    return AnimatedBuilder(
      animation: opacity,
      child: child,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform(
            transform: Matrix4.identity()..translate(slideUp.value),
            // child: child,
            child: child,
          ),
        );
      },
    );
  }
}

class SlideDownRoute<T> extends MaterialPageRoute<T> {
  SlideDownRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }
    


    Animation opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.linear,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    Animation slideUp = Tween<double>(
      begin: 400.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Cubic(.06,1.21,.26,.68),
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve:Cubic(.06,1.21,.26,.68),
        ),
      ),
    );
  
    return AnimatedBuilder(
      animation: opacity,
      child: child,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform(
            transform: Matrix4.identity()..translate(0.0, -slideUp.value),
            // child: child,
            child: child,
          ),
        );
      },
    );
  }
}
