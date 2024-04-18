// ignore_for_file: prefer_const_constructors

import 'package:animated_icon/animated_icon.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blockchain_dapp/State%20Management/web3service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_ipfs/flutter_ipfs.dart';
import 'package:get/get.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {

    final Web3Service w3c = Get.put(Web3Service());
    final myController = TextEditingController();
    String text="";

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
            TyperAnimatedText("Add Image or Video",
                textStyle: TextStyle(color: Colors.white, fontSize: 25))
          ]),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blueAccent)),
                child: AnimateIcon(
                  onTap: () async {
                    await ImagePickerService.pickImage(context);
                    print(ImagePickerService.cid);
                  },
                  animateIcon: AnimateIcons.file,
                  iconType: IconType.continueAnimation,
                  color: Colors.white,
                ),
              ),
              Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blueAccent)),
                  child: AnimateIcon(
                    onTap: () => VideoPickerService.pickVideo(context),
                    animateIcon: AnimateIcons.liveVideo,
                    iconType: IconType.continueAnimation,
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(height: 10),
           TextField(
            
            controller: myController,
            onChanged: (value) {
              text = value;
            },

            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Write your thoughts",
                hintStyle: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          AnimatedButton(
           
            isReverse: true,
            animatedOn: AnimatedOn.onTap,
            borderColor: Colors.blueAccent,
            backgroundColor: Colors.white,
            selectedBackgroundColor: Colors.black,
            borderRadius: 10,
            width: 200,
            text: 'Post',
            selectedTextColor: Colors.blueAccent,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            textStyle: TextStyle(
                fontSize: 28,
                letterSpacing: 5,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w300),
            onPress: () async {
             try{ if(ImagePickerService.cid == ""){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please select an image"),
                ));
                
              }
              else{
                await w3c.w3mService.launchConnectedWallet();
                await w3c.callWriteFunction(text,ImagePickerService.cid);
            
                 print("okok");
              }
              }
              catch(e){
                print(e);
              }
            },
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
