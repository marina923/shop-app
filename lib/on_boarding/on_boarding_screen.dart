import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopapp/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/network/local/cashe_helper.dart';

class BoardingItem {
  final String title;
  final String body;
  final String image;

  BoardingItem({
    required this.title,
    required this.body,
    required this.image,
  });
}

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<BoardingItem> boarding = [
    BoardingItem(
        title: "OnBoarding Title one",
        body: "OnBoarding Body one",
        image: 'assets/images/one.png'),
    BoardingItem(
        title: "OnBoarding Title Two",
        body: "OnBoarding Body Two",
        image: 'assets/images/two.png'),
    BoardingItem(
        title: "OnBoarding Title Three",
        body: "OnBoarding Body Three",
        image: 'assets/images/three.png'),
  ];

  var boardController = PageController();

  bool isLast=true;
void submit()async{
  CasheHelper.saveData(key: 'onBoarding', value: true).then((value){if(value){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
        LoginScreen(),), (route) => false);
  }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child:Text("Skip"),),
        ],
      ),
      body: PageView.builder(
        onPageChanged: (int index){
          if(index==boarding.length-1){
            setState(() {
              isLast=true;
            });
          }else{
            setState(() {
              isLast=false;
            });
          }
        },
        itemBuilder: (context, index) => buildOnBoardingItem(boarding[index]),
        itemCount: boarding.length,
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingItem model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            )),
        SizedBox(
          height: 2.h,
        ),
        Text(
          "${model.title}",
          style: TextStyle(fontSize: 18.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "${model.body}",
          style: TextStyle(fontSize: 12.sp),
        ),
        Row(
          children: [
            SmoothPageIndicator(
              controller: boardController,
              count: boarding.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.blueAccent,
                dotHeight: 10.0,
                spacing: 5.0,
                dotWidth: 10.0,
                dotColor: Colors.grey,
              ),
            ),
            Spacer(),
            FloatingActionButton(
              onPressed: () {
                if(isLast){
                  submit();
                }
                boardController.nextPage(
                  duration: Duration(
                    milliseconds: 750,
                  ),
                  curve: Curves.easeInOut,
                );
              },
              child: Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
