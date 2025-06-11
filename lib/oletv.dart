import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocitynet/footer.dart';

class Oletv extends StatefulWidget {
  Oletv({super.key});

  @override
  State<Oletv> createState() => _OletvState();
}

class _OletvState extends State<Oletv> {
  final ScrollController scrollController = ScrollController();

  final List<String> lifeLinePlans = [
    'lib/assets/images/tv_plans/agro_canal.png',
    'lib/assets/images/tv_plans/aparecida_logo.png',
    'lib/assets/images/tv_plans/band_logo.png',
    'lib/assets/images/tv_plans/canal_do_boi_logo.png',
    'lib/assets/images/tv_plans/cultura_logo.webp',
    'lib/assets/images/tv_plans/globo_logo.png',
    'lib/assets/images/tv_plans/mega_tv_logo.png',
    'lib/assets/images/tv_plans/ngt_logo.png',
    'lib/assets/images/tv_plans/polishop_logo.png',
    'lib/assets/images/tv_plans/record_logo.png',
    'lib/assets/images/tv_plans/redebrasil_logo.png',
    'lib/assets/images/tv_plans/redetv_logo.png',
    'lib/assets/images/tv_plans/redevida_logo.png',
    'lib/assets/images/tv_plans/sbt_logo.webp',
    'lib/assets/images/tv_plans/terra_viva_logo.png',
    'lib/assets/images/tv_plans/TV_Escola_logo.png',
    'lib/assets/images/tv_plans/tv_senado_logo.png',
    'lib/assets/images/tv_plans/urban_movie_logo.png',
    'lib/assets/images/tv_plans/urban_serie_logo.png',
    'lib/assets/images/tv_plans/urbans_kids_logo.png',
  ];

  final List<String> topHD = [
    'lib/assets/images/topHD/animal_planet_logo.png',
    'lib/assets/images/topHD/band_sports_logo.png',
    'lib/assets/images/topHD/discovery_investigation_logo.png',
    'lib/assets/images/topHD/dreamworks_logo.png',
    'lib/assets/images/topHD/espn4_logo.png',
    'lib/assets/images/topHD/food_network_logo.png',
    'lib/assets/images/topHD/sony_movie_logo.png',
    'lib/assets/images/topHD/cnn_internacional_logo.png',
    'lib/assets/images/topHD/espn_logo.png',
    'lib/assets/images/topHD/hgtv_logo.webp',
    'lib/assets/images/topHD/lifetime_logo.png',
    'lib/assets/images/topHD/tnt_series_logo.png',
    'lib/assets/images/topHD/history2_logo.png',
    'lib/assets/images/topHD/disney_channel.png',
    'lib/assets/images/topHD/tlc_logo.png',
    'lib/assets/images/topHD/FX_logo.png',
    'lib/assets/images/topHD/space_channel_logo.png',
    'lib/assets/images/topHD/amc_logo.png',
    'lib/assets/images/topHD/cine_canal_logo.png',
    'lib/assets/images/topHD/discovery_turbo_logo.png'
  ];

  final List<String> startHD = [
    'lib/assets/images/startHD/bandNews_logo.png',
    'lib/assets/images/startHD/discovery_channel_logo.png',
    'lib/assets/images/startHD/hh_discovery_logo.png',
    'lib/assets/images/startHD/warner_channel_logo.png',
    'lib/assets/images/startHD/History_logo.png',
    'lib/assets/images/startHD/cartoon_logo.png',
    'lib/assets/images/startHD/cnn_brasil_logo.png',
    'lib/assets/images/startHD/discovery_kids_logo.png',
    'lib/assets/images/startHD/espn_2_logo.png',
    'lib/assets/images/startHD/sonychannel_logo.jpg',
    'lib/assets/images/startHD/star_channel.png',
    'lib/assets/images/startHD/tnt_logo.webp',
    'lib/assets/images/startHD/play_tv_logo.webp',
    'lib/assets/images/startHD/national_logo.png',
    'lib/assets/images/startHD/discovery_channel_logo.png',
  ];

