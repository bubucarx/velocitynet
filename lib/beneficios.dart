import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:velocitynet/deezer.dart';
import 'package:velocitynet/entretenimento.dart';
import 'package:velocitynet/globoplay.dart';
import 'package:velocitynet/max.dart';
import 'package:velocitynet/premiere.dart';
import 'package:velocitynet/telecine.dart';

class Beneficios extends StatefulWidget {
  const Beneficios({super.key});

  @override
  State<Beneficios> createState() => _BeneficiosState();
}

class _BeneficiosState extends State<Beneficios> {
  // Controladores para as seções
  final Map<String, GlobalKey> _sectionKeys = {
    'entretenimento': GlobalKey(),
    'deezer': GlobalKey(),
    'max': GlobalKey(),
    'globoplay': GlobalKey(),
    'telecine': GlobalKey(),
    'premiere': GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final screenHeight = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      designSize: isMobile ? const Size(360, 800) : const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return SafeArea(
          child: DynMouseScroll(
            durationMS: isMobile ? 1500 : 2000,
            scrollSpeed: isMobile ? 1.5 : 1.9,
            animationCurve: Curves.easeOutQuart,
            builder: (context, controller, physics) {
              return ListView(
                controller: controller,
                physics: physics,
                padding: EdgeInsets.zero,
                children: [
                  // Seção Entretenimento
                  _buildSection(
                    key: _sectionKeys['entretenimento']!,
                    child: Entretenimento(),
                    isMobile: isMobile,
                    screenHeight: screenHeight,
                  ),
                  
                  // Seção Deezer
                  _buildSection(
                    key: _sectionKeys['deezer']!,
                    child: Deezer(),
                    isMobile: isMobile,
                    screenHeight: screenHeight,
                  ),
                  
                  // Seção Max
                  _buildSection(
                    key: _sectionKeys['max']!,
                    child: Max(),
                    isMobile: isMobile,
                    screenHeight: screenHeight,
                  ),
                  
                  // Seção Globoplay
                  _buildSection(
                    key: _sectionKeys['globoplay']!,
                    child: Globoplay(),
                    isMobile: isMobile,
                    screenHeight: screenHeight,
                  ),
                  
                  // Seção Telecine
                  _buildSection(
                    key: _sectionKeys['telecine']!,
                    child: Telecine(),
                    isMobile: isMobile,
                    screenHeight: screenHeight,
                  ),
                  
                  // Seção Premiere
                  _buildSection(
                    key: _sectionKeys['premiere']!,
                    child: Premiere(),
                    isMobile: isMobile,
                    screenHeight: screenHeight,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required GlobalKey key,
    required Widget child,
    required bool isMobile,
    required double screenHeight,
  }) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.w : 80.w,
        vertical: isMobile ? 40.h : 80.h,
      ),
      constraints: BoxConstraints(
        minHeight: isMobile ? screenHeight * 0.8 : screenHeight,
      ),
      child: child,
    );
  }
}