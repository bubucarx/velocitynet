import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speedtest/flutter_speedtest.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Testspeednet extends StatefulWidget {
  const Testspeednet({super.key});

  @override
  State<Testspeednet> createState() => _TestspeednetState();
}

class _TestspeednetState extends State<Testspeednet> {
  final _speedtest = FlutterSpeedtest(
    baseUrl: 'https://speedtest.globalxtreme.net:8080',
    pathDownload: '/download',
    pathUpload: '/upload',
    pathResponseTime: '/ping',
  );

  double _progressDownload = 0;
  double _progressUpload = 0;
  int _ping = 0;
  int _jitter = 0;
  bool _isTesting = false;
  String? _isp;
  String? _location;

  List<double> _downloadSpeeds = [];
  List<double> _uploadSpeeds = [];

  @override
  void initState() {
    super.initState();
    _fetchProviderAndLocation();
  }

  Future<void> _fetchProviderAndLocation() async {
    final response = await http.get(Uri.parse('http://ip-api.com/json/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _isp = data['isp'] ?? 'Provedor indisponível';
        _location = '${data['city']}, ${data['country']}';
      });
    } else {
      setState(() {
        _isp = 'Provedor indisponível';
        _location = 'Localização indisponível';
      });
    }
  }

  void _startSpeedTest() async {
    if (_isTesting) return;

    setState(() {
      _isTesting = true;
      _progressDownload = 0;
      _progressUpload = 0;
      _ping = 0;
      _jitter = 0;
      _downloadSpeeds.clear();
      _uploadSpeeds.clear();
    });

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_downloadSpeeds.length >= 20) {
        // 10 segundos (20 ciclos de 500ms)
        timer.cancel();
        _calculateAverages();
        setState(() {
          _isTesting = false;
        });
        return;
      }
      setState(() {
        _downloadSpeeds.add(_progressDownload);
        _uploadSpeeds.add(_progressUpload);
      });
    });

    try {
      await _speedtest.getDataspeedtest(
        downloadOnProgress: (percent, transferRate) {
          setState(() {
            _progressDownload = transferRate;
          });
        },
        uploadOnProgress: (percent, transferRate) {
          setState(() {
            _progressUpload = transferRate;
          });
        },
        progressResponse: (responseTime, jitter) {
          setState(() {
            _ping = responseTime;
            _jitter = jitter;
          });
        },
        onError: (errorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro: $errorMessage')),
          );
        },
        onDone: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Teste concluído com sucesso!')),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro inesperado: $e')),
      );
    }
  }

  void _calculateAverages() {
    final avgDownload = _downloadSpeeds.isNotEmpty
        ? _downloadSpeeds.reduce((a, b) => a + b) / _downloadSpeeds.length
        : 0;
    final avgUpload = _uploadSpeeds.isNotEmpty
        ? _uploadSpeeds.reduce((a, b) => a + b) / _uploadSpeeds.length
        : 0;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Média - Download: ${avgDownload.toStringAsFixed(2)} Mbps, '
          'Upload: ${avgUpload.toStringAsFixed(2)} Mbps',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final download = _progressDownload * 10;
    final upload = _progressUpload * 10;

    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return Container(
          height: 710.sp,
          width: 1920.sp,
          padding: EdgeInsets.all(20.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Teste de Velocidade',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.sp),
              Text(
                'Download: ${download.toStringAsFixed(2)} Mbps',
                style: TextStyle(fontSize: 28.sp),
              ),
              Text(
                'Upload: ${upload.toStringAsFixed(2)} Mbps',
                style: TextStyle(fontSize: 28.sp),
              ),
              Text(
                'Ping: $_ping ms',
                style: TextStyle(fontSize: 28.sp),
              ),
              Text(
                'Jitter: $_jitter ms',
                style: TextStyle(fontSize: 28.sp),
              ),
              SizedBox(height: 20.sp),
              Text(
                'Provedor: ${_isp ?? "Carregando..."}',
                style: TextStyle(fontSize: 24.sp),
              ),
              Text(
                'Localização: ${_location ?? "Carregando..."}',
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(height: 40.sp),
              ElevatedButton.icon(
                onPressed: _startSpeedTest,
                icon: Icon(Icons.speed, size: 30.sp),
                label: Text(
                  _isTesting ? 'Testando...' : 'Iniciar Teste',
                  style: TextStyle(fontSize: 28.sp),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.sp,
                    vertical: 20.sp,
                  ),
                  backgroundColor: _isTesting ? Colors.grey : Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
