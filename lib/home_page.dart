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
import 'package:velocitynet/deezer.dart';
import 'package:velocitynet/entretenimento.dart';
import 'package:velocitynet/globoplay.dart';
import 'package:velocitynet/max.dart';
import 'package:velocitynet/monte_seu_combo.dart';
import 'package:velocitynet/premiere.dart';
import 'package:velocitynet/providerIndex.dart';
import 'package:velocitynet/telecine.dart';
import 'package:velocitynet/testSpeednet.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  double _previousOffset = 0.0;
  bool _scrollDirection = false;
  final double _scrollThreshold =
      780.0; // Limite de rolagem para tornar o container transparente
  double _opacity = 0.0; // Começa com opacidade cheia

  @override
  bool get wantKeepAlive => true; // Isso mantém o estado do widget.

  @override
  void initState() {
    super.initState();
  }

  void _onScroll(ScrollController controller) {
    double currentOffset = controller.position.pixels;

    // Usando addPostFrameCallback para evitar setState() durante o build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentOffset > _previousOffset) {
        if (mounted) {
          setState(() {
            _scrollDirection = true;
          });
        }
      } else if (currentOffset < _previousOffset) {
        if (mounted) {
          setState(() {
            _scrollDirection = false;
          });
        }
      }
      setState(() {
        if (currentOffset >= _scrollThreshold) {
          _opacity =
              0.65; // Tornar o container completamente visível após 780 pixels
        } else {
          _opacity = (currentOffset / _scrollThreshold)
              .clamp(0.0, 0.65); // A opacidade aumenta conforme o scroll
        }
      });
      _previousOffset = currentOffset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(1920, 1080),
      builder: (context, child) {
        return Scaffold(
          body: Container(
            width: 1920.sp,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: DynMouseScroll(
              durationMS: 4000,
              scrollSpeed: 1.0,
              animationCurve: Curves.easeOutQuart,
              builder: (context, controller, physics) {
                controller.addListener(() {
                  _onScroll(controller);
                });
                return Stack(
                  children: [
                    MeuWidget(
                      scroll: controller,
                      phs: physics,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.sp),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Header(
                          opacidade: _opacity,
                        )
                            .animate()
                            .fadeIn(
                              duration: _scrollDirection ? 0.ms : 400.ms,
                              curve: _scrollDirection
                                  ? Curves.easeOut
                                  : Curves.easeOut,
                            )
                            .move(
                              delay: _scrollDirection ? 0.ms : 0.01.ms,
                              duration: _scrollDirection ? 400.ms : 400.ms,
                              curve: _scrollDirection
                                  ? Curves.easeOut
                                  : Curves.easeOut,
                              begin: _scrollDirection
                                  ? Offset(0, 0)
                                  : Offset(0, -105),
                              end: _scrollDirection
                                  ? Offset(0, -105)
                                  : Offset(0, 0),
                            ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

Widget _containerPaddin() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.sp),
    child: Container(
      width: 5.sp,
      height: 5.sp,
      decoration: ShapeDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.sp),
        ),
      ),
    ),
  );
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
    // Obter o índice selecionado do Provider
    int selectedIndex = Provider.of<IndexProvider>(context).selectedIndex;

    // Aqui, você pode exibir diferentes conteúdos com base no índice
    switch (selectedIndex) {
      case 1:
        return ListView(
          controller: widget.scroll,
          physics: widget.phs,
          children: [
            Entretenimento(),
            Deezer(),
            SizedBox(height: 200),
            Max(),
            SizedBox(height: 200),
            Globoplay(),
            SizedBox(height: 200),
            Telecine(),
            SizedBox(height: 200),
            Premiere(),
            SizedBox(height: 200),
          ],
        );
      // Column(
      //   children: [
      //     Entretenimento(),
      //     Deezer(),
      //     SizedBox(height: 200),
      //     Max(),
      //     SizedBox(height: 200),
      //     Globoplay(),
      //     SizedBox(height: 200),
      //     Telecine(),
      //     SizedBox(height: 200),
      //     Premiere(),
      //     SizedBox(height: 200),
      //   ],
      // );
      case 0:
        return ListView(
          controller: widget.scroll,
          physics: widget.phs,
          children: [
            Container(
              width: 1920.sp,
              height: 850.sp,
              decoration: BoxDecoration(
                  color: Color(0xFF13294E),
                  image: DecorationImage(
                      image:
                          AssetImage('lib/assets/images/ImagemPromocional.png'),
                      fit: BoxFit.cover)),
            ),
            ConexaoFibra(),
            MonteSeuCombo(),
            Aplicativos(),
            NosLigamos(),
            Container(
              width: 1920.sp,
              height: 1020.sp,
              decoration: BoxDecoration(
                color: Color(0xFF13294E),
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/MonteSeuCombo.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Testspeednet(),
          ],
        );
      // Column(
      //   children: [
      //     MonteSeuCombo(),
      //     Container(
      //       width: 1920,
      //       height: 850,
      //       decoration: BoxDecoration(
      //           color: Color(0xFF13294E),
      //           image: DecorationImage(
      //               image:
      //                   AssetImage('lib/assets/images/ImagemPromocional.png'),
      //               fit: BoxFit.cover)),
      //     ),
      //     ConexaoFibra(),
      //     Aplicativos(),
      //     Container(
      //       width: 1920,
      //       height: 1020,
      //       decoration: BoxDecoration(
      //         color: Color(0xFF13294E),
      //         image: DecorationImage(
      //             image: AssetImage('lib/assets/images/MonteSeuCombo.jpg'),
      //             fit: BoxFit.cover),
      //       ),
      //     ),
      //     NosLigamos(),
      //   ],
      // );
      case 2:
        return Text("Exibindo conteúdo para Sobre nós");
      case 3:
        return Text("Exibindo conteúdo para Oferta");
      case 4:
        return Text("Exibindo conteúdo para TV");
      case 5:
        return Text("Exibindo conteúdo para Contatos");
      default:
        return Text("Nenhum item selecionado");
    }
  }
}
