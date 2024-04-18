import 'package:blockchain_dapp/Screens/Components/card.dart';
import 'package:blockchain_dapp/Screens/Components/dialog_box.dart';
import 'package:blockchain_dapp/State%20Management/web3service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    final Web3Service w3c = Get.put(Web3Service());
    w3c.onInit();
    

    return Scaffold(
  
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
                onCancel: () {
                  setState(() {
                    
                  });
                },
                content: const DialogBox(),
                title: "Post on Blockchain",
                backgroundColor: Colors.black,
                titleStyle: const TextStyle(color: Colors.white));

          },
          backgroundColor: Colors.black,
          child: const Text(
            "+",
            style: TextStyle(color: Colors.white, fontSize: 25),
          )),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: FutureBuilder(
          future: w3c.callReadFunction(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<dynamic> feedData = snapshot.data ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  var ipfs = feedData[index][3];
                  var content = feedData[index][2];
                  var address = feedData[index][5];
                  BigInt id = feedData[index][0];
                  BigInt tipNo = feedData[index][1];
                  return Cards(content: content, ipfs: ipfs, address: address.toString(), id: id, no: tipNo,);
                },
                itemCount: feedData.length,
              );
            }
          }),
    );
  }
}
