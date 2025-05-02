import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Aplicativos extends StatefulWidget {
  const Aplicativos({super.key});

  @override
  State<Aplicativos> createState() => _AplicativosState();
}

class _AplicativosState extends State<Aplicativos>
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
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Container(
          // color: Colors.green,
          height: 910.sp,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 780.sp,
                  child: VisibilityDetector(
                    key: Key('1234'),
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
                    child: Text(
                      'Confira quais os aplicativos disponíveis para a personalização do seu plano:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF13294E),
                        letterSpacing: -2.50.sp,
                        height: 0.90,
                      ),
                    ),
                  )),
              SizedBox(
                height: 50.sp,
              ),
              Center(
                child: Container(
                  // color: Colors.amber,
                  height: 400.sp,
                  width: 600.sp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _Container(
                            controller: _controller,
                            imagem: 'lib/assets/images/globoplayApp.png',
                            posicao: -1205,
                            delay: 0400,
                          ),
                          _Container(
                            controller: _controller,
                            imagem: 'lib/assets/images/premiereApp.png',
                            posicao: -1205,
                            delay: 0200,
                          ),
                          _Container(
                            controller: _controller,
                            imagem: 'lib/assets/images/telecineApp.png',
                            posicao: -1205,
                            delay: 0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _Container(
                            controller: _controller,
                            imagem: 'lib/assets/images/globoplayPlusCanais.png',
                            posicao: 1205,
                            delay: 400,
                          ),
                          _Container(
                            controller: _controller,
                            imagem: 'lib/assets/images/maxApp.png',
                            posicao: 1205,
                            delay: 800,
                          ),
                          _Container(
                            controller: _controller,
                            imagem: 'lib/assets/images/deezerApp.png',
                            posicao: 1205,
                            delay: 1200,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45.sp,
              ),
              SizedBox(
                width: 430.sp,
                child: Text(
                  'Ver mais sobre os apps\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4892D6),
                    fontSize: 35.sp,
                    fontFamily: 'EutoStile',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1.75.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Container extends StatefulWidget {
  final String imagem;
  final double posicao;
  final int delay;
  late AnimationController controller;
  _Container(
      {super.key,
      required this.controller,
      required this.delay,
      required this.posicao,
      required this.imagem});

  @override
  State<_Container> createState() => __ContainerState();
}

class __ContainerState extends State<_Container> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.sp,
      height: 190.sp,
      decoration: ShapeDecoration(
        image: DecorationImage(image: AssetImage(widget.imagem)),
        // color: Color(0xFF13294E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
    )
        .animate(autoPlay: false, controller: widget.controller)
        .moveX(
            delay: Duration(milliseconds: widget.delay),
            begin: widget.posicao,
            end: 0,
            curve: FlippedCurve(Easing.emphasizedAccelerate),
            duration: Duration(milliseconds: 1500))
        .fadeIn(
            begin: 0,
            delay: Duration(milliseconds: widget.delay),
            duration: Duration(milliseconds: 1000));
  }
}
