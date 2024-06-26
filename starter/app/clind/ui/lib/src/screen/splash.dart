import 'package:flutter/material.dart';
import 'package:tool_clind_component/component.dart';
import 'package:tool_clind_theme/gen/gen.dart';
import 'package:tool_clind_theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  static Future<void> show(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
      barrierColor: Colors.transparent,
      transitionDuration: Duration.zero,
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<double> _opacityNotifier = ValueNotifier<double>(1.0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hideAfterDelay(const Duration(seconds: 2));
    });
    super.initState();
  }

  @override
  void dispose() {
    _opacityNotifier.dispose();
    super.dispose();
  }

  Future<void> _hideAfterDelay(Duration delay) async {
    await Future.delayed(delay);
    _updateOpacity(0.0);
  }

  void _updateOpacity(double value) {
    if (_opacityNotifier.value == value) return;
    _opacityNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _opacityNotifier,
      builder: (context, value, child) => AnimatedOpacity(
        opacity: value,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        onEnd: () {
          if (value == 0.0) {
            Navigator.of(context).pop();
          }
        },
        child: child,
      ),
      child: Scaffold(
        backgroundColor: ColorName.splashBackground,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClindIcon.logo(
                size: 46.0,
              ),
              const SizedBox(
                height: 14.0,
              ),
              Text(
                'Clind',
                style: context.textTheme.poppins18Bold.copyWith(
                  fontSize: 24.0,
                  height: 24.0 / 24.0,
                  color: ColorName.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