  final List<String> premiumHD = [
    'lib/assets/images/premiumHD/discovery_science_logo.png',
    'lib/assets/images/premiumHD/discovery_world_logo.webp',
    'lib/assets/images/premiumHD/filmArts_logo.png',
    'lib/assets/images/premiumHD/oSat_logo.png',
    'lib/assets/images/premiumHD/tcm_logo.png',
    'lib/assets/images/premiumHD/teacher_discovery_logo.webp',
    'lib/assets/images/premiumHD/ESPN3_Logo.png',
    'lib/assets/images/premiumHD/espn_extra_logo.webp',
    'lib/assets/images/premiumHD/tnt_novelas_logo.png',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: isMobile ? 500 : 1000,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/group.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Espaço adicional antes do texto
                  SizedBox(height: isMobile ? 80 : 150),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isMobile ? 35 : 0),
                    child: Text(
                      'ASSISTA PELO APLICATIVO',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 24 : 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => launch(
                            'https://play.google.com/store/apps/details?id=br.tv.ole.oletv&hl=en_US'),
                        child: Image.asset(
                          'lib/assets/images/googlestore.png',
                          height: isMobile ? 70 : 100,
                          width: isMobile ? 140 : 200,
                        ),
                      ),
                      SizedBox(width: isMobile ? 5 : 10),
                      InkWell(
                        onTap: () => launch(
                            'https://apps.apple.com/br/app/ol%C3%A9-tv/id1301299065'),
                        child: Image.asset(
                          'lib/assets/images/appstore.png',
                          height: isMobile ? 70 : 100,
                          width: isMobile ? 126 : 180,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 1 : 90),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 0,
                vertical: 30,
              ),
              child: Column(
                children: [
                  Text(
                    'ESCOLHA O PLANO IDEAL PARA VOCÊ!',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF13294E),
                      fontSize: isMobile ? 24 : 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 20 : 50),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF13294E),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    width: isMobile ? 350 : 650,
                    height: isMobile ? 900 : 800,
                    child: ContainedTabBarView(
                      tabBarProperties: TabBarProperties(
                        labelColor: Colors.transparent,
                        indicatorColor: Colors.blue,
                        height: isMobile ? 60 : 48,
                      ),
                      tabs: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: isMobile ? 8 : 0),
                          child: Text(
                            'Life Line',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: isMobile ? 14 : 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: isMobile ? 8 : 0),
                          child: Text(
                            'Start HD',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: isMobile ? 14 : 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: isMobile ? 8 : 0),
                          child: Text(
                            'Top HD',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: isMobile ? 14 : 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: isMobile ? 8 : 0),
                          child: Text(
                            'Premium HD',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: isMobile ? 14 : 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                      views: [
                        _buildPlanTab(
                          context,
                          isMobile,
                          '+60 CANAIS DE TV',
                          '+500h de VOD',
                          'GRATIS PARA CLIENTES',
                          lifeLinePlans,
                          [],
                        ),
                        _buildPlanTab(
                          context,
                          isMobile,
                          '+80 CANAIS DE TV',
                          '+2000h de VOD',
                          '\$79,90 por mês',
                          startHD,
                          ['LIFE LINE'],
                        ),
                        _buildPlanTab(
                          context,
                          isMobile,
                          '+120 CANAIS DE TV',
                          '+3000h de VOD',
                          '\$119,90 por mês',
                          topHD,
                          ['LIFE LINE', 'START HD'],
                        ),
                        _buildPlanTab(
                          context,
                          isMobile,
                          '+130 CANAIS DE TV',
                          '+4000h de VOD',
                          '\$149,90 por mês',
                          premiumHD,
                          ['LIFE LINE', 'START HD', 'TOP HD'],
                        ),
                      ],
                      onChange: (index) => print(index),
                    ),
                  ),
                  SizedBox(height: isMobile ? 40 : 100),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanTab(
    BuildContext context,
    bool isMobile,
    String channelCount,
    String vodHours,
    String price,
    List<String> images,
    List<String> includedPlans,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              channelCount,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            vodHours,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 16 : 20,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 16 : 20,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (includedPlans.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 4 : 8,
                runSpacing: isMobile ? 4 : 0,
                children: includedPlans.map((plan) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle, size: isMobile ? 16 : 24),
                      SizedBox(width: 2),
                      Text(
                        plan,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 14 : 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          Expanded(
            child: GridView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: isMobile
                      ? const EdgeInsets.all(8)
                      : const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(images[index]),
                );
              },
              itemCount: images.length,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 3 : 5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isMobile ? 1 : 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
