import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speedtest/flutter_speedtest.dart';

class TesteDeVelocidade extends StatefulWidget {
  const TesteDeVelocidade({super.key});

  @override
  State<TesteDeVelocidade> createState() => _TesteDeVelocidadeState();
}

class _TesteDeVelocidadeState extends State<TesteDeVelocidade> {
  final _speedtest = FlutterSpeedtest(
    baseUrl: 'https://speedtest.globalxtreme.net:8080',
    pathDownload: '/download',
    pathUpload: '/upload',
    pathResponseTime: '/ping',
  );

  double _progressDownload = 0;
  double _progressUpload = 0;
  bool _isTesting = false;
  String _testStatus = 'PRONTO PARA TESTE';

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0F1E3D),
          body: Stack(
            children: [
              // Fundo gradiente
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF13294E),
                      Color(0xFF0A1A30),
                    ],
                  ),
                ),
              ),

              // Conteúdo principal
              Column(
                children: [
                  // Cabeçalho
                  Container(
                    height: 100.sp,
                    decoration: BoxDecoration(
                      color: const Color(0xFF13294E),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'VelocityScan',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),

                  // Corpo do teste
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Indicadores de velocidade
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSpeedGauge(
                                'DOWNLOAD',
                                _progressDownload * 10,
                                const Color(0xFF4A90E2),
                              ),
                              _buildSpeedGauge(
                                'UPLOAD',
                                _progressUpload * 10,
                                const Color(0xFF2ECC71),
                              ),
                            ],
                          ),

                          SizedBox(height: 50.sp),

                          // Status do teste
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.sp,
                              vertical: 12.sp,
                            ),
                            decoration: BoxDecoration(
                              color: _isTesting
                                  ? const Color(0xFF1A2E4A)
                                  : const Color(0xFF1E4A1A),
                              borderRadius: BorderRadius.circular(24.sp),
                              border: Border.all(
                                color: _isTesting
                                    ? const Color(0xFF4A90E2)
                                    : Colors.green,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              _testStatus,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: _isTesting
                                    ? const Color(0xFF4A90E2)
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: 50.sp),

                          // Botão de teste
                          _buildTestButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpeedGauge(String title, double speed, Color color) {
    final percentage = speed / 100;
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15.sp),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200.sp,
              height: 200.sp,
              child: CircularProgressIndicator(
                value: percentage > 1 ? 1 : percentage,
                strokeWidth: 14.sp,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Container(
              width: 170.sp,
              height: 170.sp,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    color.withOpacity(0.7),
                    color,
                    color.withOpacity(0.9),
                  ],
                  center: Alignment.center,
                  radius: 0.7,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      speed.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Mbps',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTestButton() {
    return ElevatedButton(
      onPressed: _isTesting ? null : _startSpeedTest,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _isTesting ? Colors.grey.shade800 : const Color(0xFF4A90E2),
        padding: EdgeInsets.symmetric(
          horizontal: 40.sp,
          vertical: 20.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.sp),
        ),
        elevation: 8,
        shadowColor: Colors.blue.withOpacity(0.4),
      ),
      child: _isTesting
          ? SizedBox(
              width: 24.sp,
              height: 24.sp,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            )
          : Text(
              'INICIAR TESTE',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }

  void _startSpeedTest() async {
    if (_isTesting) return;

    setState(() {
      _isTesting = true;
      _progressDownload = 0;
      _progressUpload = 0;
      _testStatus = 'TESTANDO CONEXÃO...';
    });

    try {
      await _speedtest.getDataspeedtest(
        downloadOnProgress: (percent, transferRate) {
          setState(() {
            _progressDownload = transferRate;
            _testStatus = 'DOWNLOAD: ${percent.toStringAsFixed(0)}%';
          });
        },
        uploadOnProgress: (percent, transferRate) {
          setState(() {
            _progressUpload = transferRate;
            _testStatus = 'UPLOAD: ${percent.toStringAsFixed(0)}%';
          });
        },
        onDone: () {
          setState(() {
            _testStatus = 'TESTE CONCLUÍDO';
            _isTesting = false;
          });
        },
        onError: (errorMessage) {
          setState(() {
            _testStatus = 'ERRO NO TESTE';
            _isTesting = false;
          });
        },
        progressResponse: (int responseTime, int jitter) {},
      );
    } catch (e) {
      setState(() {
        _testStatus = 'ERRO NO TESTE';
        _isTesting = false;
      });
    }
  }
}
