import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Premiere extends StatefulWidget {
  const Premiere({super.key});

  @override
  State<Premiere> createState() => _PremiereState();
}

class _PremiereState extends State<Premiere> with AutomaticKeepAliveClientMixin {
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
                // Logo Premiere - Ajuste idêntico ao modelo
                Container(
                  width: isMobile ? 280.sp : 475.sp,
                  height: isMobile ? 80.sp : 130.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("lib/assets/images/premiere/Premiere.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                SizedBox(height: isMobile ? 30.sp : 60.sp),
                
                // Descrição - Texto com mesmo estilo do modelo
                VisibilityDetector(
                  key: const Key('premiere_description'),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction > 0.9) {
                      // Lógica de animação se necessário
                    }
                  },
                  child: Container(
                    width: isMobile ? 320.sp : 1040.sp,
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.sp : 0),
                    child: Text(
                      'O Premiere, com a maior cobertura do futebol nacional, exibe os jogos ao vivo dos campeonatos estaduais 2023 (Gaúcho, Paulista, Mineiro) para seus assinantes, além da Copa do Brasil 2023 e do Campeonato Brasileiro Série A e B 2023 dos clubes que cederam direitos à Globo',
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
                
                // Lista de campeonatos - Layout idêntico ao modelo
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
              title: 'BRASILEIRÃO\nSÉRIE A e B',
              imagePath: 'lib/assets/images/premiere/image1.jpg',
            ),
            SizedBox(width: 40.sp),
            _ContentCard(
              index: 1,
              title: 'COPA DO BRASIL',
              imagePath: 'lib/assets/images/premiere/image2.jpg',
            ),
            SizedBox(width: 40.sp),
            _ContentCard(
              index: 2,
              title: 'CAMPEONATO\nPAULISTA',
              imagePath: 'lib/assets/images/premiere/image3.jpg',
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
          title: 'BRASILEIRÃO\nSÉRIE A e B',
          imagePath: 'lib/assets/images/premiere/image1.jpg',
          isMobile: true,
        ),
        SizedBox(height: 50.sp),
        _ContentCard(
          index: 1,
          title: 'COPA DO BRASIL',
          imagePath: 'lib/assets/images/premiere/image2.jpg',
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
            // Número gradiente - ajustado para o estilo Premiere (verde)
            Positioned(
              left: 0,
              top: 0,
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xFF00C853), // Verde claro
                      Color(0xFF1B5E20),  // Verde escuro
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
                  // Poster com sombra e borda verde
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
                        ),
                      ],
                      border: Border.all(
                        color: Colors.green, // Borda verde
                        width: 3.sp,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.sp),
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