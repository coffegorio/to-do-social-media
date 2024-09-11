// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final List<String> titles = [
      "Ставьте цели и достигайте их",
      "Делитесь успехами с другими",
      "Персонализируйте свой профиль"
    ];

    final List<String> subtitles = [
      "Превратите свои амбиции в реальность с четкими целями. Следите за прогрессом и достигайте новых высот, начиная с малого.",
      "Вдохновляйте и вдохновляйтесь, делясь успехами. Создавайте сообщества, где вы можете обмениваться опытом и поддержкой.",
      "Выразите свою индивидуальность через настройки профиля. Сделайте его уникальным с помощью аватара, цветов и личных данных."
    ];

    final List<String> images = ["tasks.jpg", "community.jpg", "profiles.png"];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: titles.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: screenWidth * 0.065,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          height: screenHeight *
                              0.02), // Отступ между заголовком и подзаголовком
                      Text(
                        subtitles[index],
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: index < 2
                            ? screenHeight * 0.1
                            : screenHeight * 0.05,
                      ), // Отступ между текстом и изображением
                      Image.asset(
                        "assets/welcome_page_assets/" + images[index],
                        height: screenHeight * 0.4,
                        fit: BoxFit.cover,
                      ),
                      if (index ==
                          2) // Условие отображения кнопки на третьем экране
                        SizedBox(
                            height: screenHeight *
                                0.05), // Отступ между изображением и кнопкой
                      if (index == 2)
                        Flexible(
                          child: Align(
                            alignment: Alignment.bottomLeft.add(Alignment(0, -1.7)),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.03),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenHeight * 0.02,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                              child: Text(
                                'Вперед!',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: screenHeight * 0.03,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: titles.length,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: screenWidth * 0.02,
                    dotWidth: screenWidth * 0.02,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
