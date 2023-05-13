
import 'package:flutter/material.dart';
import 'package:shop_app_1/modules/shop_login/shop_login.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/network/local/shared_preferences/cashe_helper.dart';
import 'package:shop_app_1/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class shop_onBoarding extends StatefulWidget {
  @override
  State<shop_onBoarding> createState() => _shop_onBoardingState();
}

class _shop_onBoardingState extends State<shop_onBoarding> {
  var boardingController = PageController();

  List<BoardingModel> boardingList = [
    BoardingModel(
        image: 'assets/images/onboarding_1.jpg',
        title: 'Boarding 1 Title',
        body: 'Boarding 1 body'),
    BoardingModel(
        image: 'assets/images/onboarding_1.jpg',
        title: 'Boarding 2 Title',
        body: 'Boarding 2 body'),
    BoardingModel(
        image: 'assets/images/onboarding_1.jpg',
        title: 'Boarding 3 Title',
        body: 'Boarding 3 body'),
  ];

  bool isLast = false;

  void submit(){
    CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value!){
        navigateAndFinish(context, ShopLogin());
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == boardingList.length - 1) {
                    print('last page');
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    print('not last page');
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    BuildBoardingItem(boardingList[index]),
                itemCount: boardingList.length,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    count: boardingList.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 4.0,
                      expansionFactor: 3.0,
                      spacing: 5.0,
                    )),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit;
                    } else {
                      boardingController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_sharp,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      );
}

class BoardingModel {
  String image;
  String title;
  String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
