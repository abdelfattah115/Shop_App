import 'package:flutter/material.dart';
import 'login/login_screen.dart';
import '../shared/components/components.dart';
import '../shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ModelBoarding {
  String image;
  String title;
  String body;

  ModelBoarding(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  List<ModelBoarding> boarding = [
    ModelBoarding(
      'assets/images/onBoarding1.png',
      'Smart payment make',
      'smart lifestyle 1',
    ),
    ModelBoarding(
      'assets/images/onBoarding2.png',
      'Smart payment make',
      'smart lifestyle 2',
    ),
    ModelBoarding(
      'assets/images/onBoarding3.png',
      'Smart payment make',
      'smart lifestyle 3',
    ),
  ];

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPressed: submit,
              text: 'SKIP'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 5,
                    expansionFactor: 4,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (isLast) {
                       submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    });
                  },
                  child: const Icon(Icons.arrow_forward_ios,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(ModelBoarding model) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(
                  model.image,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              model.body,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      );
}
