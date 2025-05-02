import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NosLigamos extends StatefulWidget {
  const NosLigamos({super.key});

  @override
  State<NosLigamos> createState() => _NosLigamosState();
}

class _NosLigamosState extends State<NosLigamos> {
  bool isHovered = false;
  bool _isVisible = false; // Controla a visibilidade do widget

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return VisibilityDetector(
          key: Key('animate-text'),
          onVisibilityChanged: (visibilityInfo) {
            // Verifica se 50% do texto está visível
            if (visibilityInfo.visibleFraction >= 0.3) {
              setState(() {
                _isVisible = true; // Inicia animação
              });
            } else {
              setState(() {
                _isVisible = false; // Não mostra animação
              });
            }
          },
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 150.sp),
              child: Container(
                height: 295.sp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _isVisible
                        ? Container(
                            height: 50.sp,
                            width: 50.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              color: Color(0xff13294E),
                            ),
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 40.sp,
                            ),
                          )
                            .animate() // Animação aplicada ao widget
                            .fadeIn(
                              begin: 0,
                              duration: Duration(seconds: 1),
                            )
                            .moveX(
                              end: 0,
                              begin: -30,
                              duration: Duration(seconds: 1),
                            )
                        : Container(
                            height: 50.sp,
                            width: 50.sp,
                          ),
                    SizedBox(width: 20.sp),
                    // Use VisibilityDetector para monitorar o widget e disparar a animação
                    _isVisible
                        ? Column(
                            children: [
                              SizedBox(
                                width: 355.sp,
                                child: Text(
                                  'Nós ligamos\npara você',
                                  style: TextStyle(
                                    color: Color(0xFF13294E),
                                    fontSize: 70.sp,
                                    fontFamily: 'EutoStile',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -3.48,
                                    height: 0.8,
                                  ),
                                ),
                              )
                                  .animate() // Animação aplicada ao widget
                                  .fadeIn(
                                    begin: 0,
                                    duration: Duration(seconds: 1),
                                  )
                                  .moveX(
                                    end: 0,
                                    begin: -30,
                                    duration: Duration(seconds: 1),
                                  ),
                              SizedBox(height: 15.sp),
                              SizedBox(
                                width: 350.sp,
                                child: Text(
                                  'Deixe o seu número para que nossa equipe na Velocitynet Telecom entre em contato para resolver o seu problema.',
                                  style: TextStyle(
                                    color: Color(0xFF7A7A7A),
                                    fontSize: 18.sp,
                                    fontFamily: 'EutoStile',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              )
                                  .animate() // Animação aplicada ao widget
                                  .fadeIn(
                                    begin: 0,
                                    duration: Duration(seconds: 1),
                                  )
                                  .moveX(
                                    end: 0,
                                    begin: -30,
                                    duration: Duration(milliseconds: 800),
                                  ),
                              SizedBox(height: 20.sp),
                              _isVisible
                                  ? MouseRegion(
                                      onEnter: (_) {
                                        setState(() {
                                          isHovered = true;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          isHovered = false;
                                        });
                                      },
                                      child: Container(
                                        width: 350.sp,
                                        height: 70.sp,
                                        decoration: BoxDecoration(
                                          color: isHovered
                                              ? Color(0xff13294E)
                                              : Color(0xFFFFB000),
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                          boxShadow: isHovered
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ]
                                              : [],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Liguem para mim',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.sp,
                                              fontFamily:
                                                  'Eurostile Next LT Pro',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                          .animate() // Animação aplicada ao widget
                                          .fadeIn(
                                            begin: 0,
                                            duration: Duration(seconds: 2),
                                          )
                                          .moveY(
                                            end: 0,
                                            begin: 40,
                                            duration: Duration(seconds: 1),
                                          ))
                                  : Container(
                                      width: 350.sp,
                                      height: 70.sp,
                                    )
                            ],
                          )
                        : Container(
                            // color: Colors.amber,
                            height: 10.sp,
                            width: 355.sp,
                          ),
                    SizedBox(width: 35.sp),
                    _isVisible
                        ? Column(
                            children: [
                              Container(
                                width: 450.sp,
                                height: 60.sp,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF4F4F4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.sp),
                              Container(
                                width: 450.sp,
                                height: 200.sp,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF4F4F4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                ),
                              ),
                            ],
                          )
                            .animate() // Animação aplicada ao widget
                            .fadeIn(
                              begin: 0,
                              duration: Duration(seconds: 1),
                            )
                            .moveX(
                              end: 0,
                              begin: 30,
                              duration: Duration(seconds: 1),
                            )
                        : Container(
                            width: 450.sp,
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
