import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Entretenimento extends StatefulWidget {
  const Entretenimento({super.key});

  @override
  State<Entretenimento> createState() => _EntretenimentoState();
}

class _EntretenimentoState extends State<Entretenimento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1920.sp,
      height: 790.sp,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('lib/assets/images/FundoAzulSite.jpg'),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 550.sp,
                child: Text(
                  'ENTRETERIMENTO\nGARANTIDO!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 63.sp,
                      fontFamily: 'EutoStile',
                      fontWeight: FontWeight.w700,
                      height: 1),
                ),
              ),
              SizedBox(
                height: 30.sp,
              ),
              SizedBox(
                width: 826.sp,
                height: 109.sp,
                child: Text(
                  'Confira todas as novidades relacionadas aos novos filmes, séries e músicas em nossos apps de streaming. ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.sp,
                    fontFamily: 'EutoStile',
                    fontWeight: FontWeight.w200,
                    height: 0.95,
                  ),
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Container(
                width: 400.sp,
                height: 70.sp,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.00, 0.04),
                    end: Alignment(-1, -0.04),
                    colors: [
                      Color(0xFFFFD06A),
                      Color(0xFFFFB000),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.sp),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'GARANTIR DIVERSÃO',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'EutoStile',
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100.sp,
          ),
          Container(
            height: 600.sp,
            width: 675.sp,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'lib/assets/images/pipoca.png',
                    ),
                    fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}
