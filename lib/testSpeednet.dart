import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speedtest/flutter_speedtest.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String _status = "Pronto para testar";

  List<double> _downloadSpeeds = [];
  List<double> _uploadSpeeds = [];
  Timer? _updateTimer;

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchProviderAndLocation();
  }

  Future<void> _fetchProviderAndLocation() async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'))
          .timeout(const Duration(seconds: 5));
      
      if (mounted && response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _isp = data['isp'] ?? 'Provedor indisponível';
          _location = '${data['city']}, ${data['country']}';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isp = 'Provedor indisponível';
          _location = 'Localização indisponível';
        });
      }
    }
  }

  void _startSpeedTest() async {
    if (_isTesting || !mounted) return;

    setState(() {
      _isTesting = true;
      _progressDownload = 0;
      _progressUpload = 0;
      _ping = 0;
      _jitter = 0;
      _downloadSpeeds.clear();
      _uploadSpeeds.clear();
      _status = "Testando...";
    });

    _updateTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!_isTesting || !mounted) {
        timer.cancel();
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
          if (mounted) {
            setState(() {
              _progressDownload = transferRate;
              _status = "Testando download... ${percent.toStringAsFixed(1)}%";
            });
          }
        },
        uploadOnProgress: (percent, transferRate) {
          if (mounted) {
            setState(() {
              _progressUpload = transferRate;
              _status = "Testando upload... ${percent.toStringAsFixed(1)}%";
            });
          }
        },
        progressResponse: (responseTime, jitter) {
          if (mounted) {
            setState(() {
              _ping = responseTime;
              _jitter = jitter;
            });
          }
        },
        onError: (errorMessage) {
          if (mounted) {
            setState(() {
              _status = "Erro: $errorMessage";
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro: $errorMessage')),
            );
          }
        },
        onDone: () {
          if (mounted) {
            setState(() {
              _status = "Teste concluído";
              _isTesting = false;
            });
            _calculateAverages();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Teste concluído com sucesso!')),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _status = "Erro no teste";
          _isTesting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro inesperado: $e')),
        );
      }
    } finally {
      _updateTimer?.cancel();
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
          'Upload: ${avgUpload.toStringAsFixed(2)} Mbps'),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final download = _progressDownload * 10;
    final upload = _progressUpload * 10;
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Teste de Velocidade'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Espaço flexível que empurra o conteúdo para baixo
            Expanded(child: Container()),
            
            // Conteúdo principal alinhado no final
            Padding(
              padding: EdgeInsets.all(isMobile ? 16.sp : 24.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Status do teste
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: _isTesting ? Colors.blue[50] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _status,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 16.sp : 18.sp,
                            fontWeight: FontWeight.w500,
                            color: _isTesting ? Colors.blue : Colors.grey[800],
                          ),
                        ),
                        if (_isTesting) SizedBox(height: 8.sp),
                        if (_isTesting)
                          LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            backgroundColor: Colors.blue[100],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.sp),

                  // Primeira linha com 2 cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSpeedCard(
                        icon: Icons.download,
                        title: "Download",
                        value: download,
                        unit: "Mbps",
                        isMobile: isMobile,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 16.sp),
                      _buildSpeedCard(
                        icon: Icons.upload,
                        title: "Upload",
                        value: upload,
                        unit: "Mbps",
                        isMobile: isMobile,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.sp),

                  // Segunda linha com 2 cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSpeedCard(
                        icon: Icons.network_check,
                        title: "Ping",
                        value: _ping.toDouble(),
                        unit: "ms",
                        isMobile: isMobile,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 16.sp),
                      _buildSpeedCard(
                        icon: Icons.signal_cellular_alt,
                        title: "Jitter",
                        value: _jitter.toDouble(),
                        unit: "ms",
                        isMobile: isMobile,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),

                  // Informações da rede
                  _buildNetworkInfoCard(isMobile),
                  SizedBox(height: 20.sp),

                  // Botão de ação
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _isTesting ? null : _startSpeedTest,
                      icon: Icon(
                        _isTesting ? Icons.refresh : Icons.speed,
                        size: isMobile ? 20.sp : 24.sp,
                      ),
                      label: Text(
                        _isTesting ? 'TESTE EM ANDAMENTO' : 'INICIAR TESTE',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16.sp : 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24.sp : 32.sp,
                          vertical: isMobile ? 12.sp : 16.sp,
                        ),
                        backgroundColor: _isTesting ? Colors.grey : Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedCard({
    required IconData icon,
    required String title,
    required double value,
    required String unit,
    required bool isMobile,
    required Color color,
  }) {
    return Container(
      width: isMobile ? 150.sp : 180.sp,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: isMobile ? 32.sp : 40.sp,
                color: color,
              ),
              SizedBox(height: 12.sp),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14.sp : 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                "${value.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 20.sp : 24.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.sp),
              Text(
                unit,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14.sp : 16.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkInfoCard(bool isMobile) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.public, size: 20.sp, color: Colors.blue),
                SizedBox(width: 8.sp),
                Text(
                  "Informações da Rede",
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16.sp : 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.sp),
            _buildInfoRow("Provedor:", _isp ?? "Carregando...", isMobile: isMobile),
            SizedBox(height: 8.sp),
            _buildInfoRow("Localização:", _location ?? "Carregando...", isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 14.sp : 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 4.sp),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 14.sp : 16.sp,
          ),
        ),
      ],
    );
  }
}