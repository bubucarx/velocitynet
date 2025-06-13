import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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

  double downloadSpeed = 0;
  double uploadSpeed = 0;
  int ping = 0;
  int jitter = 0;

  bool isTesting = false;
  String status = "Toque para iniciar o teste";
  String? isp;
  String? location;

  @override
  void initState() {
    super.initState();
    _getLocationInfo();
  }

  Future<void> _getLocationInfo() async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));
      final data = json.decode(response.body);
      setState(() {
        isp = data['isp'];
        location = "${data['city']}, ${data['country']}";
      });
    } catch (_) {
      setState(() {
        isp = 'Desconhecido';
        location = 'Indisponível';
      });
    }
  }

  void _startTest() async {
    setState(() {
      isTesting = true;
      status = "Iniciando teste...";
      downloadSpeed = 0;
      uploadSpeed = 0;
      ping = 0;
      jitter = 0;
    });

    try {
      await _speedtest.getDataspeedtest(
        downloadOnProgress: (percent, rate) {
          setState(() {
            downloadSpeed = rate;
            status = "Testando download...";
          });
        },
        uploadOnProgress: (percent, rate) {
          setState(() {
            uploadSpeed = rate;
            status = "Testando upload...";
          });
        },
        progressResponse: (p, j) {
          setState(() {
            ping = p;
            jitter = j;
          });
        },
        onDone: () {
          setState(() {
            isTesting = false;
            status = "Teste concluído";
          });
        },
        onError: (err) {
          setState(() {
            status = "Erro: $err";
            isTesting = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        status = "Erro inesperado";
        isTesting = false;
      });
    }
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 48, 109),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 80),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 80),
                const SizedBox(height: 12),
                Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: isTesting ? null : _startTest,
                  child: Container(
                    width: isMobile ? 200 : 280,
                    height: isMobile ? 200 : 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Center(
                      child: isTesting
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 5,
                            )
                          : Text(
                              'INICIAR',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    _buildMetricCard('Download', '${downloadSpeed.toStringAsFixed(2)} Mbps', Icons.download, Colors.blue),
                    _buildMetricCard('Upload', '${uploadSpeed.toStringAsFixed(2)} Mbps', Icons.upload, Colors.green),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildMetricCard('Ping', '$ping ms', Icons.network_ping, Colors.orange),
                    _buildMetricCard('Jitter', '$jitter ms', Icons.wifi_tethering, Colors.purple),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Informações da Rede",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("Provedor: ${isp ?? 'Carregando...'}",
                          style: GoogleFonts.poppins()),
                      Text("Localização: ${location ?? 'Carregando...'}",
                          style: GoogleFonts.poppins()),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
