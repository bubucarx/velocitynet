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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final designSize =
            isMobile ? const Size(360, 800) : const Size(1920, 1080);

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
                  vertical: isMobile ? 50.h : 180.h,
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
      height: 415.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhoneIcon(),
          SizedBox(width: 40.w),
          _buildContactInfo(isMobile: false),
          SizedBox(width: 60.w),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPhoneIcon(),
        SizedBox(height: 30.h),
        _buildContactInfo(isMobile: true),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _buildPhoneIcon() {
    return _isVisible
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 80.h,
                width: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: const Color(0xff13294E),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Icon(
                  PhosphorIcons.phone_call_fill,
                  color: Colors.white,
                  size: 40.h,
                ),
              ).animate().fadeIn(duration: 600.ms).scale(duration: 600.ms),
            ],
          )
        : Container(height: 80.h, width: 80.h);
  }

  Widget _buildContactInfo({required bool isMobile}) {
    return _isVisible
        ? Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 350.w,
                child: isMobile
                    ? Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Atendimento Personalizado\n',
                                style: TextStyle(
                                  color: const Color(0xFF13294E),
                                  fontSize: 32.sp,
                                  fontFamily: 'EutoStile',
                                  fontWeight: FontWeight.w800,
                                  height: 1.3,
                                ),
                              ),
                              TextSpan(
                                text: 'Soluções sob medida para você',
                                style: TextStyle(
                                  color:
                                      const Color(0xFF13294E).withOpacity(0.7),
                                  fontSize: 18.sp,
                                  fontFamily: 'EutoStile',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .moveX(begin: -30, end: 0),
                      )
                    : RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Atendimento Personalizado\n',
                              style: TextStyle(
                                color: const Color(0xFF13294E),
                                fontSize: 32.sp,
                                fontFamily: 'EutoStile',
                                fontWeight: FontWeight.w800,
                                height: 1.3,
                              ),
                            ),
                            TextSpan(
                              text: 'Soluções sob medida para você',
                              style: TextStyle(
                                color: const Color(0xFF13294E).withOpacity(0.7),
                                fontSize: 18.sp,
                                fontFamily: 'EutoStile',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .moveX(begin: -30, end: 0),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: 350.w,
                child: isMobile
                    ? Center(
                        child: Text(
                          'Nossa equipe de especialistas está pronta para entender suas necessidades e oferecer a melhor solução em telecomunicações. Deixe seus dados que retornaremos imediatamente.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF7A7A7A),
                            fontSize: 16.sp,
                            fontFamily: 'EutoStile',
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 800.ms)
                            .moveX(begin: -30, end: 0),
                      )
                    : Text(
                        'Nossa equipe de especialistas está pronta para entender suas necessidades e oferecer a melhor solução em telecomunicações. Deixe seus dados que retornaremos imediatamente.',
                        style: TextStyle(
                          color: const Color(0xFF7A7A7A),
                          fontSize: 16.sp,
                          fontFamily: 'EutoStile',
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                        ),
                      )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .moveX(begin: -30, end: 0),
              ),
              SizedBox(height: 30.h),
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
            child: AnimatedContainer(
              duration: 300.ms,
              width: 340.w,
              height: 70.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 0, 204, 119),
                    const Color.fromARGB(255, 0, 153, 20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: const Color(0xFF004799).withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    launch(
                        "https://api.whatsapp.com/send?phone=+559499260-0430&text=Olá, tudo bem?");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10.w),
                      Icon(
                        PhosphorIcons.whatsapp_logo_fill,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12.sp),
                      Text(
                        'Fale conosco!',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 1.seconds).moveY(begin: 40, end: 0))
        : Container(width: 350.w, height: 70.h);
  }
}
