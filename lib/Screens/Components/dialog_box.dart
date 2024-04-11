import 'package:flutter/material.dart';
import 'package:flutter_ipfs/flutter_ipfs.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const TextField(
            style: TextStyle(color: Colors.white),

            decoration: InputDecoration(
                
                hintText: "Write your thoughts",
                hintStyle: TextStyle(color: Colors.white)),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.image,
                color: Colors.white,
              )),
              Center(
            child: ElevatedButton(
              onPressed: () async {
                await ImagePickerService.pickImage(context);
                print(ImagePickerService.cid);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => VideoPickerService.pickVideo(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'Upload Video',
                    style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {},
            child: const Text(
              "Post ->",
              style: TextStyle(color: Colors.white),
            ),
          ),

        ],
      ),
    );
  }
}
