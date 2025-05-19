import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConexaoFibra extends StatefulWidget {
  const ConexaoFibra({super.key});

  @override
  State<ConexaoFibra> createState() => _ConexaoFibraState();
}

class _ConexaoFibraState extends State<ConexaoFibra>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isTablet = MediaQuery.of(context).size.width < 1200;
    final screenWidth = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      designSize: isMobile ? const Size(360, 800) : const Size(1920, 1080),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40.sp : 80.sp,
            horizontal: isMobile ? 16.sp : 0,
          ),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? screenWidth : 1600.sp,
            ),
            child: isMobile ? _buildMobileLayout() : 
                isTablet ? _buildTabletLayout() : _buildDesktopLayout(),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStaticContainer(1),
        SizedBox(height: 40.sp),
        _buildStaticContainer(2),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStaticContainer(0),
          SizedBox(width: 32.w),
          _buildStaticContainer(1),
          SizedBox(width: 32.w),
          _buildStaticContainer(2),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStaticContainer(0),
        SizedBox(width: 40.w),
        _buildStaticContainer(1),
        SizedBox(width: 40.w),
        _buildStaticContainer(2),
      ],
    );
  }

  Widget _buildStaticContainer(int index) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isTablet = MediaQuery.of(context).size.width < 1200;

    final containerWidth = isMobile
        ? 280.sp
        : isTablet
            ? 320.sp
            : 380.sp;

    final containerPadding = EdgeInsets.symmetric(
      horizontal: isMobile ? 0 : 16.sp,
      vertical: isMobile ? 0 : 16.sp,
    );

    switch (index) {
      case 0:
        return SizedBox(
          width: containerWidth,
          child: Padding(
            padding: containerPadding,
            child: StaticCard(
              icone: PhosphorIcons.game_controller_fill,
              titulo: "A conexão que mais contribui para diversão",
              text: 'A melhor internet para quem curte um game, filme, série e muito mais do entretenimento!',
            ),
          ),
        );
      case 1:
        return SizedBox(
          width: containerWidth,
          child: Padding(
            padding: containerPadding,
            child: StaticCard(
              icone: Icons.rocket_launch,
              titulo: 'Conectando você em velocidade máxima',
              text: 'Uma velocidade sem igual que só a Velocitynet garante para você!',
            ),
          ),
        );
      case 2:
      default:
        return SizedBox(
          width: containerWidth,
          child: Padding(
            padding: containerPadding,
            child: StaticCard(
              icone: PhosphorIcons.cpu_fill,
              titulo: 'O melhor da tecnologia na sua casa!',
              text: 'Equipamentos de qualidade para uma internet com ainda mais qualidade!',
            ),
          ),
        );
    }
  }
}

class StaticCard extends StatelessWidget {
  final String titulo;
  final String text;
  final IconData icone;

  const StaticCard({
    super.key,
    required this.icone,
    required this.text,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final isTablet = MediaQuery.of(context).size.width < 1200;

    final iconSize = isMobile ? 60.sp : isTablet ? 70.sp : 80.sp;
    final iconContainerSize = isMobile ? 120.sp : isTablet ? 140.sp : 160.sp;
    final titleFontSize = isMobile ? 26.sp : isTablet ? 30.sp : 36.sp;
    final textFontSize = isMobile ? 18.sp : isTablet ? 20.sp : 22.sp;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
          angle: 45 * 3.14159 / 180,
          child: Container(
            width: iconContainerSize,
            height: iconContainerSize,
            decoration: ShapeDecoration(
              color: const Color(0xff002450),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isMobile ? 30.sp : 60.sp),
              ),
            ),
            child: Transform.rotate(
              angle: -45 * 3.14159 / 180,
              child: Center(
                child: Icon(
                  icone,
                  size: iconSize,
                  color: const Color(0xffFFB000),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 24.sp : 36.sp),
        Text(
          titulo,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.2,
            fontSize: titleFontSize,
            fontFamily: 'EutoStile',
            fontWeight: FontWeight.w700,
            color: const Color(0xFF002450),
          ),
        ),
        SizedBox(height: isMobile ? 16.sp : 24.sp),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: textFontSize,
            fontFamily: 'EutoStile',
            fontWeight: FontWeight.w300,
            height: 1.4,
            color: const Color(0xFF5B5B5B),
          ),
        ),
      ],
    );
  }
}