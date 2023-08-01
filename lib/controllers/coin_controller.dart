import 'package:my_token/Models/Coin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CoinController extends GetxController{
  RxBool isLoading = true.obs;
  RxList<Coin> coinList = <Coin>[].obs;

  @override
  onInit(){
    super.onInit();
    fetchCoins();
  }

  fetchCoins() async{
    try{
      isLoading(true);
      var response = await http.get(
          Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));
      List<Coin> coins = coinFromJson(response.body);
      const double usdToInrExchangeRate = 80.0;
      for (var coin in coins) {
        coin.currentPrice *= usdToInrExchangeRate;
      }
      coinList.assignAll(coins);
    }finally{
      isLoading(false);
    }

  }

}
