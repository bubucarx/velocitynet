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
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return ScreenUtilInit(
      designSize: isMobile ? const Size(360, 800) : const Size(1920, 1080),
      builder: (_, child) {
        return Container(
          width: double.infinity,
          height: isMobile ? null : 790.sp,
          padding: isMobile ? EdgeInsets.symmetric(vertical: 40.sp) : null,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('lib/assets/images/FundoAzulSite.jpg'),
            ),
          ),
          child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text Content
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
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 30.sp),
            SizedBox(
              width: 826.sp,
              height: 109.sp,
              child: Text(
                'Confira todas as novidades relacionadas aos novos filmes, séries e músicas em nossos apps de streaming.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w200,
                  height: 0.95,
                ),
              ),
            ),
            SizedBox(height: 15.sp),
            _buildButton(),
          ],
        ),
        SizedBox(width: 100.sp),
        // Image
        Container(
          height: 600.sp,
          width: 675.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/pipoca.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image on top for mobile
        Container(
          height: 300.sp,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 30.sp),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/pipoca.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        // Text Content
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ENTRETERIMENTO\nGARANTIDO!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              SizedBox(height: 20.sp),
              Text(
                'Confira todas as novidades relacionadas aos novos filmes, séries e músicas em nossos apps de streaming.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w200,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 25.sp),
              Center(child: _buildButton()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      width: isMobile ? 250.sp : 400.sp,
      height: isMobile ? 50.sp : 70.sp,
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
      child: Center(
        child: Text(
          'GARANTIR DIVERSÃO',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'EutoStile',
            fontSize: isMobile ? 18.sp : 35.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}