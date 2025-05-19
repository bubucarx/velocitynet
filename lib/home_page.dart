import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:velocitynet/aplicativos.dart';
import 'package:velocitynet/appbar.dart';
import 'package:velocitynet/assets/nos_ligamos.dart';
import 'package:velocitynet/conexao_fibra.dart';
import 'package:velocitynet/contact.dart';
import 'package:velocitynet/deezer.dart';
import 'package:velocitynet/entretenimento.dart';
import 'package:velocitynet/footer.dart';
import 'package:velocitynet/globoplay.dart';
import 'package:velocitynet/max.dart';
import 'package:velocitynet/monte_seu_combo.dart';
import 'package:velocitynet/oletv.dart';
import 'package:velocitynet/premiere.dart';
import 'package:velocitynet/providerIndex.dart';
import 'package:velocitynet/telecine.dart';
import 'package:velocitynet/testSpeednet.dart';
import 'package:velocitynet/testedevelocidade.dart';
import 'package:velocitynet/trabalhe_conosco.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  double _previousOffset = 0.0;
  bool _scrollDirection = false;
  late double _scrollThreshold;
  double _opacity = 0.0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _scrollThreshold = MediaQuery.of(context).size.height * 0.7;
        });
      }
    });
  }

  void _onScroll(ScrollMetrics metrics) {
    final currentOffset = metrics.pixels;
    final newScrollDirection = currentOffset > _previousOffset;
    final newOpacity = currentOffset >= _scrollThreshold ? 0.65 : (currentOffset / _scrollThreshold).clamp(0.0, 0.65);

    if (mounted) {
      setState(() {
        _scrollDirection = newScrollDirection;
        _opacity = newOpacity;
      });
    }

    _previousOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final designSize = Size(
          constraints.maxWidth > 600 ? 1920 : 600,
          constraints.maxHeight > 800 ? 1080 : 800,
        );

        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: DynMouseScroll(
                  durationMS: 800,
                  scrollSpeed: 1.3,
                  animationCurve: Curves.easeOutQuart,
                  builder: (context, controller, physics) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification) {
                          _onScroll(notification.metrics);
                        }
                        return true;
                      },
                      child: Stack(
                        children: [
                          MeuWidget(scroll: controller, phs: physics),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Header(opacity: _opacity)
                                  .animate()
                                  .fadeIn(duration: _scrollDirection ? 0.ms : 400.ms, curve: Curves.easeOut)
                                  .move(
                                    delay: _scrollDirection ? 0.ms : 0.01.ms,
                                    duration: 400.ms,
                                    curve: Curves.easeOut,
                                    begin: _scrollDirection ? const Offset(0, 0) : const Offset(0, -105),
                                    end: _scrollDirection ? const Offset(0, -105) : const Offset(0, 0),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MeuWidget extends StatefulWidget {
  final ScrollController scroll;
  final ScrollPhysics phs;

  const MeuWidget({super.key, required this.phs, required this.scroll});

  @override
  _MeuWidgetState createState() => _MeuWidgetState();
}

class _MeuWidgetState extends State<MeuWidget> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = Provider.of<IndexProvider>(context).selectedIndex;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final imageHeight = isMobile ? 400.h : 850.h;
        final comboImageHeight = isMobile ? 800.h : 2020.h;

        switch (selectedIndex) {
          case 1:
            return ListView(
              children: [
                Entretenimento(),
                Deezer(),
                SizedBox(height: isMobile ? 100.h : 200.h),
                Max(),
                SizedBox(height: isMobile ? 100.h : 200.h),
                Globoplay(),
                SizedBox(height: isMobile ? 100.h : 200.h),
                Telecine(),
                SizedBox(height: isMobile ? 100.h : 200.h),
                Premiere(),
                SizedBox(height: isMobile ? 100.h : 200.h),
                Footer()
              ],
            );
          case 0:
            return ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFF13294E),
                    image: DecorationImage(
                      image: MediaQuery.of(context).size.width < 800
                          ? AssetImage('lib/assets/images/velocitybranco.png')
                          : AssetImage('lib/assets/images/ImagemPromocional.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                MonteSeuCombo(),
                ConexaoFibra(),
                Aplicativos(),
                NosLigamos(),
                Footer(),
              ],
            );
          case 2:
            return Oletv();
          case 3:
            return Contact();
          case 4:
            return TrabalheConosco();
          case 5:
            return Testspeednet();
          case 6:
            return const Center(child: Text("Nenhum item selecionado"));
          default:
            return const Center(child: Text("Nenhum item selecionado"));
        }
      },
    );
  }
}
