// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_speedtest/flutter_speedtest.dart';
// import 'package:http/http.dart' as http;

// class Testedevelocidade extends StatefulWidget {
//   const Testedevelocidade({super.key});

//   @override
//   State<Testedevelocidade> createState() => _TestedevelocidadeState();
// }

// class _TestedevelocidadeState extends State<Testedevelocidade> {
//   final _speedtest = FlutterSpeedtest(
//     baseUrl: 'https://speedtest.globalxtreme.net:8080',
//     pathDownload: '/download',
//     pathUpload: '/upload',
//     pathResponseTime: '/ping',
//   );

//   double _progressDownload = 0;
//   double _progressUpload = 0;
//   int _ping = 0;
//   int _jitter = 0;
//   bool _isTesting = false;
//   String? _isp;
//   String? _location;
//   String _testStatus = 'PRONTO PARA O TESTE';

//   List<double> _downloadSpeeds = [];
//   List<double> _uploadSpeeds = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchProviderAndLocation();
//   }

//   Future<void> _fetchProviderAndLocation() async {
//     try {
//       final response = await http.get(Uri.parse('http://ip-api.com/json/'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _isp = data['isp'] ?? 'Provedor desconhecido';
//           _location =
//               '${data['city'] ?? 'Local desconhecido'}, ${data['country'] ?? 'País desconhecido'}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _isp = 'Provedor desconhecido';
//         _location = 'Localização desconhecida';
//       });
//     }
//   }

//   void _startSpeedTest() async {
//     if (_isTesting) return;

//     setState(() {
//       _isTesting = true;
//       _progressDownload = 0;
//       _progressUpload = 0;
//       _ping = 0;
//       _jitter = 0;
//       _downloadSpeeds.clear();
//       _uploadSpeeds.clear();
//       _testStatus = 'Testando download...';
//     });

//     Timer? timer;
//     timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
//       if (_downloadSpeeds.length >= 20) {
//         timer.cancel();
//         _calculateAverages();
//         setState(() {
//           _isTesting = false;
//           _testStatus = 'Teste concluído';
//         });
//         return;
//       }
//       setState(() {
//         _downloadSpeeds.add(_progressDownload);
//         _uploadSpeeds.add(_progressUpload);
//       });
//     });

//     try {
//       await _speedtest.getDataspeedtest(
//         downloadOnProgress: (percent, transferRate) {
//           setState(() {
//             _progressDownload = transferRate;
//             _testStatus = 'Testando download... ${percent.toStringAsFixed(0)}%';
//           });
//         },
//         uploadOnProgress: (percent, transferRate) {
//           setState(() {
//             _progressUpload = transferRate;
//             _testStatus = 'Testando upload... ${percent.toStringAsFixed(0)}%';
//           });
//         },
//         progressResponse: (responseTime, jitter) {
//           setState(() {
//             _ping = responseTime;
//             _jitter = jitter;
//           });
//         },
//         onError: (errorMessage) {
//           timer?.cancel();
//           setState(() {
//             _testStatus = 'Ocorreu um erro';
//             _isTesting = false;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Erro: $errorMessage')),
//           );
//         },
//         onDone: () {
//           timer?.cancel();
//           setState(() {
//             _testStatus = 'Teste concluído';
//             _isTesting = false;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Teste concluído com sucesso!')),
//           );
//         },
//       );
//     } catch (e) {
//       timer?.cancel();
//       setState(() {
//         _testStatus = 'Ocorreu um erro';
//         _isTesting = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Erro inesperado: $e')),
//       );
//     }
//   }

//   void _calculateAverages() {
//     final avgDownload = _downloadSpeeds.isNotEmpty
//         ? _downloadSpeeds.reduce((a, b) => a + b) / _downloadSpeeds.length
//         : 0;
//     final avgUpload = _uploadSpeeds.isNotEmpty
//         ? _uploadSpeeds.reduce((a, b) => a + b) / _uploadSpeeds.length
//         : 0;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Média - Download: ${avgDownload.toStringAsFixed(2)} Mbps, '
//           'Upload: ${avgUpload.toStringAsFixed(2)} Mbps',
//         ),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   Widget _buildSpeedGauge(String title, double speed, Color color) {
//     final maxSpeed = 100.0;
//     final percentage = speed / maxSpeed;
//     final gradientColors = [
//       color.withOpacity(0.7),
//       color,
//       color.withOpacity(0.9),
//     ];

