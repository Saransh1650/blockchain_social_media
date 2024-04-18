import 'package:blockchain_dapp/State%20Management/web3service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';

class TipDialogBox extends StatelessWidget {
  final BigInt id;
  TipDialogBox({super.key, required this.id});
  final Web3Service w3c = Get.put(Web3Service());
  late BigInt amount;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  amount = BigInt.parse(value);
                },
                decoration: InputDecoration(
                    hintText: "Amount (in ethers)",
                    hintStyle: TextStyle(color: Colors.white))),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SliderButton(
                action: () async {
                try { w3c.w3mService.launchConnectedWallet();
                  w3c.tipCreator(amount, id);
                  return true;}
                  catch (e) {
                    print(e);
                    return false;
                  }
                },
                label: const Text(
                  "Slide to Pay",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: Image.asset(
                  'assets/Ethereum_logo_2014.svg.png',
                  height: 45,
                ),
              ),
            )
          ],
        ));
  }
}
