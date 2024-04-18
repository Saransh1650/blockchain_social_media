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
  Future<List<dynamic>> callReadFunction() async {
    List result =[];
    String abiJsonString = await rootBundle.loadString('assets/abi.json');
    List<dynamic> abiJson = jsonDecode(abiJsonString);
    // Create DeployedContract object using contract's ABI and address
    try {
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiJson), // ABI object
          'SocialMedia',
        ),
        EthereumAddress.fromHex('0x83572e84488a4d2b88905893F9E2c670244ab0D0'),
      );

      // Get balance of wallet
       result = await w3mService.requestReadContract(
          deployedContract: deployedContract,
          functionName: 'viewAllPosts',
          rpcUrl: 'https://rpc.sepolia.org',
          parameters: []);
          
      

    } catch (e) {
      print(e);
    }
    return result;
  }

   callWriteFunction(String title, String ipfs) async {
    String abiJsonString = await rootBundle.loadString('assets/abi.json');
    List<dynamic> abiJson = jsonDecode(abiJsonString);
    // Create DeployedContract object using contract's ABI and address
    try {
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiJson), // ABI object
          'SocialMedia',
        ),
        EthereumAddress.fromHex('0x83572e84488a4d2b88905893F9E2c670244ab0D0'),
      );

     
      await w3mService.requestWriteContract(
          topic: w3mService.session!.topic.toString(),
          chainId: 'eip155:11155111',
          rpcUrl: 'https://rpc2.sepolia.org',
          deployedContract: deployedContract,
          functionName: 'createPost',
          parameters: [title, ipfs],
          transaction: Transaction(
            from: EthereumAddress.fromHex(
                '${w3mService.session!.address}'),
          ));
        
    } catch (e) {
      print(e);
    }
  }

  tipCreator(BigInt amount, BigInt id) async{
    String abiJsonString = await rootBundle.loadString('assets/abi.json');
    List<dynamic> abiJson = jsonDecode(abiJsonString);
    // Create DeployedContract object using contract's ABI and address
    try {
      final deployedContract = DeployedContract(
        ContractAbi.fromJson(
          jsonEncode(abiJson), // ABI object
          'SocialMedia',
        ),
        EthereumAddress.fromHex('0x83572e84488a4d2b88905893F9E2c670244ab0D0'),
      );

     
      await w3mService.requestWriteContract(
          
          topic: w3mService.session!.topic.toString(),
          chainId: 'eip155:11155111',
          rpcUrl: 'https://rpc2.sepolia.org',
          deployedContract: deployedContract,
          functionName: 'tipPost',
          parameters: [amount, id],
          transaction: Transaction(
            value: EtherAmount.fromBigInt(EtherUnit.ether,amount),
            from: EthereumAddress.fromHex(
                "${w3mService.session!.address}"),
          ));
        
    } catch (e) {
      print(e);
    }
  }}