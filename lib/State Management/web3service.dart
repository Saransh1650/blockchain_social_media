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
    projectId: 'a9a9881b4a61d564555fe9e76cd0980d',
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
        EthereumAddress.fromHex('0xD07B2318a33579Af3057D151666508E480e83077'),
      );

      // Get balance of wallet
      var result = await w3mService.requestReadContract(
          deployedContract: deployedContract,
          functionName: 'ViewAllPosts',
          rpcUrl: 'https://ethereum-sepolia-rpc.publicnode.com',
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
        EthereumAddress.fromHex('0xD07B2318a33579Af3057D151666508E480e83077'),
      );

await w3mService.launchConnectedWallet();
      await w3mService.requestWriteContract(
        method: "POST",
          topic: w3mService.session!.topic.toString(),
          chainId: "eip155:80001",
          rpcUrl: 'https://polygon-mumbai.blockpi.network/v1/rpc/public',
          deployedContract: deployedContract,
          functionName: 'postMedia',
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
