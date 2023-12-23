
import 'package:excelfile/view_model/scan_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 9, 42, 68),
        title: Center(child: Text('Barcode Scan',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
      body: GetBuilder<ScanViewModel>(
        builder:(controller)=> Center(
          child: Container(
            child: GestureDetector( onTap: (){
                          controller.scanBarcodeNormal();
                        },
                        child: Icon(Icons.camera_alt_rounded,size: 50,),
            ),
          ),
        ),
      ),
    );
  }
}