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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    
    return ScreenUtilInit(
      designSize: isMobile ? Size(360, 800) : Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.sp : 0),
            child: Column(
              children: [
                SizedBox(height: isMobile ? 40.sp : 90.sp),
                
                // Imagem Deezer
                Container(
                  width: isMobile ? double.infinity : 550.sp,
                  height: isMobile ? 200.sp : 360.sp,
                  margin: isMobile ? EdgeInsets.symmetric(horizontal: 20.sp) : null,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/deezer.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                // Descrição
                VisibilityDetector(
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction > 0.2) {
                      if (!_hasFlipped1) {
                        Future.delayed(Duration(milliseconds: 200), () {
                          _flipCardController1.flipcard();
                          setState(() => _hasFlipped1 = true);
                        });
                      }
                      if (!_hasFlipped2) {
                        Future.delayed(Duration(milliseconds: 300), () {
                          _flipCardController2.flipcard();
                          setState(() => _hasFlipped2 = true);
                        });
                      }
                      if (!_hasFlipped3) {
                        Future.delayed(Duration(milliseconds: 400), () {
                          _flipCardController3.flipcard();
                          setState(() => _hasFlipped3 = true);
                        });
                      }
                      if (!_hasFlipped4) {
                        Future.delayed(Duration(milliseconds: 500), () {
                          _flipCardController4.flipcard();
                          setState(() => _hasFlipped4 = true);
                        });
                      }
                    }
                  },
                  key: Key('card1'),
                  child: Container(
                    width: isMobile ? double.infinity : 1040.sp,
                    padding: isMobile ? EdgeInsets.symmetric(horizontal: 16.sp) : null,
                    margin: EdgeInsets.only(top: isMobile ? 20.sp : 40.sp),
                    child: Text(
                      'A Deezer é um aplicativo de streaming musical que oferece acesso a mais de 120 milhões de faixas do mundo todo, além de outros conteúdos, como podcasts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF13294E),
                        fontSize: isMobile ? 16.sp : 20.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                        height: 0.95,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: isMobile ? 30.sp : 50.sp),
                
                // Álbuns - Layout adaptável para mobile
                isMobile 
                  ? _buildMobileAlbumsLayout()
                  : _buildDesktopAlbumsLayout(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopAlbumsLayout() {
    return Padding(
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
    );
  }

  Widget _buildMobileAlbumsLayout() {
    return Column(
      children: [
        // Primeira linha (2 álbuns)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _capaMusica(
              foto: "lib/assets/images/haverasinais.png",
              nomeMusica: 'HAVERÁ SINAIS',
              nomeCantor: 'Jorge & Mateus',
              controller: _flipCardController1,
              isMobile: true,
            ),
            _capaMusica(
              foto: "lib/assets/images/gostaderua.jpg",
              nomeMusica: 'GOSTA DE RUA',
              nomeCantor: 'Felipe & Rodrigo',
              controller: _flipCardController2,
              isMobile: true,
            ),
          ],
        ),
        SizedBox(height: 30.sp),
        // Segunda linha (2 álbuns)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _capaMusica(
              foto: "lib/assets/images/thebox.jpg",
              nomeMusica: 'THE BOX MEDLEY FUNK 2',
              nomeCantor: 'The Box',
              controller: _flipCardController3,
              isMobile: true,
            ),
            _capaMusica(
              foto: "lib/assets/images/sagradoprofano.jpg",
              nomeMusica: 'SAGRADO PROFANO',
              nomeCantor: 'Luísa Sonza',
              controller: _flipCardController4,
              isMobile: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _capaMusica({
    required String foto,
    required String nomeMusica,
    required String nomeCantor,
    required FlipCardController controller,
    bool isMobile = false,
  }) {
    return Column(
      children: [
        FlipCard(
          controller: controller,
          rotateSide: RotateSide.right,
          axis: FlipAxis.horizontal,
          backWidget: Container(
            width: isMobile ? 150.sp : 275.sp,
            height: isMobile ? 150.sp : 275.sp,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(foto),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: isMobile ? 3.sp : 5.sp,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFFA238FF),
                ),
                borderRadius: BorderRadius.circular(isMobile ? 8.sp : 10.sp),
              ),
            ),
          ),
          frontWidget: Container(
            width: isMobile ? 150.sp : 275.sp,
            height: isMobile ? 150.sp : 275.sp,
            decoration: BoxDecoration(
              color: Color(0xFFA238FF),
              borderRadius: BorderRadius.circular(isMobile ? 8.sp : 10.sp),
              image: DecorationImage(
                image: AssetImage('lib/assets/images/deezer2.png')),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 15.sp : 30.sp),
        Container(
          width: isMobile ? 150.sp : null,
          child: Column(
            children: [
              Text(
                nomeMusica,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'EutoStile',
                  fontSize: isMobile ? 14.sp : 23.sp,
                  fontWeight: FontWeight.w700),
              ),
              SizedBox(height: isMobile ? 4.sp : 0),
              Text(
                nomeCantor,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9C9C9C),
                  fontFamily: 'EutoStile',
                  fontSize: isMobile ? 12.sp : 17.sp,
                  fontWeight: FontWeight.w700,
                  height: isMobile ? 1.2 : 0.3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}