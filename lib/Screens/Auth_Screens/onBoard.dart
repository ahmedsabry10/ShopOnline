

import 'package:flutter/material.dart';
import 'package:shop/Network/Shared/cache_helper.dart';
import 'package:shop/Screens/login_screen.dart';
import 'package:shop/Network/Component/reusable_component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';





class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'https://img.freepik.com/free-vector/e-wallet-concept-illustration_114360-7561.jpg?w=740&t=st=1662226962~exp=1662227562~hmac=9b3f68e9927b6ba3f3962b31c7f29ab0d195b92a8f21fac5c4e4932a8ac7b1d2',
      title: 'Happiness',
      body: 'Keep calm and shop online',
    ),
    BoardingModel(
      image: 'https://img.freepik.com/free-vector/credit-card-concept-illustration_114360-170.jpg?1&w=740&t=st=1662226654~exp=1662227254~hmac=05c76eef65c8715f42907ad9db1d40587fe4fba34a1ffae382bc0f5feb58d020',
      title: 'Easing',
      body: 'If you can\'t stop thinking about something buy it ',
    ),
    BoardingModel(
      image: 'https://img.freepik.com/free-vector/successful-purchase-concept-illustration_114360-1003.jpg?size=338&ext=jpg&ga=GA1.2.486165207.1662226601',
      title: 'Saving ',
      body: 'Save your time and money just enjoy',
    ),
  ];


  var boardController =PageController();
  bool isLast=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onSubmit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value){
        navigateAndFinish(context, LoginScreen(),);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions :[
            TextButton(
                onPressed:(){
                  onSubmit();
                },
                child: const Text(
                    'SKIP'
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index){
                    if (index==boarding.length-1){
                      setState(() {
                        isLast=true;
                      });
                    }else
                    {
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                  itemBuilder: (context ,index)=>buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              Row(
                children:  [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      activeDotColor: Colors.deepOrange,
                      expansionFactor: 2,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        onSubmit();
                      }
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 720,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )

    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: NetworkImage(model.image),

        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.body,
        style:const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),

    ],
  );
}
