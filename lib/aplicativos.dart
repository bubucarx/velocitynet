import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Aplicativos extends StatefulWidget {
  const Aplicativos({super.key});

  @override
  State<Aplicativos> createState() => _AplicativosState();
}

class _AplicativosState extends State<Aplicativos>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _hasFlipped1 = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final designSize =
            isMobile ? const Size(360, 800) : const Size(2920, 1080);

        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return Container(
              height: isMobile ? 700.h : 910.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.w : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitle(isMobile),
                  SizedBox(height: isMobile ? 20.h : 40.h),
                  _buildAppsGrid(isMobile),
                  SizedBox(height: isMobile ? 20.h : 45.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTitle(bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : 780.w,
      child: VisibilityDetector(
        key: const Key('apps-title'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0.2 && !_hasFlipped1) {
            Future.delayed(const Duration(milliseconds: 200), () {
              _controller.forward();
              setState(() => _hasFlipped1 = true);
            });
          }
        },
        child: Text(
          'Confira quais os aplicativos disponíveis para a personalização do seu plano:',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 24.sp : 50.sp,
            fontFamily: 'EutoStile',
            fontWeight: FontWeight.w700,
            color: const Color(0xFF13294E),
            letterSpacing: -1.25.sp,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildAppsGrid(bool isMobile) {
    final containerSize =
        isMobile ? 100.w : 190.w; // Reduzi um pouco o tamanho para mobile
    final gridPadding = isMobile ? 5.w : 0.w; // Reduzi o padding entre os itens

    return Center(
      child: SizedBox(
        height: isMobile ? 500.h : 500.h, // Reduzi a altura para mobile
        width: isMobile ? double.infinity : 700.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alterado para center
          children: [
            // First row of apps
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Alterado para center
                children: [
                  _AppContainer(
                    controller: _controller,
                    image: 'lib/assets/images/globoplayApp.png',
                    position: -1205,
                    delay: 400,
                    size: containerSize,
                  ),
                  SizedBox(width: isMobile ? 10.w : 20.w), // Espaço controlado
                  _AppContainer(
                    controller: _controller,
                    image: 'lib/assets/images/premiereApp.png',
                    position: -1205,
                    delay: 200,
                    size: containerSize,
                  ),
                  if (!isMobile) SizedBox(width: 20.w), // Espaço controlado
                  if (!isMobile)
                    _AppContainer(
                      controller: _controller,
                      image: 'lib/assets/images/telecineApp.png',
                      position: -1205,
                      delay: 0,
                      size: containerSize,
                    ),
                ],
              ),
            ),

            SizedBox(
                height:
                    isMobile ? 15.h : 20.h), // Espaço controlado entre linhas

            // Second row of apps
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridPadding),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Alterado para center
                children: [
                  if (!isMobile)
                    _AppContainer(
                      controller: _controller,
                      image: 'lib/assets/images/globoplayPlusCanais.png',
                      position: 1205,
                      delay: 400,
                      size: containerSize,
                    ),
                  if (!isMobile) SizedBox(width: 20.w), // Espaço controlado
                  _AppContainer(
                    controller: _controller,
                    image: 'lib/assets/images/maxApp.png',
                    position: 1205,
                    delay: isMobile ? 200 : 800,
                    size: containerSize,
                  ),
                  SizedBox(width: isMobile ? 10.w : 20.w), // Espaço controlado
                  _AppContainer(
                    controller: _controller,
                    image: 'lib/assets/images/deezerApp.png',
                    position: 1205,
                    delay: isMobile ? 400 : 1200,
                    size: containerSize,
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

class _AppContainer extends StatelessWidget {
  final String image;
  final double position;
  final int delay;
  final double size;
  final AnimationController controller;

  const _AppContainer({
    required this.controller,
    required this.delay,
    required this.position,
    required this.image,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
    )
        .animate(autoPlay: false, controller: controller)
        .moveX(
          delay: Duration(milliseconds: delay),
          begin: position,
          end: 0,
          curve: FlippedCurve(Easing.emphasizedAccelerate),
          duration: const Duration(milliseconds: 1500),
        )
        .fadeIn(
          begin: 0,
          delay: Duration(milliseconds: delay),
          duration: const Duration(milliseconds: 1000),
        );
  }
}
