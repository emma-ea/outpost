import 'package:flutter/material.dart';
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

  int _difficulty = 0;
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
        child: Stack(
          children: [
            Image.asset(AssetPaths.titleBgBase),

            _LitImage(
              color: _orbColor, 
              imgSrc: AssetPaths.titleBgReceive, 
              lightAmt: _finalReceiveLightAmt,
            ),

            _LitImage(
              color: _orbColor, 
              imgSrc: AssetPaths.titleMgBase,
              lightAmt: _finalReceiveLightAmt,
            ),

            _LitImage(
              color: _orbColor, 
              imgSrc: AssetPaths.titleMgReceive,
              lightAmt: _finalReceiveLightAmt,
            ),

            _LitImage(
              color: _emitColor, 
              imgSrc: AssetPaths.titleMgEmit,
              lightAmt: _finalEmitLightAmt,
            ),

            Image.asset(AssetPaths.titleFgBase),

            _LitImage(
              color: _orbColor, 
              imgSrc: AssetPaths.titleFgReceive,
              lightAmt: _finalReceiveLightAmt,
            ),

            _LitImage(
              color: _emitColor, 
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
