import 'package:blockchain_dapp/Screens/connect_wallet.dart';
import 'package:blockchain_dapp/Screens/feed.dart';
import 'package:blockchain_dapp/State%20Management/web3service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:web3modal_flutter/widgets/w3m_network_select_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Web3Service w3c = Get.put(Web3Service());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("EtherFrame", style: TextStyle(color: Colors.white)),
        actions: [
          
          W3MNetworkSelectButton(service: w3c.w3mService)],
      ),
      body: Container(
          child: w3c.w3mService.isConnected ? const Feed() : ConnetWallet()),
    );
  }
}
