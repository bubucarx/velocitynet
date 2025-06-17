import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocitynet/app_popups.dart';

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
    'Deezer',
  ];

  final List<int> appValues = [40, 50, 39, 20, 19];
  final List<String> megaValues = ['500', '700', '800', '900', '1000'];
  final List<int> megaPrices = [99, 109, 129, 149, 169];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return ScreenUtilInit(
      designSize: isMobile ? const Size(360, 800) : const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: isMobile ? 20.sp : 80.sp),
          width: double.infinity,
          color: const Color(0xff002450),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main title
                SizedBox(
                  width: isMobile ? 320.sp : 730.sp,
                  child: Text(
                    'Monte seu combo ideal',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 22.sp : 40.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -1.sp,
                      height: 1.1,
                    ),
                  ),
                ),

                // Subtitle
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

                SizedBox(height: isMobile ? 20.sp : 60.sp),

                // Main content
                isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      height: 980.sp,
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
      width: isMobile ? 340.sp : 775.sp,
      height: isMobile ? null : 670.sp,
      padding: isMobile ? EdgeInsets.only(bottom: 15.sp) : null,
      decoration: ShapeDecoration(
        color: const Color(0xFFEFF4FB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          // Header
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
                  fontSize: isMobile ? 16.sp : 18.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF13294E),
                ),
              ),
            ),
          ),

          // Options list
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: megaValues.length,
              itemBuilder: (context, index) {
                return _buildMegaItem(
                    megaValues[index], megaPrices[index], index);
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
              width: isMobile ? double.infinity : 550.sp,
              height: isMobile ? 90.sp : 100.sp,
              decoration: ShapeDecoration(
                color: isSelected
                    ? const Color(0xFFC2CCDE)
                    : const Color(0xFFD5DCE4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.sp),
                      width: isMobile ? 140.sp : 275.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildSelectionIndicator(isSelected),
                          SizedBox(width: 5.sp),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    mega,
                                    style: TextStyle(
                                      color: const Color(0xff002450),
                                      fontFamily: 'EutoStile',
                                      letterSpacing: -1.5.sp,
                                      fontSize: isMobile ? 30.sp : 60.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 2.sp),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: isMobile ? 4.sp : 8.sp),
                                    child: Text(
                                      'MEGA',
                                      style: TextStyle(
                                        color: const Color(0xff002450),
                                        fontFamily: 'EutoStile',
                                        letterSpacing: -1.sp,
                                        fontSize: isMobile ? 16.sp : 35.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Divisor
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      color: const Color.fromARGB(172, 0, 36, 80),
                      height: 45.sp,
                      width: 2.sp,
                    ),
                  ),

                  // Price
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        width: isMobile ? 150.sp : 220.sp,
                        padding: EdgeInsets.symmetric(horizontal: 9.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            // R$
                            Text(
                              'R\$',
                              style: TextStyle(
                                color: const Color(0xff002450),
                                fontFamily: 'EutoStile',
                                fontSize: isMobile ? 14.sp : 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            SizedBox(width: 2.sp),

                            // Valor principal
                            Text(
                              '$price',
                              style: TextStyle(
                                color: const Color(0xff002450),
                                fontFamily: 'EutoStile',
                                letterSpacing: -1.5.sp,
                                fontSize: isMobile ? 30.sp : 60.sp,
                                fontWeight: FontWeight.w700,
                                height: 1.0,
                              ),
                            ),

                            // Centavos
                            Transform.translate(
                              offset: Offset(0, isMobile ? -10.sp : -12.sp),
                              child: Text(
                                ',99',
                                style: TextStyle(
                                  color: const Color(0xff002450),
                                  fontFamily: 'EutoStile',
                                  fontSize: isMobile ? 14.sp : 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Info button
                  Padding(
                    padding: EdgeInsets.only(right: isMobile ? 10.sp : 15.sp),
                    child: InkWell(
                      onTap: () {
                        _showSpeedDetails(context, mega, price);
                      },
                      child: Icon(
                        PhosphorIcons.info,
                        color: const Color(0xff002450),
                        size: isMobile ? 30.sp : 34.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildAppColumn() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final bool isSpeedSelected = _selectedMegaIndex != -1;

    return Container(
      width: isMobile ? 340.sp : 775.sp,
      height: isMobile ? null : 670.sp,
      padding: isMobile ? EdgeInsets.only(bottom: 15.sp) : null,
      decoration: ShapeDecoration(
        color: const Color(0xFFEFF4FB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          // Header
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
                  fontSize: isMobile ? 16.sp : 18.sp,
                  fontFamily: 'EutoStile',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF13294E),
                ),
              ),
            ),
          ),

          // Apps list
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
        horizontal: isMobile ? 15.sp : 30.sp,
        vertical: isMobile ? 8.sp : 10.sp,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.sp),
          onTap: isSpeedSelected
              ? () {
                  setState(() {
                    if (isSelected) {
                      _selectedAppIndices.remove(index);
                      _selectedAppValue -= appValues[index];
                    } else {
                      _selectedAppIndices.add(index);
                      _selectedAppValue += appValues[index];
                    }
                  });
                }
              : null,
          child: Opacity(
            opacity: isSpeedSelected ? 1.0 : 0.6,
            child: Container(
              width: isMobile ? double.infinity : 550.sp,
              height: isMobile ? 90.sp : 100.sp,
              decoration: ShapeDecoration(
                color: isSelected
                    ? const Color(0xFFC2CCDE)
                    : const Color(0xFFD5DCE4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: isMobile ? 10.sp : 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectionIndicator(isSelected && isSpeedSelected),

                    // App logo
                    SizedBox(
                      width: isMobile ? 120.sp : 225.sp,
                      height: isMobile ? 30.sp : 50.sp,
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

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'R\$',
                          style: TextStyle(
                            color: const Color(0xff002450),
                            fontFamily: 'EutoStile',
                            fontSize: isMobile ? 12.sp : 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${appValues[index]}',
                          style: TextStyle(
                            color: const Color(0xff002450),
                            fontFamily: 'EutoStile',
                            letterSpacing: isMobile ? -1.0.sp : -1.5.sp,
                            fontSize: isMobile ? 24.sp : 60.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, isMobile ? -10.sp : -12.sp),
                          child: Text(
                            ',00',
                            style: TextStyle(
                              color: const Color(0xff002450),
                              fontFamily: 'EutoStile',
                              fontSize: isMobile ? 12.sp : 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: isMobile ? 5.sp : 20.sp),
                        InkWell(
                          onTap: () {
                            AppPopups.showAppDetails(context, index);
                          },
                          child: Icon(
                            PhosphorIcons.info,
                            color: const Color(0xff002450),
                            size: isMobile ? 20.sp : 30.sp,
                          ),
                        ),
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
      width: isMobile ? 340.sp : 290.sp,
      height: isMobile ? null : 670.sp,
      padding: isMobile ? EdgeInsets.only(bottom: 15.sp) : null,
      decoration: ShapeDecoration(
        color: const Color(0xFFEFF4FB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 15.sp : 10.sp,
                vertical: isMobile ? 10.sp : 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _showPlanDetails(context);
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

          // Selected plan
          Container(
            width: isMobile ? 310.sp : 260.sp,
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

          // Total value
          Container(
            width: isMobile ? 310.sp : 260.sp,
            height: isMobile ? 60.sp : 80.sp,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 15.sp : 0),
            decoration: ShapeDecoration(
              color: const Color(0xFFD5DCE4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: isMobile ? 6.sp : 12.sp),
                    child: Text(
                      'R\$',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 9, 38, 116),
                        fontSize: isMobile ? 18.sp : 24.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.sp),
                  Text(
                    '$totalValue',
                    style: TextStyle(
                      color: const Color(0xFF13294E),
                      fontSize: isMobile ? 30.sp : 50.sp,
                      fontFamily: 'EutoStile',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, isMobile ? -10.sp : -12.sp),
                    child: Text(
                      ',99',
                      style: TextStyle(
                        color: const Color(0xFF13294E),
                        fontSize: isMobile ? 18.sp : 24.sp,
                        fontFamily: 'EutoStile',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (!isMobile) ...[
                    SizedBox(width: 5.sp),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'até o',
                          style: TextStyle(
                            color: const Color(0xFF13294E),
                            fontSize: 14.sp,
                            fontFamily: 'EutoStile',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'vencimento',
                          style: TextStyle(
                            color: const Color(0xFF13294E),
                            fontSize: 14.sp,
                            fontFamily: 'EutoStile',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),

          if (isMobile) SizedBox(height: 5.sp),
          if (isMobile)
            Text(
              'até o vencimento',
              style: TextStyle(
                color: const Color(0xFF13294E),
                fontSize: 12.sp,
                fontFamily: 'EutoStile',
                fontWeight: FontWeight.w700,
              ),
            ),

          SizedBox(height: isMobile ? 10.sp : 10.sp),

          // Selected apps list
          if (_selectedAppIndices.isNotEmpty)
            Container(
              height: isMobile ? 120.sp : 300.sp,
              padding:
                  EdgeInsets.symmetric(horizontal: isMobile ? 15.sp : 15.sp),
              child: ListView.builder(
                shrinkWrap: true,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appNames[appIndex],
                            style: TextStyle(
                              color: const Color(0xFF002450),
                              fontSize: isMobile ? 12.sp : 14.sp,
                              fontFamily: 'EutoStile',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Transform.translate(
                                offset: Offset(
                                    0, 2), // move o "R$" levemente para baixo
                                child: Text(
                                  'R\$',
                                  style: TextStyle(
                                    color: const Color(0xFF002450),
                                    fontSize: isMobile ? 10.sp : 9.sp,
                                    fontFamily: 'EutoStile',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0,
                                    4), // move o número principal mais para baixo
                                child: Text(
                                  '${appValues[appIndex]}',
                                  style: TextStyle(
                                    color: const Color(0xFF002450),
                                    fontSize: isMobile ? 12.sp : 14.sp,
                                    fontFamily: 'EutoStile',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -2), // move o ",00" para cima
                                child: Text(
                                  ',00',
                                  style: TextStyle(
                                    color: const Color(0xFF002450),
                                    fontSize: isMobile ? 10.sp : 9.sp,
                                    fontFamily: 'EutoStile',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          // Contract button
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 10.sp : 15.sp,
              horizontal: isMobile ? 20.sp : 20.sp,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.sp),
                onTap: isSpeedSelected
                    ? () {
                        // Cria uma lista com os nomes dos streamings selecionados
                        final selectedApps = _selectedAppIndices
                            .map((index) => appNames[index])
                            .join(', ');

                        final message =
                            'Olá, gostaria de saber mais sobre o plano de '
                            '${megaValues[_selectedMegaIndex]} mega com '
                            '${_selectedAppIndices.isNotEmpty ? 'os seguintes streamings: $selectedApps.' : 'nenhum streaming adicional'}';

                        launchUrl(Uri.parse(
                            "https://api.whatsapp.com/send?phone=+559499260-0430&text=${Uri.encodeComponent(message)}"));
                      }
                    : null,
                child: Opacity(
                  opacity: isSpeedSelected ? 1.0 : 0.6,
                  child: Container(
                    height: isMobile ? 50.sp : 60.sp,
                    width: isMobile ? 300.sp : 240.sp,
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

  void _showSpeedDetails(BuildContext context, String mega, int price) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(isMobile ? 15.sp : 40.sp),
          child: Container(
            width: isMobile ? double.infinity : 500.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            padding: EdgeInsets.all(isMobile ? 20.sp : 30.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detalhes da Velocidade',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 18.sp : 24.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff002450),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: isMobile ? 22.sp : 30.sp),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 10.sp : 20.sp),
                Text(
                  'Internet Fibra Óptica - ${mega}MEGA',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16.sp : 20.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff002450),
                  ),
                ),
                SizedBox(height: isMobile ? 10.sp : 15.sp),
                Text(
                  '• Conexão estável e simétrica\n'
                  '• Download e Upload na mesma velocidade\n'
                  '• Sem limite de franquia\n'
                  '• Suporte técnico 24/7\n',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14.sp : 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: isMobile ? 15.sp : 25.sp),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 12.sp : 16.sp),
                  decoration: BoxDecoration(
                    color: const Color(0xff002450).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Valor:',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 14.sp : 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff002450),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'R\$',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 16.sp : 20.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff002450),
                            ),
                          ),
                          Text(
                            ' $price',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 20.sp : 30.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff002450),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, isMobile ? -8.sp : -10.sp),
                            child: Text(
                              ',99/mês',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 14.sp : 18.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff002450),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPlanDetails(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(isMobile ? 15.sp : 40.sp),
          child: Container(
            width: isMobile ? double.infinity : 500.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            padding: EdgeInsets.all(isMobile ? 20.sp : 30.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detalhes do Plano',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 18.sp : 24.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff002450),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: isMobile ? 22.sp : 30.sp),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 10.sp : 20.sp),
                Text(
                  'Benefícios do seu combo:',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16.sp : 20.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff002450),
                  ),
                ),
                SizedBox(height: isMobile ? 10.sp : 15.sp),
                Text(
                  '• Internet de alta velocidade\n'
                  '• Aplicativos de streaming inclusos\n'
                  '• Sem fidelidade obrigatória\n'
                  '• Suporte técnico especializado\n'
                  '• Pagamento único mensal\n'
                  '• Descontos exclusivos',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14.sp : 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: isMobile ? 15.sp : 25.sp),
                if (_selectedAppIndices.isNotEmpty)
                  Text(
                    'Streamings selecionados:',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 14.sp : 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff002450),
                    ),
                  ),
                if (_selectedAppIndices.isNotEmpty)
                  SizedBox(height: isMobile ? 5.sp : 10.sp),
                if (_selectedAppIndices.isNotEmpty)
                  Column(
                    children: _selectedAppIndices.map((index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 2.sp : 4.sp),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: Colors.green,
                                size: isMobile ? 16.sp : 20.sp),
                            SizedBox(width: isMobile ? 5.sp : 10.sp),
                            Text(
                              appNames[index],
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 13.sp : 15.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
