import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocitynet/telecine.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ConexaoFibra extends StatefulWidget {
  const ConexaoFibra({super.key});

  @override
  State<ConexaoFibra> createState() => _ConexaoFibraState();
}

class _ConexaoFibraState extends State<ConexaoFibra>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _hasFlipped1 = false;

  @override
  bool get wantKeepAlive => true; // Isso mantém o estado do widget.

  @override
  void initState() {
    super.initState();
    // Inicializa o controller de animação
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera o controller de animação
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return Container(
          height: 820.sp,
          width: 1920.sp,
          // color: Colors.amber,
          child: Center(
            child: VisibilityDetector(
              key: Key('123'),
              onVisibilityChanged: (visibilityInfo) {
                if (visibilityInfo.visibleFraction > 0.2) {
                  Future.delayed(Duration(milliseconds: 0), () {
                    if (!_hasFlipped1) {
                      Future.delayed(Duration(milliseconds: 200), () {
                        _controller.forward();
                        setState(() {
                          _hasFlipped1 = true; // Marcar como já flipado
                        });
                      });
                    }
                  });
                }
              },
              child: Container(
                // color: Colors.green,
                height: 475.sp,
                width: 1200.sp,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      containers(
                        controller: _controller,
                        delay: 1000,
                        posicaoInicia: 420.sp,
                        icone: PhosphorIcons.game_controller_fill,
                        titulo: "A conexão que mais contibui para diversão",
                        text:
                            'A melhor internet para quem curte um game, filme, série e muito mais do entretenimento!',
                      ),
                      containers(
                        controller: _controller,
                        delay: 800,
                        posicaoInicia: 0,
                        icone: Icons.rocket_launch,
                        text:
                            'Uma velocidade sem igual que só a Velocitynet garante para você!',
                        titulo: 'Conectando você em velocidade máxima',
                      ),
                      containers(
                        controller: _controller,
                        delay: 1000,
                        posicaoInicia: -420.sp,
                        icone: PhosphorIcons.cpu_fill,
                        text:
                            'Equipamentos de qualidade para uma internet com ainda mais qualidade!',
                        titulo: 'O melhor da tecnologia na sua casa!',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class containers extends StatefulWidget {
  final String titulo;
  final String text;
  final IconData icone;
  final double posicaoInicia;
  final int delay;
  late AnimationController controller;

  containers({
    super.key,
    required this.controller,
    required this.delay,
    required this.icone,
    required this.text,
    required this.titulo,
    required this.posicaoInicia,
  });

  @override
  State<containers> createState() => _containersState();
}

class _containersState extends State<containers>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Isso mantém o estado do widget.

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
          angle: 45 * 3.14159 / 180,
          child: Container(
            width: 150.sp,
            height: 150.sp,
            decoration: ShapeDecoration(
              color: Color(0xff002450),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.sp),
              ),
            ),
            child: Transform.rotate(
              angle: -45 * 3.14159 / 180,
              child: Center(
                child: Icon(
                  widget.icone,
                  size: 70.sp,
                  color: Color(0xffFFB000),
                ),
              ),
            ),
          ),
        ).animate(autoPlay: false, controller: widget.controller).moveX(
            curve: Split(BlurEffect.minBlur),
            begin: widget.posicaoInicia,
            duration: Duration(milliseconds: 1500),
            end: 0),
        SizedBox(
          height: 40.sp,
        ),
        SizedBox(
          width: 350.sp,
          child: Text(
            textAlign: TextAlign.center,
            widget.titulo,
            style: TextStyle(
              height: 0.92,
              fontSize: 33.sp,
              fontFamily: 'EutoStile',
              fontWeight: FontWeight.w700,
              color: Color(0xFF002450),
            ),
          ).animate(autoPlay: false, controller: widget.controller).fadeIn(
                begin: 0,
                delay: Duration(milliseconds: widget.delay),
                duration: Duration(milliseconds: 1000),
              ),
        ),
        SizedBox(
          height: 15.sp,
        ),
        SizedBox(
          width: 370.sp,
          child: Text(
            textAlign: TextAlign.center,
            widget.text,
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: 'EutoStile',
              fontWeight: FontWeight.w200,
              height: 0.92,
              color: Color(0xFF5B5B5B),
            ),
          ).animate(autoPlay: false, controller: widget.controller).fadeIn(
                begin: 0,
                delay: Duration(milliseconds: widget.delay),
                duration: Duration(milliseconds: 1000),
              ),
        ),
      ],
    );
  }
}
