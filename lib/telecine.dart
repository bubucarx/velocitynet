import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Telecine extends StatefulWidget {
  const Telecine({super.key});

  @override
  State<Telecine> createState() => _TelecineState();
}

class _TelecineState extends State<Telecine> with AutomaticKeepAliveClientMixin {
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
            padding: EdgeInsets.symmetric(vertical: isMobile ? 40.sp : 80.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo Telecine - Ajuste idêntico ao modelo
                Container(
                  width: isMobile ? 280.sp : 475.sp,
                  height: isMobile ? 80.sp : 130.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("lib/assets/images/telecine/TELECINE.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                SizedBox(height: isMobile ? 30.sp : 60.sp),
                
                // Descrição - Texto com mesmo estilo do modelo
                VisibilityDetector(
                  key: const Key('telecine_description'),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction > 0.9) {
                      // Lógica de animação se necessário
                    }
                  },
                  child: Container(
                    width: isMobile ? 320.sp : 1040.sp,
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.sp : 0),
                    child: Text(
                      'Líder e referência em filmes, o Telecine te oferece a melhor experiência de cinema do Brasil. Com o catálogo mais completo, nossos filmes estão disponíveis na programação ininterrupta dos 6 canais e em streaming, selecionados pelo nosso time de apaixonados por cinema, pra você encontrar o que quer assistir rapidinho. Com muito conteúdo de bastidores, curiosidades e dicas, aqui no Telecine, o filme é só o começo. Você curte os clássicos que adora rever, sucessos dos grandes estúdios, o melhor do mercado independente e do cinema nacional, além de filmes inéditos e estreias exclusivas.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF13294E),
                        fontSize: isMobile ? 16.sp : 20.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: isMobile ? 40.sp : 80.sp),
                
                // Lista de filmes - Layout idêntico ao modelo
                isMobile ? _buildMobileContentList() : _buildDesktopContentList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopContentList() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1600),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20.sp),
            _ContentCard(
              index: 0,
              title: 'OPPENHEIMER',
              imagePath: 'lib/assets/images/telecine/image1.jpg',
            ),
            SizedBox(width: 40.sp),
            _ContentCard(
              index: 1,
              title: 'THE SUPER MARIO\nBROS MOVIE',
              imagePath: 'lib/assets/images/telecine/image2.jpg',
            ),
            SizedBox(width: 40.sp),
            _ContentCard(
              index: 2,
              title: 'FIVE NIGHTS\nAT FREDDYS',
              imagePath: 'lib/assets/images/telecine/image3.jpg',
            ),
            SizedBox(width: 40.sp),
            _ContentCard(
              index: 3,
              title: 'MEGAN',
              imagePath: 'lib/assets/images/telecine/image4.jpg',
            ),
            SizedBox(width: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileContentList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ContentCard(
          index: 0,
          title: 'OPPENHEIMER',
          imagePath: 'lib/assets/images/telecine/image1.jpg',
          isMobile: true,
        ),
        SizedBox(height: 50.sp),
        _ContentCard(
          index: 1,
          title: 'THE SUPER MARIO\nBROS MOVIE',
          imagePath: 'lib/assets/images/telecine/image2.jpg',
          isMobile: true,
        ),
      ],
    );
  }
}

class _ContentCard extends StatefulWidget {
  final int index;
  final String title;
  final String imagePath;
  final bool isMobile;

  const _ContentCard({
    required this.index,
    required this.title,
    required this.imagePath,
    this.isMobile = false,
  });

  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<_ContentCard> 
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  bool _hasAnimated = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.isMobile ? 300.sp : 320.sp;
    final imageWidth = widget.isMobile ? 200.sp : 220.sp;
    final numberSize = widget.isMobile ? 160.sp : 220.sp;
    final topPosition = widget.isMobile ? 80.sp : 90.sp;
    final leftPosition = widget.isMobile ? 70.sp : 60.sp;

    return VisibilityDetector(
      key: Key('card_${widget.index}'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2 && !_hasAnimated) {
          Future.delayed(Duration(milliseconds: widget.index * 300), () {
            if (mounted) {
              _controller.forward();
              setState(() => _hasAnimated = true);
            }
          });
        }
      },
      child: SizedBox(
        width: cardWidth,
        height: widget.isMobile ? 380.sp : 450.sp,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Número gradiente - ajustado para o estilo Telecine
            Positioned(
              left: 0,
              top: 0,
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xffFF0033),
                      Color(0xff000066),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds);
                },
                child: Text(
                  '${widget.index + 1}',
                  style: GoogleFonts.poppins(
                    color: Colors.white, // Cor base que será substituída pelo gradiente
                    fontSize: numberSize,
                    fontWeight: FontWeight.w700,
                    height: 0.75,
                  ),
                ),
              )
              .animate(
                controller: _controller,
                autoPlay: false,
              )
              .fadeIn(
                duration: 800.ms,
                curve: Curves.easeOutCubic,
              )
              .moveX(
                begin: 30,
                duration: 800.ms,
                curve: Curves.easeOutBack,
              ),
            ),
            
            // Conteúdo (imagem + título) - idêntico ao modelo
            Positioned(
              left: leftPosition,
              top: topPosition,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Poster com sombra e borda
                  Container(
                    width: imageWidth,
                    height: imageWidth * 1.41, // Proporção 16:9
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.sp),
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: widget.isMobile ? 20.sp : 25.sp),
                  
                  // Título
                  SizedBox(
                    width: imageWidth,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.isMobile ? 19.sp : 22.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    )
                    .animate(
                      controller: _controller,
                      autoPlay: false,
                    )
                    .fadeIn(
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    )
                    .scaleXY(
                      begin: 0.9,
                      duration: 600.ms,
                    ),
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