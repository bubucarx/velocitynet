library velocitynet.contact;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocitynet/footer.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    // Variáveis responsivas
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final headerHeight = isMobile ? 120.0 : 180.0;
    final titleFontSize = isMobile ? 22.0 : 28.0;
    final iconSize = isMobile ? 30.0 : 40.0;
    final cardPadding = isMobile ? 12.0 : 16.0;
    final textFontSize = isMobile ? 14.0 : 18.0;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho com gradiente
            Container(
              height: headerHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF13294E),
                    Color(0xFF1E3A8A),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),

            // Conteúdo principal
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 24 : 32,
              ),
              child: Column(
                children: [
                  // Título
                  Text(
                    'NOSSOS CANAIS DE ATENDIMENTO',
                    style: GoogleFonts.poppins(
                      color: Color(0xff343434),
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 24 : 40),

                  // Lista de contatos
                  InkWell(
                    onTap: () {
                      launch("https://webchat.weellu.com/");
                    },
                    child: _buildContactCard(
                      icon: Image.asset('lib/assets/images/weellu_logo.png',
                          width: isMobile ? 35 : 45),
                      text: "Weellu Social / Velocitynet Telecom",
                      context: context,
                      isMobile: isMobile,
                      padding: cardPadding,
                      textFontSize: textFontSize,
                      iconSize: iconSize,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      launch("https://www.instagram.com/velocitynet.oficial/");
                    },
                    child: _buildContactCard(
                      icon: PhosphorIcon(
                        PhosphorIcons.instagramLogo(PhosphorIconsStyle.fill),
                        size: iconSize,
                        color: Colors.pink,
                      ),
                      text: "@velocitynet_oficial",
                      context: context,
                      color: Colors.pink[50],
                      isMobile: isMobile,
                      padding: cardPadding,
                      textFontSize: textFontSize,
                      iconSize: iconSize,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      launch("https://www.facebook.com/velocitynettelecom");
                    },
                    child: _buildContactCard(
                      icon: PhosphorIcon(
                        PhosphorIcons.facebookLogo(PhosphorIconsStyle.fill),
                        size: iconSize,
                        color: Colors.blue[800],
                      ),
                      text: "@velocitynettelecom",
                      context: context,
                      color: Colors.blue[50],
                      isMobile: isMobile,
                      padding: cardPadding,
                      textFontSize: textFontSize,
                      iconSize: iconSize,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      launch("https://api.whatsapp.com/send?phone=+559499260-0430&text=Olá, tudo bem?");
                    },
                    child: _buildContactCard(
                      icon: PhosphorIcon(
                        PhosphorIcons.whatsappLogo(PhosphorIconsStyle.fill),
                        size: iconSize,
                        color: Color(0xff25d366),
                      ),
                      text: "+55 (94) 99260-0430",
                      context: context,
                      color: Color(0xFFE8F5E9),
                      isMobile: isMobile,
                      padding: cardPadding,
                      textFontSize: textFontSize,
                      iconSize: iconSize,
                    ),
                  ),

                  _buildContactCard(
                    icon: PhosphorIcon(
                      PhosphorIcons.phone(PhosphorIconsStyle.fill),
                      size: iconSize,
                      color: Color(0xff343434),
                    ),
                    text: "+55 (94) 99132-6169",
                    context: context,
                    color: Colors.grey[100],
                    isMobile: isMobile,
                    padding: cardPadding,
                    textFontSize: textFontSize,
                    iconSize: iconSize,
                  ),

                  InkWell(
                    onTap: () {
                      launch("mailto:velocitynetfinanceiro@gmail.com");
                    },
                    child: _buildContactCard(
                      icon: PhosphorIcon(
                        PhosphorIcons.envelope(PhosphorIconsStyle.fill),
                        size: iconSize,
                        color: Color(0xFF690707),
                      ),
                      text: "velocitynetfinanceiro@gmail.com",
                      context: context,
                      color: Color(0xFFFFEBEE),
                      isMobile: isMobile,
                      padding: cardPadding,
                      textFontSize: textFontSize,
                      iconSize: iconSize,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      launch("https://maps.app.goo.gl/AYWLVsUVsNWPtz2E6");
                    },
                    child: _buildContactCard(
                      icon: PhosphorIcon(
                        PhosphorIcons.mapPin(PhosphorIconsStyle.fill),
                        size: iconSize,
                        color: Color(0xFFEB1010),
                      ),
                      text: "Av: B QD: 298 LT:23 - Cidade Jardim, Parauapebas - PA, 68515-000",
                      context: context,
                      color: Color(0xFFFFF3E0),
                      isMobile: isMobile,
                      padding: cardPadding,
                      textFontSize: textFontSize,
                      iconSize: iconSize,
                    ),
                  ),

                  SizedBox(height: isMobile ? 20 : 30),

                  // Rodapé
                ],
              ),
            ),
            Footer()
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required Widget icon,
    required String text,
    required BuildContext context,
    required bool isMobile,
    required double padding,
    required double textFontSize,
    required double iconSize,
    Color? color,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 6 : 8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: icon,
            ),
            SizedBox(width: isMobile ? 12 : 16),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: textFontSize,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff343434),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}