import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppPopups {
  static void showAppDetails(BuildContext context, int appIndex) {
    final appDetails = _getAppDetails(appIndex);
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(isMobile ? 16.w : 40.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 600.w,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.w : 24.w,
                  vertical: isMobile ? 20.h : 24.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cabeçalho com logo e botão de fechar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: isMobile ? 100.w : 180.w,
                          height: isMobile ? 40.h : 60.h,
                          child: appDetails['isSvg']
                              ? SvgPicture.asset(
                                  appDetails['image'],
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  appDetails['image'],
                                  fit: BoxFit.contain,
                                ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: isMobile ? 24.w : 30.w,
                            color: const Color(0xff002450),
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: isMobile ? 12.h : 20.h),
                    
                    // Título
                    Text(
                      '${appDetails['name']} - Detalhes',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 18.sp : 22.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff002450),
                      ),
                    ),
                    
                    SizedBox(height: isMobile ? 8.h : 12.h),
                    
                    // Descrição
                    Text(
                      appDetails['description'],
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14.sp : 16.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    
                    SizedBox(height: isMobile ? 12.h : 16.h),
                    
                    // Lista de características
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var feature in appDetails['features'])
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Text(
                                    '• ',
                                    style: GoogleFonts.poppins(
                                      fontSize: isMobile ? 13.sp : 15.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    feature.substring(2),
                                    style: GoogleFonts.poppins(
                                      fontSize: isMobile ? 13.sp : 15.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    
                    SizedBox(height: isMobile ? 16.h : 24.h),
                    
                    // Valor
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isMobile ? 12.w : 16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xff002450).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
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
                          SizedBox(height: 4.h),
                          Text(
                            'R\$${appDetails['value']},00/mês',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 16.sp : 18.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff002450),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: isMobile ? 20.h : 24.h),
                    
                    // Botão de ação
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff002450),
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 14.h : 16.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          launchUrl(Uri.parse(appDetails['url']));
                        },
                        child: Text(
                          'Acessar site oficial',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 14.sp : 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Map<String, dynamic> _getAppDetails(int index) {
    final apps = [
      {
        'name': 'GloboPlay',
        'image': 'lib/assets/images/globoplay/GloboPlayMaster.svg',
        'isSvg': true,
        'value': 40,
        'description': 'O GloboPlay é a plataforma de streaming do Grupo Globo que oferece:',
        'features': [
          '• Programas exclusivos da Globo',
          '• Novelas, séries e jornalismo',
          '• Transmissão ao vivo da TV Globo',
          '• Conteúdo infantil e esportivo',
          '• Catálogo com filmes nacionais e internacionais'
        ],
        'url': 'https://globoplay.globo.com'
      },
      {
        'name': 'Max',
        'image': 'lib/assets/images/max/maxMaster.svg',
        'isSvg': true,
        'value': 50,
        'description': 'Max (antigo HBO Max) traz o melhor do entretenimento com:',
        'features': [
          '• Séries exclusivas da HBO',
          '• Filmes premiados',
          '• Documentários originais',
          '• Conteúdo da Warner Bros.',
          '• Produções exclusivas'
        ],
        'url': 'https://www.max.com'
      },
      {
        'name': 'Telecine',
        'image': 'lib/assets/images/telecine/TELECINE.svg',
        'isSvg': true,
        'value': 39,
        'description': 'Telecine oferece os melhores filmes, incluindo:',
        'features': [
          '• Lançamentos em primeira mão',
          '• Clássicos do cinema',
          '• Conteúdo em alta qualidade',
          '• Diversos canais temáticos',
          '• Catálogo extenso'
        ],
        'url': 'https://www.telecine.com.br'
      },
      {
        'name': 'Premiere',
        'image': 'lib/assets/images/premiere/premiere.svg',
        'isSvg': true,
        'value': 20,
        'description': 'Canais Premiere com o melhor do futebol:',
        'features': [
          '• Transmissão dos principais jogos',
          '• Cobertura exclusiva',
          '• Análises de especialistas',
          '• Programas esportivos',
          '• Jogos em alta definição'
        ],
        'url': 'https://premiere.globo.com'
      },
      {
        'name': 'Deezer',
        'image': 'lib/assets/images/dezzerlogo.png',
        'isSvg': false,
        'value': 19,
        'description': 'Deezer oferece milhões de músicas e podcasts:',
        'features': [
          '• Catálogo com +90 milhões de músicas',
          '• Playlists personalizadas',
          '• Podcasts exclusivos',
          '• Modo offline',
          '• Alta qualidade de áudio'
        ],
        'url': 'https://www.deezer.com'
      }
    ];

    return apps[index];
  }
}