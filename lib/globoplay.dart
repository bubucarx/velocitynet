import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Globoplay extends StatefulWidget {
  const Globoplay({super.key});

  @override
  State<Globoplay> createState() => _GloboplayState();
}

class _GloboplayState extends State<Globoplay>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Isso mantém o estado do widget.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1920, 1080),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return Container(
            child: Column(
              children: [
                Container(
                  width: 645.sp,
                  height: 140.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "lib/assets/images/globoplay/Globoplay.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.sp,
                ),
                SizedBox(
                  width: 1040.sp,
                  child: Text(
                    'Globoplay é a plataforma digital de vídeos da Globo. No Globoplay, você encontra séries originais e exclusivas, filmes, documentários, conteúdos infantis, novelas e programas além do sinal ao vivo da TV Globo e do Canal Futura. O acesso é pela internet e pode ser realizado por computador, celular, tablet, Smart TV, Apple TV, Android TV, Chromecast e Roku.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF13294E),
                      fontSize: 20.sp,
                      fontFamily: 'EutoStile',
                      fontWeight: FontWeight.w600,
                      height: 0.95,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 315.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _container1(
                        WidthContainer: 241.32.sp,
                        PositionedWidth: 69.23.sp,
                        FotoFilme: 'lib/assets/images/globoplay/ojogo.jpg',
                        NomeFilme: 'O JOGO QUE\nMUDOU A HISTÓRIA',
                        Numero: '1',
                        delay: 0,
                      ),
                      _container1(
                        NomeFilme: 'OS PARÇAS',
                        FotoFilme: 'lib/assets/images/globoplay/osparcas.jpg',
                        Numero: '2',
                        PositionedWidth: 122.55.sp,
                        WidthContainer: 295.sp,
                        delay: 0500,
                      ),
                      _container1(
                        NomeFilme: 'THE GOOD\nDOCTOR',
                        FotoFilme:
                            'lib/assets/images/globoplay/thegooddoctor.jpg',
                        Numero: '3',
                        PositionedWidth: 122.55.sp,
                        WidthContainer: 295.sp,
                        delay: 1000,
                      ),
                      _container1(
                        NomeFilme: 'ARCANJO\nRENEGADO',
                        FotoFilme:
                            'lib/assets/images/globoplay/arcanjorenegado.jpg',
                        Numero: '4',
                        PositionedWidth: 142.sp,
                        WidthContainer: 315.sp,
                        delay: 1500,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

Widget _container2(
    {required String NomeFilme,
    required String FotoFilme,
    required String Numero,
    required double PositionedWidth,
    required double WidthContainer}) {
  return Container(
    width: WidthContainer,
    height: 445.sp,
    child: Stack(
      children: [
        Positioned(
          left: 0.sp,
          top: 0.sp,
          child: GradientText(
            gradientDirection: GradientDirection.ttb,
            colors: [Color(0xffFE8E04), Color(0xffFE012F)],
            Numero,
            style: GoogleFonts.poppins(
              fontSize: 295.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Positioned(
          left: PositionedWidth,
          top: 121.21.sp,
          child: Column(
            children: [
              Container(
                width: 170.sp,
                height: 240.sp,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(FotoFilme),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 30.sp,
              ),
              Text(
                NomeFilme,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _container1 extends StatefulWidget {
  final String NomeFilme;
  final String FotoFilme;
  final String Numero;
  final double PositionedWidth;
  final double WidthContainer;
  final int delay;

  const _container1({
    Key? key,
    required this.NomeFilme,
    required this.FotoFilme,
    required this.Numero,
    required this.PositionedWidth,
    required this.WidthContainer,
    required this.delay,
  }) : super(key: key);

  @override
  _Container1State createState() => _Container1State();
}

class _Container1State extends State<_container1>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _hasFlipped1 = false;

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
    return VisibilityDetector(
      key: Key(widget.Numero),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2) {
          Future.delayed(Duration(milliseconds: widget.delay), () {
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
        width: widget.WidthContainer,
        height: 445.sp,
        child: Stack(
          children: [
            Positioned(
              left: 0.sp,
              top: 0.sp,
              child: GradientText(
                gradientDirection: GradientDirection.ttb,
                colors: [Color(0xffFE8E04), Color(0xffFE012F)],
                widget.Numero,
                style: GoogleFonts.poppins(
                  fontSize: 295.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
                  .animate(
                    controller: _controller,
                    autoPlay: false,
                    onPlay: (controller) {
                      _controller;
                    },
                  )
                  .fadeIn(
                    begin: 0,
                    duration: Duration(milliseconds: 1000),
                  )
                  .moveX(
                    begin: 60,
                    end: 0,
                    duration: Duration(milliseconds: 1000),
                  )
                  .moveY(
                    begin: 30,
                    end: 0,
                    duration: Duration(milliseconds: 1000),
                  ),
            ),
            Positioned(
              left: widget.PositionedWidth,
              top: 121.21.sp,
              child: Column(
                children: [
                  Container(
                    width: 170.sp,
                    height: 240.sp,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.FotoFilme),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Text(
                    widget.NomeFilme,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontFamily: 'EutoStile',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                      .animate(
                        controller: _controller,
                        autoPlay: false,
                        onPlay: (controller) {
                          _controller;
                        },
                      )
                      .fadeIn(
                        begin: 0,
                        duration: Duration(milliseconds: 1000),
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
