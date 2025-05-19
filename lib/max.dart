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
                // Logo Max - Ajuste perfeito de tamanho
                Container(
                  width: isMobile ? 280.sp : 475.sp,
                  height: isMobile ? 80.sp : 130.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("lib/assets/images/Max.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                SizedBox(height: isMobile ? 30.sp : 60.sp),
                
                // Descrição - Texto perfeitamente ajustado
                VisibilityDetector(
                  key: const Key('max_description'),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction > 0.9) {
                      // Lógica de animação se necessário
                    }
                  },
                  child: Container(
                    width: isMobile ? 320.sp : 1040.sp,
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.sp : 0),
                    child: Text(
                      'A Max combina os mundos da HBO, o Universo DC, filmes de sucesso, séries originais e gêneros favoritos dos fãs, como crimes reais, reality, comida e comédia. A Max inclui: Séries e filmes da HBO, Max Originals e séries e filmes selecionados da Warner Bros., DC, Cartoon Network, Wizarding World, Adult Swim, Home & Health, ID, Discovery Kids, Discovery e muito mais!',
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
                
                // Lista de filmes/séries - Layout perfeito para cada dispositivo
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
              title: 'DUNA',
              imagePath: 'lib/assets/images/duna.jpg',
            ),
            SizedBox(width: 40.sp),
            _ContentCard(
              index: 1,
              title: 'DUNA\nPARTE DOIS',
              imagePath: 'lib/assets/images/duna2.jpg',
            ),
            SizedBox(width: 40.sp),
            _ContentCard(
              index: 2,
              title: 'HOUSE OF\nTHE DRAGON',
              imagePath: 'lib/assets/images/houseofdragons.jpg',
            ),
            SizedBox(width: 40.sp),
            _ContentCard(
              index: 3,
              title: 'THE LAST OF US',
              imagePath: 'lib/assets/images/thelastofus.jpg',
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
          title: 'DUNA',
          imagePath: 'lib/assets/images/duna.jpg',
          isMobile: true,
        ),
        SizedBox(height: 50.sp),
        _ContentCard(
          index: 1,
          title: 'DUNA\nPARTE DOIS',
          imagePath: 'lib/assets/images/duna2.jpg',
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
            _controller.forward();
            setState(() => _hasAnimated = true);
          });
        }
      },
      child: SizedBox(
        width: cardWidth,
        height: widget.isMobile ? 380.sp : 450.sp,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Número gradiente
            Positioned(
              left: 0,
              top: 0,
              child: Text(
                '${widget.index + 1}',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF002BE7),
                  fontSize: numberSize,
                  fontWeight: FontWeight.w700,
                  height: 0.75,
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
            
            // Conteúdo (imagem + título)
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