//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 22.sp,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//           ),
//         ),
//         SizedBox(height: 15.sp),
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             SizedBox(
//               width: 200.sp,
//               height: 200.sp,
//               child: CircularProgressIndicator(
//                 value: percentage > 1 ? 1 : percentage,
//                 strokeWidth: 14.sp,
//                 backgroundColor: Colors.white.withOpacity(0.1),
//                 valueColor: AlwaysStoppedAnimation<Color>(color),
//               ),
//             ),
//             Container(
//               width: 170.sp,
//               height: 170.sp,
//               decoration: BoxDecoration(
//                 gradient: RadialGradient(
//                   colors: gradientColors,
//                   center: Alignment.center,
//                   radius: 0.7,
//                 ),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: color.withOpacity(0.4),
//                     blurRadius: 15,
//                     spreadRadius: 2,
//                   )
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       speed.toStringAsFixed(2),
//                       style: TextStyle(
//                         fontSize: 36.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         shadows: [
//                           Shadow(
//                             blurRadius: 10,
//                             color: Colors.black.withOpacity(0.3),
//                           )
//                         ],
//                       ),
//                     ),
//                     Text(
//                       'Mbps',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         color: Colors.white.withOpacity(0.8),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildPingInfo() {
//     return Container(
//       padding: EdgeInsets.all(20.sp),
//       decoration: BoxDecoration(
//         color: Color(0xFF1A2E4A),
//         borderRadius: BorderRadius.circular(16.sp),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 10,
//             spreadRadius: 2,
//           )
//         ],
//         border: Border.all(
//           color: Color(0xFF2E4A7A),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             'QUALIDADE DA CONEXÃO',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 15.sp),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildPingItem(
//                   'PING',
//                   '$_ping ms',
//                   _ping < 50
//                       ? Colors.green
//                       : _ping < 100
//                           ? Colors.orange
//                           : Colors.red),
//               Container(
//                 width: 1,
//                 height: 40.sp,
//                 color: Colors.white.withOpacity(0.2),
//               ),
//               _buildPingItem(
//                   'JITTER',
//                   '$_jitter ms',
//                   _jitter < 10
//                       ? Colors.green
//                       : _jitter < 30
//                           ? Colors.orange
//                           : Colors.red),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPingItem(String title, String value, Color color) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16.sp,
//             color: Colors.white.withOpacity(0.9),
//           ),
//         ),
//         SizedBox(height: 5.sp),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(20.sp),
//             border: Border.all(
//               color: color.withOpacity(0.5),
//               width: 1.5,
//             ),
//           ),
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 22.sp,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildConnectionInfo() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.sp),
//       decoration: BoxDecoration(
//         color: Color(0xFF1A2E4A),
//         borderRadius: BorderRadius.circular(16.sp),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 10,
//             spreadRadius: 2,
//           )
//         ],
//         border: Border.all(
//           color: Color(0xFF2E4A7A),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.info_outline,
//                   size: 22.sp, color: Color(0xFF4A90E2)),
//               SizedBox(width: 8.sp),
//               Text(
//                 'INFORMAÇÕES DE CONEXÃO',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15.sp),
//           _buildInfoRow('Provedor:', _isp ?? "Carregando...", Icons.business),
//           SizedBox(height: 10.sp),
//           _buildInfoRow(
//               'Localização:', _location ?? "Carregando...", Icons.location_on),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value, IconData icon) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 20.sp, color: Color(0xFF4A90E2)),
//         SizedBox(width: 10.sp),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.white.withOpacity(0.8),
//                 ),
//               ),
//               SizedBox(height: 2.sp),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusIndicator() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
//       decoration: BoxDecoration(
//         color: _isTesting ? Color(0xFF1A2E4A) : Color(0xFF1E4A1A),
//         borderRadius: BorderRadius.circular(24.sp),
//         border: Border.all(
//           color: _isTesting ? Color(0xFF4A90E2) : Colors.green,
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 10,
//             spreadRadius: 1,
//           )
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             _isTesting ? Icons.autorenew : Icons.check_circle,
//             size: 20.sp,
//             color: _isTesting ? Color(0xFF4A90E2) : Colors.green,
//           ),
//           SizedBox(width: 8.sp),
//           Text(
//             _testStatus,
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: _isTesting ? Color(0xFF4A90E2) : Colors.green,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTestButton() {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         transformAlignment: Alignment.center,
//         transform: _isTesting ? Matrix4.identity() : Matrix4.identity()
//           ..scale(1.0),
//         child: ElevatedButton(
//           onPressed: _isTesting ? null : _startSpeedTest,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: _isTesting ? Colors.grey.shade800 : Color(0xFF4A90E2),
//             padding: EdgeInsets.symmetric(
//               horizontal: 40.sp,
//               vertical: 20.sp,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.sp),
//             ),
//             elevation: 8,
//             shadowColor: Colors.blue.withOpacity(0.4),
//             animationDuration: const Duration(milliseconds: 300),
//             enableFeedback: true,
//             splashFactory: InkRipple.splashFactory,
//           ),
//           child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300),
//             child: _isTesting
//                 ? SizedBox(
//                     width: 24.sp,
//                     height: 24.sp,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 3,
//                       color: Colors.white,
//                     ),
//                   )
//                 : Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.speed,
//                         size: 30.sp,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 12.sp),
//                       Text(
//                         'INICIAR TESTE',
//                         style: TextStyle(
//                           fontSize: 24.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 1.1,
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final download = _progressDownload * 10;
//     final upload = _progressUpload * 10;

//     return ScreenUtilInit(
//       designSize: const Size(1920, 1080),
//       splitScreenMode: true,
//       minTextAdapt: true,
//       builder: (context, child) {
//         return Scaffold(
//           backgroundColor: Color(0xFF0F1E3D),
//           body: Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xFF13294E),
//                       Color(0xFF0A1A30),
//                     ],
//                   ),
//                 ),
//               ),

//               Column(
//                 children: [
//                   Container(
//                     height: 100.sp,
//                     decoration: BoxDecoration(
//                       color: Color(0xFF13294E),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.4),
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                         )
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         'VelocityNet',
//                         style: TextStyle(
//                           fontSize: 36.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 1.5,
//                         ),
//                       ),
//                     ),
//                   ),

//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: EdgeInsets.all(20.sp),
//                       child: Center(
//                         child: Container(
//                           constraints: BoxConstraints(maxWidth: 900.sp),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               _buildStatusIndicator(),
//                               SizedBox(height: 50.sp),

//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   _buildSpeedGauge(
//                                       'DOWNLOAD', download, Color(0xFF4A90E2)),
//                                   _buildSpeedGauge(
//                                       'UPLOAD', upload, Color(0xFF2ECC71)),
//                                 ],
//                               ),
//                               SizedBox(height: 50.sp),

//                               _buildPingInfo(),
//                               SizedBox(height: 50.sp),

//                               _buildConnectionInfo(),
//                               SizedBox(height: 50.sp),

//                               _buildTestButton(),
//                               SizedBox(height: 30.sp),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }