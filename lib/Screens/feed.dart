import 'package:blockchain_dapp/Screens/Components/card.dart';
import 'package:blockchain_dapp/Screens/Components/dialog_box.dart';
import 'package:blockchain_dapp/State%20Management/web3service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    final Web3Service w3c = Get.put(Web3Service());
    w3c.onInit();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
          
          Get.defaultDialog(
            content: const DialogBox(),
            title: "Post on Blockchain",
            backgroundColor: Colors.black,
            titleStyle: const TextStyle(color: Colors.white)
          );
           
          },
          backgroundColor: Colors.black,
          child: const Text(
            "+",
            style: TextStyle(color: Colors.white, fontSize: 25),
          )),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const Cards();
        },
        itemCount: 10,
      ),
    );
  }
}
