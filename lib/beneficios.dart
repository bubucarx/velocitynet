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
  @override
  Widget build(BuildContext context) {
    return DynMouseScroll(
      durationMS: 2000,
      scrollSpeed: 1.9,
      animationCurve: Curves.easeOutQuart,
      builder: (context, controller, physics) {
        return Stack(
          children: [
            ListView(
              controller: controller,
              physics: physics,
              children: [
                Entretenimento(),
                Deezer(),
                SizedBox(
                  height: 200.sp,
                ),
                Max(),
                SizedBox(
                  height: 200.sp,
                ),
                Globoplay(),
                SizedBox(
                  height: 200.sp,
                ),
                Telecine(),
                SizedBox(
                  height: 200.sp,
                ),
                Premiere(),
                SizedBox(
                  height: 200.sp,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
