import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Max extends StatefulWidget {
  const Max({super.key});

  @override
  State<Max> createState() => _MaxState();
}

class _MaxState extends State<Max> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Isso mantém o estado do widget.

  @override
  void initState() {
    super.initState();

    // Inicializar os controladores de animação
  }

  @override
  void dispose() {
    // Não se esqueça de liberar os controladores de animação ao destruir o estado

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
          child: Column(
            children: [
              Container(
                width: 475.sp,
                height: 130.sp,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/Max.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 60.sp,
              ),
              VisibilityDetector(
                onVisibilityChanged: (visibilityInfo) {
                  if (visibilityInfo.visibleFraction > 0.9) {
                    // Iniciar animação com delay
                    Future.delayed(Duration(seconds: 10), () {});
                  }
                },
                key: Key('card90'),
                child: Container(
                    // color: Colors.amber,
                    width: 1040.sp,
                    child: Text(
                      'A Max combina os mundos da HBO, o Universo DC, filmes de sucesso, séries originais e gêneros favoritos dos fãs, como crimes reais, reality, comida e comédia. A Max inclui: Séries e filmes da HBO, Max Originals e séries e filmes selecionados da Warner Bros., DC, Cartoon Network, Wizarding World, Adult Swim, Home & Health, ID, Discovery Kids, Discovery e muito mais!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF13294E),
                        fontSize: 20.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                        height: 0.95,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 315.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container1(
                      NomeFilme: 'DUNA',
                      FotoFilme: 'lib/assets/images/duna.jpg',
                      Numero: '1',
                      PositionedWidth: 69.23.sp,
                      WidthContainer: 241.32.sp,
                      delay: 0, // Delay 0 segundos para o primeiro
                    ),
                    Container1(
                      NomeFilme: 'DUNA\nPARTE DOIS',
                      FotoFilme: 'lib/assets/images/duna2.jpg',
                      Numero: '2',
                      PositionedWidth: 122.55.sp,
                      WidthContainer: 295.sp,
                      delay: 0500, // Delay 1 segundo para o segundo
                    ),
                    Container1(
                      NomeFilme: 'HOUSE OF\nTHE DRAGON',
                      FotoFilme: 'lib/assets/images/houseofdragons.jpg',
                      Numero: '3',
                      PositionedWidth: 122.55.sp,
                      WidthContainer: 295.sp,
                      delay: 1000, // Delay 2 segundos para o terceiro
                    ),
                    Container1(
                      NomeFilme: 'THE LAST OF US',
                      FotoFilme: 'lib/assets/images/thelastofus.jpg',
                      Numero: '4',
                      PositionedWidth: 142.sp,
                      WidthContainer: 315.sp,
                      delay: 1500, // Delay 3 segundos para o quarto
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Container1 extends StatefulWidget {
  final String NomeFilme;
  final String FotoFilme;
  final String Numero;
  final double PositionedWidth;
  final double WidthContainer;
  final int delay;

  const Container1({
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

class _Container1State extends State<Container1>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  bool _hasFlipped1 = false;
  bool _hasFlipped2 = false;
  bool _hasFlipped3 = false;
  bool _hasFlipped4 = false;

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
              child: Text(
                widget.Numero,
                style: GoogleFonts.poppins(
                  color: Color(0xFF002BE7),
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
