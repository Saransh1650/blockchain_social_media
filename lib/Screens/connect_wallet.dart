import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blockchain_dapp/Screens/feed.dart';
import 'package:blockchain_dapp/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3modal_flutter/utils/toast/toast_message.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:web3modal_flutter/widgets/toast/walletconnect_modal_toast.dart';

import '../State Management/web3service.dart';

class ConnetWallet extends StatelessWidget {
  ConnetWallet({super.key});

  final Web3Service w3c = Get.put(Web3Service());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: AnimateGradient(
      animateAlignments: true,
      duration: const Duration(seconds: 10),
      primaryBegin: Alignment.topLeft,
      primaryEnd: Alignment.bottomLeft,
      secondaryBegin: Alignment.bottomRight,
      secondaryEnd: Alignment.topRight,
      primaryColors: const [
        Colors.pink,
        Colors.pinkAccent,
        Colors.white,
      ],
      secondaryColors: const [
        Colors.white,
        Colors.blueAccent,
        Colors.blue,
      ],
      child: Container(
        padding: const EdgeInsets.all(10),
        child: 
        
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to EtherFrame',
                  
                  style: TextStyle(
                    
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(),
                SizedBox(
              width: double.infinity,
              height: 300,
              child: DefaultTextStyle(
                style: const TextStyle(
            
                  fontSize: 50.0,
                  fontFamily: 'Agne',
                  fontWeight: FontWeight.bold
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  animatedTexts: [
            TypewriterAnimatedText('Decentralized'),
            TypewriterAnimatedText('Secure'),
            TypewriterAnimatedText('Pay using crypto'),
            TypewriterAnimatedText('Smart Contract based Dapp'),
                  ],
                  onTap: () {
            print("Tap Event");
                  },
                ),
              ),
            ),
            
                InkWell(
                  onTap: () async {
                    
                    if(w3c.w3mService.isConnected){
                      Get.to(const Feed());
                    }
                  },
                  child: W3MConnectWalletButton(
                    
                    service: w3c.w3mService),
                ),
              
                WalletConnectModalToast(
                
                    message: ToastMessage(
                        type: ToastType.info, text: "Welcome"))
              ],
            ),
            TextButton(onPressed: (){
              if(w3c.w3mService.isConnected){
                Get.off(()=>HomeScreen(),
                
                );

              }
              else{
                const WalletConnectError(message: "Wallet not connected",data: "", code: 404);
              }
              
            },child: const Text("Enter the feed ->", style: TextStyle(color: Colors.blue)),)
          ],
        ),
      ),
    ));
  }
}
