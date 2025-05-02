import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Deezer extends StatefulWidget {
  const Deezer({super.key});

  @override
  State<Deezer> createState() => _DeezerState();
}

class _DeezerState extends State<Deezer> with AutomaticKeepAliveClientMixin {
  // Controladores para cada FlipCard
  final FlipCardController _flipCardController1 = FlipCardController();
  final FlipCardController _flipCardController2 = FlipCardController();
  final FlipCardController _flipCardController3 = FlipCardController();
  final FlipCardController _flipCardController4 = FlipCardController();

  // Variáveis booleanas para controlar se a animação já foi disparada
  bool _hasFlipped1 = false;
  bool _hasFlipped2 = false;
  bool _hasFlipped3 = false;
  bool _hasFlipped4 = false;

  @override
  bool get wantKeepAlive => true; // Isso mantém o estado do widget.

  @override
  Widget build(BuildContext context) {
    super.build(context); // Chamada obrigatória do `super.build`
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Container(
          child: Column(
            children: [
              SizedBox(
                height: 90.sp,
              ),
              Container(
                width: 550.sp,
                height: 360.sp,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/deezer.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // Usando VisibilityDetector para monitorar a visibilidade de cada card
              VisibilityDetector(
                onVisibilityChanged: (visibilityInfo) {
                  if (visibilityInfo.visibleFraction > 0.2) {
                    // Verificar e executar a animação apenas uma vez
                    if (!_hasFlipped1) {
                      Future.delayed(Duration(milliseconds: 200), () {
                        _flipCardController1.flipcard();
                        setState(() {
                          _hasFlipped1 = true; // Marcar como já flipado
                        });
                      });
                    }
                    if (!_hasFlipped2) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        _flipCardController2.flipcard();
                        setState(() {
                          _hasFlipped2 = true; // Marcar como já flipado
                        });
                      });
                    }
                    if (!_hasFlipped3) {
                      Future.delayed(Duration(milliseconds: 400), () {
                        _flipCardController3.flipcard();
                        setState(() {
                          _hasFlipped3 = true; // Marcar como já flipado
                        });
                      });
                    }
                    if (!_hasFlipped4) {
                      Future.delayed(Duration(milliseconds: 500), () {
                        _flipCardController4.flipcard();
                        setState(() {
                          _hasFlipped4 = true; // Marcar como já flipado
                        });
                      });
                    }
                  }
                },
                key: Key('card1'),
                child: SizedBox(
                  height: 40.sp,
                  width: 1040.sp,
                  child: Text(
                    'A Deezer é um aplicativo de streaming musical que oferece acesso a mais de 120 milhões de faixas do mundo todo, além de outros conteúdos, como podcasts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF13294E),
                      fontSize: 20.sp,
                      fontFamily: 'EutoStile',
                      fontWeight: FontWeight.w700,
                      height: 0.95,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 315.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _capaMusica(
                      foto: "lib/assets/images/haverasinais.png",
                      nomeMusica: 'HAVERÁ SINAIS',
                      nomeCantor: 'Jorge & Mateus',
                      controller: _flipCardController1,
                    ),
                    _capaMusica(
                      foto: "lib/assets/images/gostaderua.jpg",
                      nomeMusica: 'GOSTA DE RUA',
                      nomeCantor: 'Felipe & Rodrigo',
                      controller: _flipCardController2,
                    ),
                    _capaMusica(
                      foto: "lib/assets/images/thebox.jpg",
                      nomeMusica: 'THE BOX MEDLEY FUNK 2',
                      nomeCantor: 'The Box',
                      controller: _flipCardController3,
                    ),
                    _capaMusica(
                      foto: "lib/assets/images/sagradoprofano.jpg",
                      nomeMusica: 'SAGRADO PROFANO',
                      nomeCantor: 'Luísa Sonza',
                      controller: _flipCardController4,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _capaMusica({
    required String foto,
    required String nomeMusica,
    required String nomeCantor,
    required FlipCardController controller,
  }) {
    return Column(
      children: [
        // FlipCard que gira entre a face da frente e de trás
        FlipCard(
          controller: controller,
          rotateSide: RotateSide.right,
          axis: FlipAxis.horizontal, // Pode ser "HORIZONTAL" ou "VERTICAL"
          backWidget: Container(
            width: 275.sp,
            height: 275.sp,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(foto),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 5.sp,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFFA238FF),
                ),
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
          ),
          frontWidget: Container(
            width: 275.sp,
            height: 275.sp,
            decoration: BoxDecoration(
                color: Color(0xFFA238FF), // Cor ou conteúdo da parte de trás
                borderRadius: BorderRadius.circular(10.sp),
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/deezer2.png'))),
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        Text(
          nomeMusica,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'EutoStile',
              fontSize: 23.sp,
              fontWeight: FontWeight.w700),
        ),
        Text(
          nomeCantor,
          style: TextStyle(
              color: Color(0xFF9C9C9C),
              fontFamily: 'EutoStile',
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              height: 0.3),
        )
      ],
    );
  }
}
