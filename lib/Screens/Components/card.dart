import 'package:blockchain_dapp/Screens/Components/tip_dialog_box.dart';
import 'package:blockchain_dapp/State%20Management/web3service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3modal_flutter/widgets/avatars/w3m_account_avatar.dart';

class Cards extends StatelessWidget {
  final String content, ipfs, address;
  final BigInt id,no;
  Cards(
      {super.key,
      required this.content,
      required this.ipfs,
      required this.address, required this.id, required this.no});
  final Web3Service w3c = Get.put(Web3Service());
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                color: Colors.grey, // Shadow color
                // Spread radius
                blurRadius: 7, // Blur radius
                // Offset from the top-left corner
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(15))),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 80,
                      child: ClipOval(
                        child:
                            W3MAccountAvatar(service: w3c.w3mService, size: 60),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          address.length > 9
                              ? '${address.substring(0, 9 ~/ 2)}...${address.substring(address.length - (9 ~/ 2))}'
                              : address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              height: 230,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft:
                      Radius.circular(15), // Adjust the radius as needed
                  bottomRight:
                      Radius.circular(15), // Adjust the radius as needed
                ),
                child: CachedNetworkImage(
                  height: 200,
                  imageUrl: "https://ipfs.io/ipfs/$ipfs",
                  alignment: Alignment.center,
                  placeholder: (context, url) {
                    return CircularProgressIndicator();
                  },
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),

                  
                 
                ),
              ),
            
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      enableFeedback: true,
                      side: BorderSide(color: Color.fromARGB(66, 0, 0, 0)),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        foregroundColor: Colors.black),
                    onPressed: () {
                      Get.defaultDialog(
                        backgroundColor: Colors.black,
                        title: "Tip the creator",
                        titleStyle: TextStyle(color: Colors.white),
                      
                       content:  TipDialogBox(id: id));
                    },
                    child: Row(
                      children: [
                        
                        Image.asset('assets/Ethereum_logo_2014.svg.png', height: 20,),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Tip')
                      ],
                    )),
                IconButton(
                  icon: Icon(Icons.people),
                  onPressed: () {},
                ),
                Text(no.toString())
              ],
            )
          ],
        ));
  }
}
