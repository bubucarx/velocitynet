import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MonteSeuCombo extends StatefulWidget {
  const MonteSeuCombo({super.key});

  @override
  State<MonteSeuCombo> createState() => _MonteSeuComboState();
}

class _MonteSeuComboState extends State<MonteSeuCombo> {
  int _selectedMegaIndex = -1;
  int _selectedMegaValue = 0;
  List<int> _selectedAppIndices = [];
  int _selectedAppValue = 0;

  final List<String> appImages = [
    'lib/assets/images/globoplay/GloboPlayMaster.svg',
    'lib/assets/images/max/maxMaster.svg',
    'lib/assets/images/telecine/TELECINE.svg',
    'lib/assets/images/premiere/premiere.svg',
    'lib/assets/images/dezzerlogo.png',
  ];

  final List<String> appNames = [
    'GloboPlay',
    'Max',
    'Telecine',
    'Premiere',
    'Deezer'
  ];

  final List<int> appValues = [40, 50, 39, 20, 19];
  final List<String> megaValues = ['1000', '900', '800', '700', '500'];
  final List<int> megaPrices = [169, 149, 129, 109, 99];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return ScreenUtilInit(
      designSize: isMobile ? const Size(360, 800) : const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: isMobile ? 40.sp : 80.sp),
          width: double.infinity,
          color: const Color(0xff002450),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título principal
              SizedBox(
                width: isMobile ? 320.sp : 730.sp,
                child: Text(
                  'Monte seu combo ideal',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 18.sp : 40.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -1.sp,
                    height: 1.1,
                  ),
                ),
              ),
              
              // Subtítulo
              SizedBox(height: isMobile ? 10.sp : 20.sp),
              SizedBox(
                width: isMobile ? 320.sp : 730.sp,
                child: Text(
                  'Personalize seu pacote de internet e streaming',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16.sp : 22.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.2,
                  ),
                ),
              ),
              
              SizedBox(height: isMobile ? 30.sp : 60.sp),
              
              // Conteúdo principal
              isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      height: 680.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMegaColumn(),
          SizedBox(width: 20.sp),
          _buildAppColumn(),
          SizedBox(width: 20.sp),
          _buildSummaryColumn(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildMegaColumn(),
        SizedBox(height: 20.sp),
        _buildAppColumn(),
        SizedBox(height: 20.sp),
        _buildSummaryColumn(),
      ],
    );
  }

  Widget _buildMegaColumn() {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: isMobile ? 320.sp : 600.sp,
      height: isMobile ? 400.sp : 650.sp,
      decoration: ShapeDecoration(
        color: const Color(0xFFEFF4FB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
      child: Column(
        children: [
          // Cabeçalho
          Container(
            height: 50.sp,
            decoration: BoxDecoration(
              color: const Color(0xFFD5DCE4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.sp),
                topRight: Radius.circular(15.sp),
              ),
            ),
            child: Center(
              child: Text(
                'ESCOLHA A SUA VELOCIDADE',
                style: TextStyle(
                  fontSize: isMobile ? 14.sp : 18.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF13294E),
                ),
              ),
            ),
          ),
          
          // Lista de opções
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              itemCount: megaValues.length,
              itemBuilder: (context, index) {
                return _buildMegaItem(megaValues[index], megaPrices[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMegaItem(String mega, int price, int index) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isSelected = _selectedMegaIndex == index;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 15.sp : 30.sp,
        vertical: isMobile ? 8.sp : 10.sp,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.sp),
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedMegaIndex = -1;
                _selectedMegaValue = 0;
                _selectedAppIndices.clear();
                _selectedAppValue = 0;
              } else {
                _selectedMegaIndex = index;
                _selectedMegaValue = price;
              }
            });
          },
          child: Container(
            width: isMobile ? 290.sp : 540.sp,
            height: isMobile ? 80.sp : 90.sp,
            decoration: ShapeDecoration(
              color: isSelected ? const Color(0xFFC2CCDE) : const Color(0xFFD5DCE4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Texto da velocidade
                Container(
                  width: isMobile ? 120.sp : 275.sp,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: isMobile ? 5.sp : 15.sp),
                        child: Text(
                          mega,
                          style: TextStyle(
                            color: const Color(0xff002450),
                            fontFamily: 'EutoStile',
                            letterSpacing: -1.5.sp,
                            fontSize: isMobile ? 32.sp : 60.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: isMobile ? 2.sp : 5.sp),
                        child: Text(
                          'MEGA',
                          style: TextStyle(
                            color: const Color(0xff002450),
                            fontFamily: 'EutoStile',
                            letterSpacing: -1.sp,
                            fontSize: isMobile ? 18.sp : 40.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Preço
                Container(
                  width: isMobile ? 120.sp : 205.sp,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: isMobile ? 0.sp : 10.sp),
                        child: Text.rich(
                          TextSpan(children: [
                            if (!isMobile) TextSpan(
                              text: 'Por\napenas\n',
                              style: TextStyle(
                                color: const Color(0xff002450),
                                fontFamily: 'EutoStile',
                                height: 0.90,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'R\$',
                              style: TextStyle(
                                color: const Color(0xff002450),
                                fontFamily: 'EutoStile',
                                height: 0.0,
                                fontSize: isMobile ? 14.sp : 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: isMobile ? 0.sp : 15.sp),
                        child: Text(
                          '$price',
                          style: TextStyle(
                            color: const Color(0xff002450),
                            fontFamily: 'EutoStile',
                            letterSpacing: -1.5.sp,
                            fontSize: isMobile ? 32.sp : 60.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: isMobile ? 0.sp : 15.sp),
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: ',99',
                              style: TextStyle(
                                color: const Color(0xff002450),
                                fontFamily: 'EutoStile',
                                height: 0.90,
                                fontSize: isMobile ? 14.sp : 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (!isMobile) TextSpan(
                              text: '\nao mês\naté a data de\nvencimento',
                              style: TextStyle(
                                color: const Color(0xff002450),
                                fontFamily: 'EutoStile',
                                height: 0.90,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Indicador de seleção
                _buildSelectionIndicator(isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppColumn() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final bool isSpeedSelected = _selectedMegaIndex != -1;

    return Container(
      width: isMobile ? 320.sp : 600.sp,
      height: isMobile ? 400.sp : 650.sp,
      decoration: ShapeDecoration(
        color: const Color(0xFFEFF4FB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
      child: Column(
        children: [
          // Cabeçalho
          Container(
            height: 50.sp,
            decoration: BoxDecoration(
              color: const Color(0xFFD5DCE4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.sp),
                topRight: Radius.circular(15.sp),
              ),
            ),
            child: Center(
              child: Text(
                'ESCOLHA SEUS STREAMING',
                style: TextStyle(
                  fontSize: isMobile ? 14.sp : 18.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF13294E),
                ),
              ),
            ),
          ),
          
          // Lista de apps
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              itemCount: appImages.length,
              itemBuilder: (context, index) {
                return _buildAppItem(index, isSpeedSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppItem(int index, bool isSpeedSelected) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final bool isSelected = _selectedAppIndices.contains(index);
    final bool isSvg = appImages[index].toLowerCase().endsWith('.svg');

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10.sp : 20.sp,
        vertical: isMobile ? 8.sp : 10.sp,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.sp),
          onTap: isSpeedSelected ? () {
            setState(() {
              if (isSelected) {
                _selectedAppIndices.remove(index);
                _selectedAppValue -= appValues[index];
              } else {
                _selectedAppIndices.add(index);
                _selectedAppValue += appValues[index];
              }
            });
          } : null,
          child: Opacity(
            opacity: isSpeedSelected ? 1.0 : 0.6,
            child: Container(
              width: isMobile ? 300.sp : 540.sp,
              height: isMobile ? 70.sp : 90.sp,
              decoration: ShapeDecoration(
                color: isSelected ? const Color(0xFFC2CCDE) : const Color(0xFFD5DCE4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.sp : 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo do app
                    SizedBox(
                      width: isMobile ? 150.sp : 225.sp,
                      height: isMobile ? 35.sp : 50.sp,
                      child: isSvg
                          ? SvgPicture.asset(
                              appImages[index],
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              appImages[index],
                              fit: BoxFit.contain,
                            ),
                    ),
                    
                    // Preço e indicador
                    Row(
                      children: [
                        Text(
                          'R\$${appValues[index]}',
                          style: GoogleFonts.poppins(
                            color: const Color(0xff002450),
                            fontSize: isMobile ? 16.sp : 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: isMobile ? 10.sp : 20.sp),
                        _buildSelectionIndicator(isSelected && isSpeedSelected),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryColumn() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final bool isSpeedSelected = _selectedMegaIndex != -1;
    final totalValue = _selectedMegaValue + _selectedAppValue;

    return Container(
      width: isMobile ? 320.sp : 290.sp,
      height: isMobile ? 300.sp : 650.sp,
      decoration: ShapeDecoration(
        color: const Color(0xFFEFF4FB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
      child: Column(
        children: [
          // Cabeçalho
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 15.sp : 10.sp,
              vertical: isMobile ? 10.sp : 10.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: Implementar detalhes
                  },
                  child: Text(
                    'Ver detalhes',
                    style: TextStyle(
                      color: const Color.fromARGB(162, 19, 41, 78),
                      fontSize: isMobile ? 12.sp : 17.sp,
                      fontFamily: 'EutoStile',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${_selectedAppIndices.length}',
                      style: TextStyle(
                        color: const Color(0xFF13294E),
                        fontSize: isMobile ? 12.sp : 17.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4.sp),
                    Icon(
                      PhosphorIcons.shopping_cart_fill,
                      color: const Color(0xFF13294E),
                      size: isMobile ? 12.sp : 15.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Plano selecionado
          Container(
            width: isMobile ? 290.sp : 260.sp,
            height: isMobile ? 35.sp : 40.sp,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 15.sp : 0),
            decoration: ShapeDecoration(
              color: const Color(0xFFD5DCE4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
            child: Center(
              child: Text(
                isSpeedSelected
                    ? 'Internet fibra - ${megaValues[_selectedMegaIndex]}mega'
                    : 'Selecione um plano',
                style: TextStyle(
                  color: const Color(0xFF13294E),
                  fontSize: isMobile ? 12.sp : 15.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          
          SizedBox(height: isMobile ? 8.sp : 5.sp),
          
          // Valor total
          Container(
            width: isMobile ? 290.sp : 260.sp,
            height: isMobile ? 70.sp : 80.sp,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 15.sp : 0),
            decoration: ShapeDecoration(
              color: const Color(0xFFD5DCE4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: isMobile ? 5.sp : 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'R\$',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 9, 38, 116),
                          fontSize: isMobile ? 30.sp : 50.sp,
                          fontFamily: 'EutoStile',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: '$totalValue',
                        style: TextStyle(
                          color: const Color(0xFF13294E),
                          fontSize: isMobile ? 30.sp : 50.sp,
                          fontFamily: 'EutoStile',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: isMobile ? 0.sp : 10.sp),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: ',99',
                          style: TextStyle(
                            color: const Color(0xFF13294E),
                            fontSize: isMobile ? 16.sp : 22.sp,
                            fontFamily: 'EutoStile',
                            fontWeight: FontWeight.w700,
                            height: 0.90,
                          ),
                        ),
                        if (!isMobile) TextSpan(
                          text: '\n  até o\n  vencimento',
                          style: TextStyle(
                            color: const Color(0xFF13294E),
                            fontSize: 14.sp,
                            fontFamily: 'EutoStile',
                            fontWeight: FontWeight.w700,
                            height: 0.90,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (isMobile) SizedBox(height: 5.sp),
          if (isMobile) Text(
            'até o vencimento',
            style: TextStyle(
              color: const Color(0xFF13294E),
              fontSize: 12.sp,
              fontFamily: 'EutoStile',
              fontWeight: FontWeight.w700,
            ),
          ),
          
          SizedBox(height: isMobile ? 10.sp : 10.sp),
          
          // Lista de apps selecionados
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 15.sp : 15.sp),
              itemCount: _selectedAppIndices.length,
              itemBuilder: (context, index) {
                int appIndex = _selectedAppIndices[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 4.sp : 5.sp,
                    horizontal: isMobile ? 0.sp : 0.sp,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 10.sp : 10.sp,
                      vertical: isMobile ? 6.sp : 8.sp,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5DCE4),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Text(
                      appNames[appIndex],
                      style: TextStyle(
                        color: const Color(0xFF002450),
                        fontSize: isMobile ? 12.sp : 14.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Botão de contratação
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 10.sp : 15.sp,
              horizontal: isMobile ? 20.sp : 20.sp,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.sp),
                onTap: isSpeedSelected ? () {
                  final message = 'Olá, gostaria de contratar o plano de '
                      '${megaValues[_selectedMegaIndex]} mega com '
                      '${_selectedAppIndices.length} streaming(s)';
                  launchUrl(Uri.parse(
                    "https://api.whatsapp.com/send?phone=+559499260-0430&text=${Uri.encodeComponent(message)}"
                  ));
                } : null,
                child: Opacity(
                  opacity: isSpeedSelected ? 1.0 : 0.6,
                  child: Container(
                    height: isMobile ? 50.sp : 60.sp,
                    width: isMobile ? 280.sp : 240.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF25D366),
                          Color(0xFF128C7E),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF25D366).withOpacity(0.3),
                          blurRadius: 10.sp,
                          spreadRadius: 1.sp,
                          offset: Offset(0, 4.sp),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIcons.whatsapp_logo_fill,
                          color: Colors.white,
                          size: isMobile ? 22.sp : 28.sp,
                        ),
                        SizedBox(width: isMobile ? 8.sp : 12.sp),
                        Text(
                          'Contrate agora',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: isMobile ? 14.sp : 18.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionIndicator(bool selected) {
    return Icon(
      selected ? Icons.check_circle : Icons.radio_button_unchecked,
      color: selected ? const Color(0xFF002BE7) : Colors.grey,
      size: 24.sp,
    );
  }
}