import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Premiere extends StatefulWidget {
  const Premiere({super.key});

  @override
  State<Premiere> createState() => _PremiereState();
}

class _PremiereState extends State<Premiere> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1920, 1080),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return Container(
            child: Column(
              children: [
                Container(
                  width: 650.sp,
                  height: 100.sp,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('lib/assets/images/premiere/Premiere.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.sp,
                ),
                SizedBox(
                  width: 1040.sp,
                  child: Text(
                    'O Premiere, com a maior cobertura do futebol nacional, exibe os jogos ao vivo dos campeonatos estaduais 2023 (Gaúcho, Paulista, Mineiro) para seus assinantes, além da Copa do Brasil 2023 e do Campeonato Brasileiro Série A e B 2023 dos clubes que cederam direitos à Globo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF13294E),
                      fontSize: 20.sp,
                      fontFamily: 'EutoStile',
                      fontWeight: FontWeight.w700,
                      height: 0.95,
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 315.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _containerImage(
                          Foto: 'lib/assets/images/premiere/image1.jpg',
                          Titulo: 'BRASILEIRÃO\nSÉRIE A e B'),
                      _containerImage(
                          Foto: 'lib/assets/images/premiere/image2.jpg',
                          Titulo: 'COPA DO BRASIL'),
                      _containerImage(
                          Foto: 'lib/assets/images/premiere/image3.jpg',
                          Titulo: 'CAMPEONATO\nPAULISTA')
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

Widget _containerImage({required String Foto, required String Titulo}) {
  return Container(
    height: 365.sp,
    child: Column(
      children: [
        Container(
          width: 400.sp,
          height: 300.sp,
          decoration: ShapeDecoration(
            image: DecorationImage(image: AssetImage(Foto)),
            color: Color(0xFFD9D9D9),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.green, width: 5.sp),
              borderRadius: BorderRadius.circular(
                10.sp,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Text(
          textAlign: TextAlign.center,
          Titulo,
          style: TextStyle(
            fontFamily: 'EutoStile',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 0.95,
          ),
        )
      ],
    ),
  );
}
