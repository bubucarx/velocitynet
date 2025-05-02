import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

class MonteSeuCombo extends StatefulWidget {
  const MonteSeuCombo({super.key});

  @override
  State<MonteSeuCombo> createState() => _MonteSeuComboState();
}

class _MonteSeuComboState extends State<MonteSeuCombo> {
  late ScrollController _scrollController;
  bool _isAtEnd = false; // Detecta se a ListView chegou ao final
  int _selectedIndex = -1;
  int _selectedHeaderIndex = -1;
  int _selectedAppIndex = -1;
  int _selectedTab = 0;
  int valorSelecionado = 000;
  int valorAppSelecionado = 000;
  List<int> _selectedAppIndices = [];
  List<String> images = [
    'lib/assets/images/globoplayApp.png',
    'lib/assets/images/maxApp.png',
    'lib/assets/images/telecineApp.png',
    'lib/assets/images/premiereApp.png',
    'lib/assets/images/deezer2.png',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Adiciona um listener para o scroll da ListView
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        // Verifica se está no final ou no topo
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _isAtEnd = true; // Chegou ao final
          });
        } else {
          setState(() {
            _isAtEnd = false; // Está no topo
          });
        }
      }
    });
  }

  void _removeApp(int index) {
    setState(() {
      _selectedAppIndices
          .remove(index); // Remove o índice da lista de selecionados
      valorAppSelecionado = 0; // Reseta o valor selecionado
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Container(
          height: 1025.sp,
          width: double.infinity,
          color: Color(0xff002450),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 730.sp,
                child: Text(
                  'Monte o seu combo sob medida de forma eficiente',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 70.sp,
                    fontFamily: 'EutoStile',
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 255, 255, 255),
                    letterSpacing: -3.48.sp,
                    height: 0.90,
                  ),
                ),
              ),
              SizedBox(
                height: 60.sp,
              ),
              Container(
                height: 600.sp,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10.sp,
                          direction: Axis.horizontal,
                          children: [
                            _buildHeaderContainer('MEGAS', 0),
                            _buildHeaderContainer('APLICATIVOS', 1)
                          ],
                        ),
                        Container(
                            width: 600.sp,
                            height: 550.sp,
                            decoration: ShapeDecoration(
                              color: Color(0xFFEFF4FB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15.sp),
                                  bottomLeft: Radius.circular(15.sp),
                                  bottomRight: Radius.circular(15.sp),
                                ),
                              ),
                            ),
                            child: PageView(
                              onPageChanged: (index) {
                                setState(() {
                                  _selectedTab = index;
                                });
                              },
                              controller: _pageController,
                              children: [
                                DynMouseScroll(
                                  builder: (context, controller, physics) {
                                    physics;
                                    controller;
                                    return ListView(
                                      controller:
                                          _scrollController, // Associando o ScrollController à ListView
                                      scrollDirection: Axis.vertical,
                                      // itemCount: 10,
                                      children: [
                                        _buildCeduleCombo('1000', 169, 0),
                                        _buildCeduleCombo('900', 149, 1),
                                        _buildCeduleCombo('800', 129, 2),
                                        _buildCeduleCombo('700', 109, 3),
                                        _buildCeduleCombo('500', 99, 4),
                                      ],
                                    );
                                  },
                                ),
                                Container(
                                  // color: Colors.red,
                                  // height: 300.sp,
                                  // width: 300.sp,
                                  child: ListView(
                                    children: [
                                      _containerApps(
                                          valor: 40,
                                          index: 0,
                                          imagem:
                                              'lib/assets/images/globoplay/GloboPlayMaster.svg',
                                          height: 50.sp,
                                          width: 225.sp),
                                      _containerApps(
                                          valor: 50,
                                          imagem:
                                              'lib/assets/images/max/maxMaster.svg',
                                          index: 1,
                                          height: 40.sp,
                                          width: 150.sp),
                                      _containerApps(
                                          valor: 39,
                                          imagem:
                                              'lib/assets/images/telecine/TELECINE.svg',
                                          index: 2,
                                          height: 40.sp,
                                          width: 150.sp),
                                      _containerApps(
                                          valor: 20,
                                          imagem:
                                              'lib/assets/images/premiere/premiere.svg',
                                          index: 3,
                                          height: 40.sp,
                                          width: 240.sp),
                                      _containerApps(
                                          valor: 19,
                                          imagem:
                                              'lib/assets/images/deezer/deezer-logo.svg',
                                          index: 4,
                                          height: 170.sp,
                                          width: 170.sp),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      width: 20.sp,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 290.sp,
                          height: 550.sp,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEFF4FB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp, vertical: 10.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ver detalhes',
                                      style: TextStyle(
                                        color: Color(0xFF13294E),
                                        fontSize: 17.sp,
                                        fontFamily: 'EutoStile',
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${_selectedAppIndices.length}',
                                          style: TextStyle(
                                            color: Color(0xFFFFB000),
                                            fontSize: 17.sp,
                                            fontFamily: 'EutoStile',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Icon(
                                          PhosphorIcons.shopping_cart_fill,
                                          color: Color(0xFFFFB000),
                                          size: 15.sp,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 260.sp,
                                height: 40.sp,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFD5DCE4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Internet fibra - 700mega',
                                    style: TextStyle(
                                      color: Color(0xFF13294E),
                                      fontSize: 15.sp,
                                      fontFamily: 'EutoStile',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Container(
                                width: 260.sp,
                                height: 80.sp,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFD5DCE4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10.sp),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.sp),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'R\$',
                                                style: TextStyle(
                                                  color: Color(0xFFFFB000),
                                                  fontSize: 50.sp,
                                                  fontFamily: 'EutoStile',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${valorSelecionado + valorAppSelecionado}',
                                                style: TextStyle(
                                                  color: Color(0xFF13294E),
                                                  fontSize: 50.sp,
                                                  fontFamily: 'EutoStile',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '.99\n',
                                              style: TextStyle(
                                                color: Color(0xFF13294E),
                                                fontSize: 22.sp,
                                                fontFamily: 'EutoStile',
                                                fontWeight: FontWeight.w700,
                                                height: 0.90,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '  até o\n  vencimento',
                                              style: TextStyle(
                                                color: Color(0xFF13294E),
                                                fontSize: 14.sp,
                                                fontFamily: 'EutoStile',
                                                height: 0.90,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Container(
                                height: 290.sp,
                                child: ListView.builder(
                                  itemCount: _selectedAppIndices
                                      .length, // Número de itens selecionados
                                  itemBuilder: (context, index) {
                                    // Recupera o índice real da lista de selecionados
                                    final selectedIndex =
                                        _selectedAppIndices[index];

                                    // Acessa a imagem correspondente ao índice
                                    final selectedImage = images[selectedIndex];

                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.sp, horizontal: 15.sp),
                                        child: appCard(
                                          selectedImage, // Imagem do app
                                          selectedIndex, // Índice do app selecionado
                                          () => _removeApp(
                                              selectedIndex), // Passa a função de remoção
                                        )); // Exibe a imagem com o card
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // Função para construir o card com imagem e ícone de remoção
  Widget appCard(String imagem, int index, VoidCallback onRemove) {
    return Container(
      width: 260.sp,
      height: 50.sp,
      decoration: ShapeDecoration(
        color: Color(0xFFD5DBE4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 35.sp,
              width: 35.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                image: DecorationImage(image: AssetImage(imagem)),
              ),
            ),
            IconButton(
              icon: Icon(
                PhosphorIcons.x_circle_fill,
                color: Colors.white,
                size: 25.sp,
              ),
              onPressed:
                  onRemove, // Chama a função de remoção quando pressionado
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCeduleCombo(String mega, int valor, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0.sp, vertical: 10.0.sp),
      child: _ceduleCombo(
        Mega: mega,
        valor: valor,
        isSelected:
            _selectedIndex == index, // Determina se o item está selecionado
        onTap: () {
          setState(() {
            // Atualiza o índice do item selecionado
            if (_selectedIndex == index) {
              // Se o item já estiver selecionado, desmarque-o e reinicie o valor
              _selectedIndex = -1;
              valorSelecionado = 0; // Reseta o valor para 0
            } else {
              // Caso contrário, marque o item e atualize o valor
              _selectedIndex = index;
              valorSelecionado =
                  valor; // Atualiza com o valor do item selecionado
            }
          });
        },
      ),
    );
  }

  Widget _buildHeaderContainer(String text, int index) {
    return _containerHeader(
      text: text,
      isSelected: _selectedHeaderIndex == index,
      onTap: () {
        setState(() {
          // Atualiza o índice da tab selecionada
          _selectedHeaderIndex = _selectedHeaderIndex == index ? -1 : index;
          print('O texto selecionado é ${_selectedTab}');
          _selectedTab = index;

          // Navega diretamente para a página do índice selecionado
          _pageController.animateToPage(
            _selectedTab, // índice da página que você deseja navegar
            duration: Duration(milliseconds: 300), // duração da animação
            curve: Curves.ease, // curva da animação
          );
        });
      },
    );
  }

  Widget _containerApps(
      {required String imagem,
      required int valor,
      required double height,
      required double width,
      required int index}) {
    return _containerApp(
      imagem: imagem,
      isSelected: _selectedAppIndices.contains(
          index), // Verifica se o índice está na lista de selecionados
      onTap: () {
        setState(() {
          if (_selectedAppIndices.contains(index)) {
            // Se o item já estiver selecionado, desmarque-o
            _selectedAppIndices.remove(index); // Remove o índice da lista
            valorAppSelecionado -= valor; // Subtrai o valor ao desmarcar
          } else {
            // Caso contrário, adicione o item à lista de selecionados
            _selectedAppIndices.add(index);
            valorAppSelecionado += valor; // Adiciona o valor ao selecionar
          }
        });
      },
      height: height,
      width: width,
    );
  }
}

class _containerHeader extends StatefulWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onTap;
  const _containerHeader({
    super.key,
    required this.onTap,
    required this.text,
    required this.isSelected,
  });

  @override
  State<_containerHeader> createState() => __containerHeaderState();
}

class __containerHeaderState extends State<_containerHeader> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return InkWell(
          onTap: widget.onTap,
          child: Container(
            height: 50.sp,
            decoration: ShapeDecoration(
              color: Color(0xFFEFF4FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.sp),
                  topRight: Radius.circular(15.sp),
                ),
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'EutoStile',
                    fontWeight: FontWeight.w700,
                    color: widget.isSelected
                        ? Color(0xffFFB000)
                        : Color(0xffC0C0C0),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ceduleCombo extends StatefulWidget {
  final String Mega;
  final int valor;
  final bool isSelected;
  final VoidCallback onTap;
  const _ceduleCombo(
      {super.key,
      required this.Mega,
      required this.valor,
      required this.isSelected,
      required this.onTap});

  @override
  State<_ceduleCombo> createState() => __ceduleComboState();
}

class __ceduleComboState extends State<_ceduleCombo> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return InkWell(
          onTap: widget.onTap,
          child: Container(
            width: 540.sp,
            height: 90.sp,
            decoration: ShapeDecoration(
              color: Color(0xFFD5DCE4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 235.sp,
                  // color: Colors.amber,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.sp),
                        child: Text(
                          widget.Mega,
                          style: TextStyle(
                              color: Color(0xff002450),
                              fontFamily: 'EutoStile',
                              letterSpacing: -3.48.sp,
                              fontSize: 60.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.sp),
                        child: Text(
                          'MEGA',
                          style: TextStyle(
                              color: Color(0xff002450),
                              fontFamily: 'EutoStile',
                              letterSpacing: -3.48.sp,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  width: 195.sp,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.sp),
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'Por\napenas\n',
                              style: TextStyle(
                                  color: Color(0xff002450),
                                  fontFamily: 'EutoStile',
                                  // letterSpacing: -3.48.sp,
                                  height: 0.90,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: 'R\$',
                              style: TextStyle(
                                  color: Color(0xff002450),
                                  fontFamily: 'EutoStile',
                                  // letterSpacing: -3.48.sp,
                                  height: 0.0,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.sp),
                        child: Text(
                          '${widget.valor}',
                          style: TextStyle(
                              color: Color(0xff002450),
                              fontFamily: 'EutoStile',
                              letterSpacing: -3.48.sp,
                              fontSize: 60.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.sp),
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: ',99\n',
                              style: TextStyle(
                                  color: Color(0xff002450),
                                  fontFamily: 'EutoStile',
                                  // letterSpacing: -3.48.sp,
                                  height: 0.90,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: 'ao mês\naté a data de\nvencimento',
                              style: TextStyle(
                                  color: Color(0xff002450),
                                  fontFamily: 'EutoStile',
                                  // letterSpacing: -3.48.sp,
                                  height: 0.90,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                widget.isSelected
                    ? Center(
                        child: Container(
                          width: 40.sp,
                          height: 40.sp,
                          decoration: ShapeDecoration(
                            color: Color(0xFF627182),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 4.sp,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFFEFF4FB),
                              ),
                              borderRadius: BorderRadius.circular(7.sp),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          width: 40.sp,
                          height: 40.sp,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 4.sp,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFFEFF4FB),
                              ),
                              borderRadius: BorderRadius.circular(7.sp),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _containerApp extends StatefulWidget {
  final double height;
  final double width;
  final bool isSelected;
  final VoidCallback onTap;
  final String imagem;
  const _containerApp(
      {super.key,
      required this.imagem,
      required this.isSelected,
      required this.onTap,
      required this.height,
      required this.width});

  @override
  State<_containerApp> createState() => __containerAppState();
}

class __containerAppState extends State<_containerApp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: 540.sp,
          height: 90.sp,
          decoration: ShapeDecoration(
            color: Color(0xFFD5DCE4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  widget.imagem,
                  height: widget.height,
                  width: widget.width,
                  fit: BoxFit.cover,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    widget.isSelected
                        ? Center(
                            child: Container(
                              width: 40.sp,
                              height: 40.sp,
                              decoration: ShapeDecoration(
                                color: Color(0xFF627182),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 4.sp,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: Color(0xFFEFF4FB),
                                  ),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
                              width: 40.sp,
                              height: 40.sp,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 4.sp,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: Color(0xFFEFF4FB),
                                  ),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
