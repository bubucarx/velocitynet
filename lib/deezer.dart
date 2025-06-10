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
      designSize: isMobile ? const Size(360, 800) : const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.sp : 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: isMobile ? 40.sp : 90.sp),

                // Imagem Deezer
                Container(
                  width: isMobile ? double.infinity : 570.sp,
                  height: isMobile ? 200.sp : 360.sp,
                  margin:
                      isMobile ? EdgeInsets.symmetric(horizontal: 20.sp) : null,
                  decoration: const BoxDecoration(
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
                        Future.delayed(const Duration(milliseconds: 200), () {
                          _flipCardController1.flipcard();
                          setState(() => _hasFlipped1 = true);
                        });
                      }
                      if (!_hasFlipped2) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          _flipCardController2.flipcard();
                          setState(() => _hasFlipped2 = true);
                        });
                      }
                      if (!_hasFlipped3) {
                        Future.delayed(const Duration(milliseconds: 400), () {
                          _flipCardController3.flipcard();
                          setState(() => _hasFlipped3 = true);
                        });
                      }
                      if (!_hasFlipped4) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          _flipCardController4.flipcard();
                          setState(() => _hasFlipped4 = true);
                        });
                      }
                    }
                  },
                  key: const Key('card1'),
                  child: Container(
                    width: isMobile ? double.infinity : 1040.sp,
                    padding: isMobile
                        ? EdgeInsets.symmetric(horizontal: 16.sp)
                        : null,
                    margin: EdgeInsets.only(top: isMobile ? 20.sp : 40.sp),
                    child: Text(
                      'A Deezer é um aplicativo de streaming musical que oferece acesso a mais de 120 milhões de faixas do mundo todo, além de outros conteúdos, como podcasts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF13294E),
                        fontSize: isMobile ? 16.sp : 20.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                        height: 0.95,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isMobile ? 30.sp : 50.sp),

                // Container principal dos álbuns aumentado
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20.sp : 40.sp,
                    vertical: isMobile ? 20.sp : 40.sp,
                  ),
                  child: isMobile
                      ? _buildMobileAlbumsLayout()
                      : _buildDesktopAlbumsLayout(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopAlbumsLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAlbumCard(
            foto: "lib/assets/images/haverasinais.png",
            nomeMusica: 'HAVERÁ SINAIS',
            nomeCantor: 'Jorge & Mateus',
            controller: _flipCardController1,
            isMobile: false,
          ),
          _buildAlbumCard(
            foto: "lib/assets/images/gostaderua.jpg",
            nomeMusica: 'GOSTA DE RUA',
            nomeCantor: 'Felipe & Rodrigo',
            controller: _flipCardController2,
            isMobile: false,
          ),
          _buildAlbumCard(
            foto: "lib/assets/images/thebox.jpg",
            nomeMusica: 'THE BOX MEDLEY FUNK 2',
            nomeCantor: 'The Box',
            controller: _flipCardController3,
            isMobile: false,
          ),
          _buildAlbumCard(
            foto: "lib/assets/images/sagradoprofano.jpg",
            nomeMusica: 'SAGRADO PROFANO',
            nomeCantor: 'Luísa Sonza',
            controller: _flipCardController4,
            isMobile: false,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileAlbumsLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp), 
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.sp, 
        runSpacing: 20.sp, 
        children: [
          _buildAlbumCard(
            foto: "lib/assets/images/haverasinais.png",
            nomeMusica: 'HAVERÁ SINAIS',
            nomeCantor: 'Jorge & Mateus',
            controller: _flipCardController1,
            isMobile: true,
          ),
          _buildAlbumCard(
            foto: "lib/assets/images/gostaderua.jpg",
            nomeMusica: 'GOSTA DE RUA',
            nomeCantor: 'Felipe & Rodrigo',
            controller: _flipCardController2,
            isMobile: true,
          ),
          _buildAlbumCard(
            foto: "lib/assets/images/thebox.jpg",
            nomeMusica: 'THE BOX MEDLEY FUNK 2',
            nomeCantor: 'The Box',
            controller: _flipCardController3,
            isMobile: true,
          ),
          _buildAlbumCard(
            foto: "lib/assets/images/sagradoprofano.jpg",
            nomeMusica: 'SAGRADO PROFANO',
            nomeCantor: 'Luísa Sonza',
            controller: _flipCardController4,
            isMobile: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumCard({
    required String foto,
    required String nomeMusica,
    required String nomeCantor,
    required FlipCardController controller,
    required bool isMobile,
  }) {
    final cardSize = isMobile ? 160.sp : 300.sp; // Aumentado ligeiramente
    final textHeight = isMobile ? 70.sp : 90.sp; // Aumentado
    final titleFontSize = isMobile ? 15.sp : 24.sp; // Aumentado
    final artistFontSize = isMobile ? 13.sp : 18.sp; // Aumentado
    final borderRadius = isMobile ? 10.sp : 12.sp; // Aumentado
    final borderWidth = isMobile ? 4.sp : 6.sp; // Aumentado

    return SizedBox(
      width: cardSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Card flipável
          FlipCard(
            controller: controller,
            rotateSide: RotateSide.right,
            axis: FlipAxis.horizontal,
            backWidget: Container(
                width: cardSize,
                height: cardSize,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(foto),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: borderWidth,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: const Color(0xFFA238FF),
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                )),
            frontWidget: Container(
              width: cardSize,
              height: cardSize,
              decoration: BoxDecoration(
                color: const Color(0xFFA238FF),
                borderRadius: BorderRadius.circular(borderRadius),
                image: const DecorationImage(
                  image: AssetImage('lib/assets/images/deezer2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 20.sp : 35.sp), // Aumentado
          // Container de texto com altura fixa
          SizedBox(
            height: textHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nome da música
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp), // Aumentado
                  child: Text(
                    nomeMusica,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'EutoStile',
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 6.sp : 10.sp), // Aumentado
                // Nome do artista
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp), // Aumentado
                  child: Text(
                    nomeCantor,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF9C9C9C),
                      fontFamily: 'EutoStile',
                      fontSize: artistFontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
