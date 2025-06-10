import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:velocitynet/trabalhe_conosco.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
                    return Stack(
                      children: [
                        // Conteúdo principal
                        MeuWidget(scroll: controller, phs: physics),
                        
                        // AppBar fixa sem animações
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Header(opacity: 0.65), // Opacidade fixa
                        ),
                      ],
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

        switch (selectedIndex) {
          case 1:
            return ListView(
              physics: widget.phs,
              controller: widget.scroll,
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
              physics: widget.phs,
              controller: widget.scroll,
              children: [
                Container(
                  width: double.infinity,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFF13294E),
                    image: DecorationImage(
                      image: isMobile
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
          default:
            return const Center(child: Text("Nenhum item selecionado"));
        }
      },
    );
  }
}