import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NosLigamos extends StatefulWidget {
  const NosLigamos({super.key});

  @override
  State<NosLigamos> createState() => _NosLigamosState();
}

class _NosLigamosState extends State<NosLigamos> {
  bool isHovered = false;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final designSize = isMobile ? const Size(360, 800) : const Size(1920, 1080);
        
        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return VisibilityDetector(
              key: const Key('animate-text'),
              onVisibilityChanged: (visibilityInfo) {
                if (visibilityInfo.visibleFraction >= 0.3) {
                  setState(() => _isVisible = true);
                } else {
                  setState(() => _isVisible = false);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 50.h : 150.h,
                  horizontal: isMobile ? 20.w : 0,
                ),
                child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      height: 395.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhoneIcon(),
          SizedBox(width: 20.w),
          _buildContactInfo(),
          SizedBox(width: 35.w),
          _buildFormFields(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPhoneIcon(),
        SizedBox(height: 20.h),
        _buildContactInfo(),
        SizedBox(height: 30.h),
        _buildFormFields(),
      ],
    );
  }

  Widget _buildPhoneIcon() {
    return _isVisible
        ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color(0xff13294E),
                ),
                child: Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 40.h,
                ),
              ).animate().fadeIn(duration: 1.seconds).moveX(begin: -30, end: 0),
          ],
        )
        : Container(height: 50.h, width: 50.h);
  }

  Widget _buildContactInfo() {
    return _isVisible
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 300.w,
                child: Text(
                  'Entre em contato Conosco!',
                  style: TextStyle(
                    color: const Color(0xFF13294E),
                    fontSize: 30.sp,
                    fontFamily: 'EutoStile',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ).animate().fadeIn(duration: 1.seconds).moveX(begin: -30, end: 0),
              SizedBox(height: 15.h),
              SizedBox(
                width: 350.w,
                child: Text(
                  'Deixe o seu número para que nossa equipe na Velocitynet Telecom entre em contato para resolver o seu problema.',
                  style: TextStyle(
                    color: const Color(0xFF7A7A7A),
                    fontSize: 16.sp,
                    fontFamily: 'EutoStile',
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ).animate().fadeIn(duration: 1.seconds).moveX(begin: -30, end: 0),
              SizedBox(height: 20.h),
              _buildContactButton(),
            ],
          )
        : Container(height: 10.h, width: 355.w);
  }

  Widget _buildContactButton() {
    return _isVisible
        ? MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              width: 350.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: isHovered ? const Color(0xff13294E) : const Color(0xFFFFB000),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    final phoneNumber = 'tel:+55 (94) 99132-6169';
                    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
                      await launchUrl(Uri.parse(phoneNumber));
                    }
                  },
                  child: Text(
                    'Nos contate!',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 2.seconds).moveY(begin: 40, end: 0))
        : Container(width: 350.w, height: 70.h);
  }

  Widget _buildFormFields() {
    return _isVisible
        ? Column(
            children: [
              Container(
                width: 450.w,
                height: 60.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 450.w,
                height: 200.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 1.seconds).moveX(begin: 30, end: 0)
        : Container(width: 450.w);
  }
}