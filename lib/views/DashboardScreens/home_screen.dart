import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20,),
              _buildSectionTitle('Horizontal Align:',TextStyle(fontFamily: 'Poppins')),
              _buildHorizontalImageList(controller.imagePaths),
              SizedBox(height: 20),
              _buildSectionTitle('Vertical Align:',TextStyle(fontFamily: 'Poppins')),
              _buildVerticalImageList(controller.imagePaths),
              SizedBox(height: 20),
              _buildSectionTitle('Grid View:',TextStyle(fontFamily: 'Poppins')),
              _buildImageGridView(controller.imagePaths),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextStyle textStyle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHorizontalImageList(RxList<String> imagePaths) {
    return Obx(() => Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return _buildRoundedImageCard(imagePaths[index]);
        },
      ),
    ));
  }

  Widget _buildVerticalImageList(RxList<String> imagePaths) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return _buildRoundedImageCard(imagePaths[index]);
      },
    ));
  }

  Widget _buildImageGridView(RxList<String> imagePaths) {
    return Obx(() => GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return _buildRoundedImageCard(imagePaths[index]);
      },
    ));
  }

  Widget _buildRoundedImageCard(String assetPath) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.asset(
          assetPath,
          width: 200,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
