import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class Web3Service extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    w3mService.init();
    await callReadFunction();
  }

  final w3mService = W3MService(
    projectId: '09c1e0a4ddd830cfbdb63bf3efc73436',
    metadata: const PairingMetadata(
      name: 'EtherFrame',
      description: 'Decentralized Photo App',
      url: 'https://www.walletconnect.com/',
      icons: ['https://walletconnect.com/walletconnect-logo.png'],
      redirect: Redirect(
        native: 'flutterdapp://',
        universal: 'https://www.walletconnect.com',
      ),
    ),
  );

// Register callbacks on the Web3App you'd like to use. See `Events` section.
  Future<void> callReadFunction() async {
    String abiJsonString = await rootBundle.loadString('assets/abi.json');
    List<dynamic> abiJson = jsonDecode(abiJsonString);
    // Create DeployedContract object using contract's ABI and address
    try {
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiJson), // ABI object
          'SocialMedia',
        ),
        EthereumAddress.fromHex('0x3d76d069e27D31206b92f1BA6EC606A44dE2273f'),
      );

      // Get balance of wallet
      var result = await w3mService.requestReadContract(
          deployedContract: deployedContract,
          functionName: 'viewAllPosts',
          rpcUrl: 'https://rpc.sepolia.org',
          parameters: []);
      print(result);

      //await w3mService.requestWriteContract(
      //   topic: w3mService.session!.topic.toString() ,
      //   chainId: '11155111',
      //   rpcUrl: 'https://1rpc.io/sepolia',
      //   deployedContract: deployedContract,
      //   functionName: 'createPost',
      //   parameters: ["hi","ww.ww.ww"],
      //   transaction: Transaction()
      // );
    } catch (e) {
      print(e);
    }
  }

  Future<void> callWriteFunction(String title, String ipfs) async {
    String abiJsonString = await rootBundle.loadString('assets/abi.json');
    List<dynamic> abiJson = jsonDecode(abiJsonString);
    // Create DeployedContract object using contract's ABI and address
    try {
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiJson), // ABI object
          'SocialMedia',
        ),
        EthereumAddress.fromHex('0x3d76d069e27D31206b92f1BA6EC606A44dE2273f'),
      );

      await w3mService.launchConnectedWallet();
      await w3mService.requestWriteContract(
      
        
          topic: w3mService.session!.topic.toString(),
          chainId: 'eip155:11155111',
          rpcUrl: 'https://rpc.sepolia.org',
          deployedContract: deployedContract,
          functionName: 'createPost',
          parameters: [title, ipfs],
          transaction: Transaction(
            from: EthereumAddress.fromHex(
                '0xAd69146A55DcA5E6a7FbA9315683C9226E2f6c33'),
          ));
      
    } catch (e) {
      print(e);
    }
  }
}
