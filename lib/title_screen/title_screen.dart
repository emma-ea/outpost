import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:outpost/assets.dart';
import 'package:outpost/styles.dart';
import 'package:outpost/title_screen/title_screen_ui.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();

}

class _TitleScreenState extends State<TitleScreen> {

  Color get _emitColor => AppColors.emitColors[
    _difficultOverride ?? _difficulty
  ];

  Color get _orbColor => AppColors.orbColors[
    _difficultOverride ?? _difficulty
  ];

  /// Currently selected difficulty
  int _difficulty = 0;

  /// Currently focused difficulty (if any)
  int? _difficultOverride = 0;

  void _handleDifficultyPressed(int value) {
    setState(() {
      _difficulty = value;
    });
  }

  void _handleDifficultyFocused(int? value) {
    setState(() {
      _difficultOverride = value;
    });
  }

  final _finalReceiveLightAmt = 0.7;
  final _finalEmitLightAmt = 0.5;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _AnimatedColors(
          orbColor: _orbColor,
          emitColor: _emitColor,
          builder: (_, orbColor, emitColor) {
            return Stack(
              children: [
                Image.asset(AssetPaths.titleBgBase),

                _LitImage(
                  color: orbColor, 
                  imgSrc: AssetPaths.titleBgReceive, 
                  lightAmt: _finalReceiveLightAmt,
                ),

                _LitImage(
                  color: orbColor, 
                  imgSrc: AssetPaths.titleMgBase,
                  lightAmt: _finalReceiveLightAmt,
                ),

                _LitImage(
                  color: orbColor, 
                  imgSrc: AssetPaths.titleMgReceive,
                  lightAmt: _finalReceiveLightAmt,
                ),

                _LitImage(
                  color: emitColor, 
                  imgSrc: AssetPaths.titleMgEmit,
                  lightAmt: _finalEmitLightAmt,
                ),

                Image.asset(AssetPaths.titleFgBase),

                _LitImage(
                  color: orbColor, 
                  imgSrc: AssetPaths.titleFgReceive,
                  lightAmt: _finalReceiveLightAmt,
                ),

                _LitImage(
                  color: emitColor, 
                  imgSrc: AssetPaths.titleFgEmit,
                  lightAmt: _finalEmitLightAmt,
                ),

                Positioned.fill(
                  child: TitleScreenUi(
                    difficulty: _difficulty,
                    onDifficultyPressed: _handleDifficultyPressed,
                    onDifficultyFocused: _handleDifficultyFocused,
                  ),
                ),

              ],
            ).animate().fadeIn(duration: 1.seconds, delay: 3.seconds);
          }
        ),
      ),
    );
  }
}

class _LitImage extends StatelessWidget {
  
  const _LitImage({
    required this.color,
    required this.imgSrc,
    required this.lightAmt,
  });

  final Color color;
  final String imgSrc;
  final double lightAmt;
  
  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(color);
    return Image.asset(
      imgSrc,
      color: hsl.withLightness(hsl.lightness * lightAmt).toColor(),
      colorBlendMode: BlendMode.modulate,
    );
  }

}

class _AnimatedColors extends StatelessWidget {
  const _AnimatedColors({
    super.key,
    required this.emitColor, 
    required this.orbColor, 
    required this.builder,
  });

  final Color emitColor;
  final Color orbColor;

  final Widget Function(
    BuildContext context, 
    Color orbColor, 
    Color emitColor
  ) builder;

  @override
  Widget build(BuildContext context) {
    final duration = .5.seconds;
    return TweenAnimationBuilder(
      tween: ColorTween(begin: emitColor, end: emitColor), 
      duration: duration, 
      builder: (_, emitColor, __) {
        return TweenAnimationBuilder(
          tween: ColorTween(begin: orbColor, end: orbColor), 
          duration: duration, 
          builder: (context, orbColor, __) {
            return builder(context, orbColor!, emitColor!);
          }
        );
      },
    );
  }
}
