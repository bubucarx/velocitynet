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

class _GloboplayState extends State<Globoplay> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return ScreenUtilInit(
      designSize: isMobile ? const Size(360, 800) : const Size(1920, 1080),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 40.sp : 60.sp),
            child: Column(
              children: [
                // Logo Globoplay
                Container(
                  width: isMobile ? 300.sp : 645.sp,
                  height: isMobile ? 65.sp : 140.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/globoplay/Globoplay.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                SizedBox(height: isMobile ? 30.sp : 60.sp),
                
                // Descrição
                SizedBox(
                  width: isMobile ? 320.sp : 1040.sp,
                  child: Text(
                    'Globoplay é a plataforma digital de vídeos da Globo. No Globoplay, você encontra séries originais e exclusivas, filmes, documentários, conteúdos infantis, novelas e programas além do sinal ao vivo da TV Globo e do Canal Futura. O acesso é pela internet e pode ser realizado por computador, celular, tablet, Smart TV, Apple TV, Android TV, Chromecast e Roku.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF13294E),
                      fontSize: isMobile ? 14.sp : 20.sp,
                      fontFamily: 'EutoStile',
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),
                
                SizedBox(height: isMobile ? 30.sp : 60.sp),
                
                // Lista de filmes/séries
                isMobile ? _buildMobileMovieList() : _buildDesktopMovieList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopMovieList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20.sp),
          _MovieCard(
            widthContainer: 280.sp,
            positionedLeft: 70.sp,
            imagePath: 'lib/assets/images/globoplay/ojogo.jpg',
            title: 'O JOGO QUE\nMUDOU A HISTÓRIA',
            number: '1',
            delay: 0,
          ),
          SizedBox(width: 40.sp),
          _MovieCard(
            title: 'OS PARÇAS',
            imagePath: 'lib/assets/images/globoplay/osparcas.jpg',
            number: '2',
            positionedLeft: 70.sp,
            widthContainer: 280.sp,
            delay: 200,
          ),
          SizedBox(width: 40.sp),
          _MovieCard(
            title: 'THE GOOD\nDOCTOR',
            imagePath: 'lib/assets/images/globoplay/thegooddoctor.jpg',
            number: '3',
            positionedLeft: 70.sp,
            widthContainer: 280.sp,
            delay: 400,
          ),
          SizedBox(width: 40.sp),
          _MovieCard(
            title: 'ARCANJO\nRENEGADO',
            imagePath: 'lib/assets/images/globoplay/arcanjorenegado.jpg',
            number: '4',
            positionedLeft: 70.sp,
            widthContainer: 280.sp,
            delay: 600,
          ),
          SizedBox(width: 20.sp),
        ],
      ),
    );
  }

  Widget _buildMobileMovieList() {
    return Column(
      children: [
        // Primeiro card
        _MovieCard(
          widthContainer: 300.sp,
          positionedLeft: 80.sp,
          imagePath: 'lib/assets/images/globoplay/ojogo.jpg',
          title: 'O JOGO QUE\nMUDOU A HISTÓRIA',
          number: '1',
          delay: 0,
          isMobile: true,
        ),
        
        SizedBox(height: 40.sp),
        
        // Segundo card
        _MovieCard(
          title: 'OS PARÇAS',
          imagePath: 'lib/assets/images/globoplay/osparcas.jpg',
          number: '2',
          positionedLeft: 80.sp,
          widthContainer: 300.sp,
          delay: 200,
          isMobile: true,
        ),
      ],
    );
  }
}

class _MovieCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final String number;
  final double positionedLeft;
  final double widthContainer;
  final int delay;
  final bool isMobile;

  const _MovieCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.number,
    required this.positionedLeft,
    required this.widthContainer,
    required this.delay,
    this.isMobile = false,
  }) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<_MovieCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = widget.isMobile ? 180.sp : 170.sp; // Aumentado para mobile
    final imageHeight = imageWidth * 1.5;
    final fontSize = widget.isMobile ? 18.sp : 20.sp; // Aumentado para mobile
    final numberSize = widget.isMobile ? 150.sp : 200.sp; // Aumentado para mobile

    return VisibilityDetector(
      key: Key(widget.number),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2 && !_hasAnimated) {
          Future.delayed(Duration(milliseconds: widget.delay), () {
            _controller.forward();
            setState(() => _hasAnimated = true);
          });
        }
      },
      child: SizedBox(
        width: widget.widthContainer,
        height: widget.isMobile ? 350.sp : 400.sp, // Aumentado para mobile
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Número gradiente
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: widget.widthContainer,
                child: GradientText(
                  widget.number,
                  gradientDirection: GradientDirection.ttb,
                  colors: [Color(0xffFE8E04), Color(0xffFE012F)],
                  style: GoogleFonts.poppins(
                    fontSize: numberSize,
                    fontWeight: FontWeight.w700,
                    height: 0.8,
                  ),
                )
                    .animate(
                      controller: _controller,
                      autoPlay: false,
                    )
                    .fadeIn(
                      begin: 0,
                      duration: Duration(milliseconds: 800),
                    )
                    .moveX(
                      begin: 60,
                      end: 0,
                      duration: Duration(milliseconds: 800),
                    ),
              ),
            ),
            
            // Imagem e título
            Positioned(
              left: widget.positionedLeft,
              top: widget.isMobile ? 90.sp : 100.sp, // Ajustado para mobile
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Poster do filme/série
                  Container(
                    width: imageWidth,
                    height: imageHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: widget.isMobile ? 20.sp : 20.sp),
                  
                  // Título
                  SizedBox(
                    width: imageWidth,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fontSize,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                      .animate(
                        controller: _controller,
                        autoPlay: false,
                      )
                      .fadeIn(
                        begin: 0,
                        duration: Duration(milliseconds: 800),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}