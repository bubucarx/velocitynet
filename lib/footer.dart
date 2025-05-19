import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocitynet/oletv.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 900;

    // Função para calcular tamanho de texto responsivo
    double responsiveTextSize(double size) {
      if (isSmallScreen) return size * 0.8;
      if (isMediumScreen) return size * 0.9;
      return size;
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff08203E),
            Color(0xff06141C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 32,
            vertical: isSmallScreen ? 30 : 50),
        child: Column(
          children: [
            isSmallScreen
                ? _buildMobileLayout(context, responsiveTextSize)
                : _buildDesktopLayout(context, responsiveTextSize),
            const SizedBox(height: 30),
            _buildFooterBottom(context, responsiveTextSize),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, Function responsiveTextSize) {
    return Column(
      children: [
        _buildCategoriesSection(context, responsiveTextSize),
        const SizedBox(height: 30),
        _buildContactSection(context, responsiveTextSize),
        const SizedBox(height: 30),
        _buildHoursSection(context, responsiveTextSize),
      ],
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context, Function responsiveTextSize) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      runSpacing: 40,
      spacing: 40,
      children: [
        _buildCategoriesSection(context, responsiveTextSize),
        _buildContactSection(context, responsiveTextSize),
        _buildHoursSection(context, responsiveTextSize),
      ],
    );
  }

  Widget _buildCategoriesSection(
      BuildContext context, Function responsiveTextSize) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CATEGORIAS',
            style: GoogleFonts.poppins(
              color: const Color(0xffffffff),
              fontWeight: FontWeight.bold,
              fontSize: responsiveTextSize(18),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Link Dedicado',
            style: GoogleFonts.poppins(
              color: const Color(0xffDED4D4),
              fontSize: responsiveTextSize(16),
              height: 2,
            ),
          ),
          InkWell(
            onTap: () {
              Oletv();
            },
            child: Text(
              'TV por assinatura',
              style: GoogleFonts.poppins(
                color: const Color(0xffDED4D4),
                fontSize: responsiveTextSize(16),
                height: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(
      BuildContext context, Function responsiveTextSize) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CANAIS DE ATENDIMENTO',
            style: GoogleFonts.poppins(
              color: const Color(0xffffffff),
              fontSize: responsiveTextSize(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Financeiro',
                style: GoogleFonts.poppins(
                  color: const Color(0xffDED4D4),
                  fontSize: responsiveTextSize(16),
                ),
              ),
              Text('+55 (94) 99104-5810',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: responsiveTextSize(18),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WhatsApp',
                style: GoogleFonts.poppins(
                  color: const Color(0xffDED4D4),
                  fontSize: responsiveTextSize(16),
                ),
              ),
              Text('+55 (94) 99260-0430',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: responsiveTextSize(18),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ligação',
                style: GoogleFonts.poppins(
                  color: const Color(0xffDED4D4),
                  fontSize: responsiveTextSize(16),
                ),
              ),
              Text(
                '+55 (94) 99132-6169',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: responsiveTextSize(18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Redes Sociais',
            style: GoogleFonts.poppins(
              color: const Color(0xffDED4D4),
              fontSize: responsiveTextSize(16),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              InkWell(
                onTap: () {
                  launch("https://www.facebook.com/velocitynettelecom");
                },
                child: _buildSocialIcon(
                  icon: const Icon(Icons.facebook, color: Colors.white),
                  size: responsiveTextSize(25),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  launch("mailto:velocitynetfinanceiro@gmail.com");
                },
                child: _buildSocialIcon(
                  icon: PhosphorIcon(
                    PhosphorIcons.envelope(PhosphorIconsStyle.regular),
                    color: Colors.white,
                  ),
                  size: responsiveTextSize(25),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  launch("https://www.instagram.com/velocitynet.oficial/");
                },
                child: _buildSocialIcon(
                  icon: PhosphorIcon(
                    PhosphorIcons.instagramLogo(PhosphorIconsStyle.regular),
                    color: const Color(0xffffffff),
                  ),
                  size: responsiveTextSize(25),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  launch("https://webchat.weellu.com/");
                },
                child: _buildSocialIcon(
                  icon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      'lib/assets/images/vetor_velocitynet.png',
                      color: const Color(0xffffffff),
                    ),
                  ),
                  size: responsiveTextSize(25),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoursSection(BuildContext context, Function responsiveTextSize) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HORARIO ATENDIMENTO',
            style: GoogleFonts.poppins(
              color: const Color(0xffffffff),
              fontWeight: FontWeight.bold,
              fontSize: responsiveTextSize(18),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Segunda - Sexta',
            style: GoogleFonts.poppins(
              fontSize: responsiveTextSize(16),
              color: const Color(0xffDED4D4),
            ),
          ),
          Text(
            '08:00h - 18:00h',
            style: GoogleFonts.poppins(
              color: const Color(0xffffffff),
              fontSize: responsiveTextSize(16),
              fontWeight: FontWeight.bold,
              height: 2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sábados',
            style: GoogleFonts.poppins(
              fontSize: responsiveTextSize(16),
              color: const Color(0xffDED4D4),
            ),
          ),
          Text(
            '08:00h - 13:00h (Presencial)\n13:00h - 18:00h (Online)',
            style: GoogleFonts.poppins(
              color: const Color(0xffffffff),
              fontSize: responsiveTextSize(16),
              fontWeight: FontWeight.bold,
              height: 2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Domingo / Feriado',
            style: GoogleFonts.poppins(
              fontSize: responsiveTextSize(16),
              color: const Color(0xffDED4D4),
            ),
          ),
          Text(
            'Sem atendimento',
            style: GoogleFonts.poppins(
              color: const Color(0xffffffff),
              fontSize: responsiveTextSize(16),
              fontWeight: FontWeight.bold,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBottom(BuildContext context, Function responsiveTextSize) {
    return Column(
      children: [
        Text(
          '© 2024 Velocitynet | Todos os direitos reservados.',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: responsiveTextSize(15),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'Velocitynet Telecom LTDA - CNPJ: 24.513.378/0001-57 - velocitynet@velocitynet.com.br',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: responsiveTextSize(15),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSocialIcon({required Widget icon, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF274972),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Center(child: icon),
    );
  }
}
