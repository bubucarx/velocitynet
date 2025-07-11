import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocitynet/providerIndex.dart';

class _TextHeader extends StatefulWidget {
  final String text;
  final double width;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _TextHeader({
    super.key,
    required this.text,
    required this.width,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TextHeader> createState() => __TextHeaderState();
}

class __TextHeaderState extends State<_TextHeader> {
  double _fontSize = 23.0;
  FontWeight _fontWeight = FontWeight.w500;
  double _containerWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    // Resetar visual se não estiver selecionado
    if (!widget.isSelected &&
        (_fontSize != 23.0 || _fontWeight != FontWeight.w500)) {
      _fontSize = 23.0;
      _fontWeight = FontWeight.w500;
      _containerWidth = 0.0;
    }

    return MouseRegion(
      onEnter: (_) {
        if (!widget.isSelected) {
          setState(() {
            _fontSize = 24.5;
            _fontWeight = FontWeight.w700;
            _containerWidth = widget.width;
          });
        }
      },
      onExit: (_) {
        if (!widget.isSelected) {
          setState(() {
            _fontSize = 23.0;
            _fontWeight = FontWeight.w500;
            _containerWidth = 0.0;
          });
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: widget.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: widget.isSelected ? 25.0.sp : _fontSize.sp,
                  fontWeight: widget.isSelected ? FontWeight.w600 : _fontWeight,
                ),
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                height: widget.isSelected ? 4.h : 0,
                width: widget.isSelected ? widget.width.w : _containerWidth.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final double opacity;
  const Header({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 1200;
        final designSize =
            isMobile ? const Size(400, 860) : const Size(1920, 1080);

        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return Stack(
              children: [
                if (!isMobile)
                  Container(
                    width: isMobile ? double.infinity : 100.w,
                    height: isMobile ? 70.h : 95.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
                  child: Container(
                    width: isMobile ? double.infinity : 2000.w,
                    height: isMobile ? 70.h : 95.h,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xFF13294E),
                        Color.fromARGB(255, 25, 77, 167)
                      ]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: isMobile
                        ? _buildMobileHeader(context)
                        : _buildDesktopHeader(context),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shouldHideClientCenter = constraints.maxWidth <= 1320;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              "lib/assets/images/LOGOVETORIZADA.svg",
              fit: BoxFit.cover,
              width: 254.w,
              height: 50.h,
            ),
            Container(
              height: 120,
              child: Row(
                children: List.generate(6, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: _TextHeader(
                      text: _getHeaderText(index),
                      width: _getHeaderWidth(index),
                      index: index,
                      isSelected:
                          Provider.of<IndexProvider>(context).selectedIndex ==
                              index,
                      onTap: () {
                        Provider.of<IndexProvider>(context, listen: false)
                            .setSelectedIndex(index);
                      },
                    ),
                  );
                }),
              ),
            ),
            // CENTRAL DO CLIENTE ou ÍCONE
            shouldHideClientCenter
                ? IconButton(
                    icon: Icon(Icons.person_outline,
                        size: 40.sp, color: Colors.white),
                    onPressed: () {
                      launch(
                          "https://sistema.velocitynet.com.br/central_assinante_web/login");
                    },
                  )
                : InkWell(
                    onTap: () {
                      launch(
                          "https://sistema.velocitynet.com.br/central_assinante_web/login");
                    },
                    child: Container(
                      width: 290.w,
                      height: 35.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'CENTRAL DO CLIENTE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF13294E),
                            fontSize: 18.sp,
                            fontFamily: 'PetrovSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Logo à esquerda
          Positioned(
            left: 20.w,
            child: SvgPicture.asset(
              "lib/assets/images/LOGOVETORIZADA.svg",
              width: 150.w,
              height: 30.h,
              fit: BoxFit.contain,
            ),
          ),

          // Botão à direita
          Positioned(
            right: 20.w,
            child: IconButton(
              icon: Icon(Icons.menu, size: 30.sp, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () => _showCenteredMobileMenu(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showCenteredMobileMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 380.w,
              maxHeight: 0.9.sh, // Responsivo verticalmente
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF13294E),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(6, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: InkWell(
                        onTap: () {
                          Provider.of<IndexProvider>(context, listen: false)
                              .setSelectedIndex(index);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            _getHeaderText(index),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: Provider.of<IndexProvider>(context)
                                          .selectedIndex ==
                                      index
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        launch(
                          "https://sistema.velocitynet.com.br/central_assinante_web/login",
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'CENTRAL DO CLIENTE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF13294E),
                            fontSize: 16.sp,
                            fontFamily: 'PetrovSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getHeaderText(int index) {
    return [
      'Início',
      'Combos',
      'TV',
      'Contatos',
      'Trabalhe Conosco',
      'Teste de Velocidade'
    ][index];
  }

  double _getHeaderWidth(int index) {
    return [80, 130, 80, 150, 150, 150][index].toDouble();
  }
}
