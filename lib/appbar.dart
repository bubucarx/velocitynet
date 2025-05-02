import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velocitynet/providerIndex.dart';

class _TextHeader extends StatefulWidget {
  final String texto;
  final double width;
  final int index; // Índice do item
  final bool isSelected; // Se o item está selecionado
  final VoidCallback onTap; // Callback para o toque

  const _TextHeader({
    super.key,
    required this.texto,
    required this.width,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TextHeader> createState() => __TextHeaderState();
}

class __TextHeaderState extends State<_TextHeader> {
  double _fontSize = 25.0.sp; // Tamanho da fonte inicial
  FontWeight _fontWeith = FontWeight.w200; // Fonte inicial
  double _containerWidth = 0.0.sp; // Largura do container, inicialmente 0

  // Controlando se o item está selecionado
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          // O item não está selecionado, então mudamos para w700
          if (!widget.isSelected) {
            _fontWeith = FontWeight.w700;
            _containerWidth = widget.width;
          }
        });
      },
      onExit: (_) {
        setState(() {
          // O item não está selecionado, então voltamos para w200
          if (!widget.isSelected) {
            _fontWeith = FontWeight.w200;
            _containerWidth = 0.0.sp;
          }
        });
      },
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          setState(() {
            // Quando o item for tocado, ele se torna selecionado
            // Mudamos para w700 para o item selecionado
            _fontWeith = FontWeight.w700;
          });
        },
        child: Container(
          width: widget.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.texto,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.isSelected
                      ? Colors.white
                      : Colors
                          .white, // Cor igual, mas o comportamento depende do selected
                  fontSize: widget.isSelected
                      ? 25.0.sp
                      : _fontSize.sp, // Tamanho maior quando selecionado
                  fontFamily: 'PetrovSans',
                  fontWeight: widget.isSelected
                      ? FontWeight.w700 // Peso maior quando selecionado
                      : _fontWeith, // Peso baseado no mouse e na seleção
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300), // Tempo de animação
                decoration: BoxDecoration(
                    color: Colors.white, // Cor da barra
                    borderRadius: BorderRadius.circular(10.sp)),
                curve: Curves.easeOut, // Tipo de animação (suave)
                height: 3.sp, // A altura da barra
                width: widget.isSelected
                    ? widget.width.sp
                    : 0.0.sp, // Largura será animada
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  final double opacidade;
  const Header({super.key, required this.opacidade});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int _selectedIndex = -1; // Nenhum item selecionado por padrão

  // Função chamada ao tocar em um item para alternar a seleção
  void _onItemTapped(int index) {
    setState(() {
      // Alterna a seleção entre os itens
      _selectedIndex = (_selectedIndex == index) ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: Size(1920, 1080),
        builder: (context, child) {
          return Stack(
            children: [
              Blur(
                blurColor: Color(0xff13294E),
                colorOpacity: widget.opacidade,
                blur: 10,
                borderRadius: BorderRadius.circular(10.sp),
                child: Container(
                  width: 1400.sp,
                  height: 95.sp,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1400.sp,
                height: 95.sp,
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "lib/assets/images/LOGOVETORIZADA.svg",
                      fit: BoxFit.cover,
                      width: 254.sp,
                      height: 50.sp,
                    ),
                    Container(
                      // color: Colors.red,
                      // width: 700.sp,
                      child: Row(
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp),
                            child: _TextHeader(
                              texto: [
                                'Início',
                                'Combos',
                                'Aplciativos',
                                'Oferta',
                                'TV',
                                'Contatos'
                              ][index],
                              width: [
                                70.sp,
                                100.sp,
                                130.sp,
                                80.sp,
                                50.sp,
                                110.sp
                              ][index],
                              index: index, // Passa o índice de cada item
                              isSelected: Provider.of<IndexProvider>(context)
                                      .selectedIndex ==
                                  index, // Verifica se está selecionado
                              onTap: () {
                                // Atualiza o índice selecionado usando o Provider
                                Provider.of<IndexProvider>(context,
                                        listen: false)
                                    .setSelectedIndex(index);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      width: 300.sp,
                      height: 35.sp,
                      decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'CENTRAL DO CLIENTE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF13294E),
                            fontSize: 18.sp,
                            fontFamily: 'PetrovSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
