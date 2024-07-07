import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imake/components/custom_app_bar.dart';
import 'package:imake/utils/color_palette.dart';

class AboutDevScreen extends StatelessWidget {
  const AboutDevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
            backgroundColor: kWhiteColor,
            appBar: CustomAppBar(
              title: 'Sobre os desenvolvedores',
            ),
            body: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                          textAlign: TextAlign.justify,
                          "Este aplicativo foi criado como parte de um trabalho de pós-graduação em desenvolvimento de software web e mobile, realizado em 2024. O projeto é uma colaboração entre dois desenvolvedores dedicados: o professor Roberson Junior Fernandes Alves, principal autor, e a colaboradora Fernanda Ferrari. ")),
                  Text(
                      textAlign: TextAlign.justify,
                      "Desenvolvido em parceria com a Universidade do Oeste de Santa Catarina, o aplicativo reflete o compromisso com a inovação tecnológica e a excelência acadêmica. O objetivo é fornecer uma ferramenta útil e eficiente que atenda às necessidades dos usuários, com base em pesquisas e práticas de desenvolvimento de ponta.")
                ],
              ),
            )));
  }
}
