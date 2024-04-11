import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
   const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color:Colors.white,
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
        height: 360,
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
                        child: Image.network(
                          'https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      children: [Text("Marshmallow", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)],
                    )
                  ],
                )
              ],
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: const Text(
                    "Beautiful Scenery potshot completed with the following...")),
            Stack(
              children: [
                SizedBox(
                  height: 230,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft:
                          Radius.circular(15), // Adjust the radius as needed
                      bottomRight:
                          Radius.circular(15), // Adjust the radius as needed
                    ),
                    child: Image.network(
                      'https://img.freepik.com/free-photo/vestrahorn-mountains-stokksnes-iceland_335224-667.jpg?size=626&ext=jpg&ga=GA1.1.735520172.1710806400&semt=ais',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    height: 35,
                    width: 90,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(196, 255, 235, 59),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: const InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.currency_bitcoin,
                            color: Colors.black,
                          ),
                          Text(
                            "Reward",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
               
                        
                Positioned(
                  bottom: 10,
                  left: 110,
                  child: Container(
                    height: 35,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(169, 175, 76, 76),
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    child: const Tooltip(
                      message: 'Number of people rewarded the creator',
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.black,
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
