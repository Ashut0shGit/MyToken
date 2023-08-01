import 'package:my_token/Controllers/Coin_Controller.dart';
import 'package:my_token/screens/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {

  final CoinController controller = Get.put(CoinController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff494F55),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("MyToken Crypto Tracker",
                style: textStyle(25,Colors.white,FontWeight.bold),
              ),
              Obx(
                    ()=> controller.isLoading.value ?
                Center(child: CircularProgressIndicator() )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.coinList.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[700],
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[700]!,
                                          offset: const Offset(4,4),
                                          blurRadius: 5,
                                        ),
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.network(controller.coinList[index].image,fit: BoxFit.cover,),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(controller.coinList[index].name,
                                      style: textStyle(18,Colors.white,FontWeight.w700),),
                                    Text(
                                      "${controller.coinList[index].priceChange24H.toStringAsFixed(2)} %",
                                      style: textStyle(
                                          18,
                                          Colors.grey,
                                          FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "\$ ${controller.coinList[index].currentPrice}",
                                  style:
                                  textStyle(
                                      18,
                                      Colors.white,
                                      FontWeight.w700),
                                ),
                                Text(
                                  controller.coinList[index].symbol,
                                  style: textStyle(
                                      18,
                                      Colors.grey,
                                      FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
