
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excelfile/feedback_model.dart';
import 'package:excelfile/screens/file_excel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import'dart:convert' as convert;

class ScanViewModel extends GetxController {
   List<FeedbackModel> feedbacks = [];
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'cancel',
        true,
        ScanMode.BARCODE,
      );
      debugPrint(barcodeScanRes);
      print('Barcode: $barcodeScanRes');

      // قم بتنفيذ البحث في Firestore باستخدام الباركود الممسوح ضوئيًا
      await compareBarcode(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
 Future<void> fetchData() async {
    try {
      var url = "https://sheets.googleapis.com/v4/spreadsheets/1dTTv7YQhlWvaCdqL7OoVPcJfMxUoUB7xjYq3bHLLa-Q/values/t?dateTimeRenderOption=SERIAL_NUMBER&majorDimension=ROWS&valueRenderOption=FORMATTED_VALUE&key=AIzaSyBQyir180_Rh6s36hRLSAzoaCpY07ZcKOk";
    var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
   var jsonData = convert.jsonDecode(response.body);
List<FeedbackModel> tempFeedbacks = [];

if (jsonData.containsKey('values')) {
  var values = jsonData['values'];

  for (var i = 1; i < values.length; i++) {
    var item = values[i];
    if (item is List<dynamic>) {
      var feedback = FeedbackModel.fromJson({
        'ProfilePic': item[0],
        'Barcode': item[1],
        'Name': item[2],
        'Age': int.tryParse(item[3]) ?? 0,
        'Class': item[4],
      });
      tempFeedbacks.add(feedback);
       Get.to(() => FileExcelPage(
             feedbackData: feedback,
            ));
    }
  }

}
 
  @override
  void onInit() {
    super.onInit();
       feedbacks = tempFeedbacks;
       
  }


      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  
  Future<void> compareBarcode(String scannedBarcode) async {
    List<FeedbackModel> tempFeedbacks = [];
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Students')
          .where('barcode', isEqualTo: scannedBarcode)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        fetchData();
        // Get.to(file)
        // تم العثور على باركود متطابق
        // يمكنك تنفيذ الإجراءات المطلوبة هنا مثل تحديث واجهة المستخدم وعرض البيانات المتعلقة بالباركود المطابق
        print('تم العثور على باركود متطابق.');

        for (var doc in querySnapshot.docs) {
          var data = doc.data();
          print('اسم: ${data['name']}');
          print('العمر: ${data['age']}');
          print('الفصل: ${data['class']}');
        }

      } else {
        // إذا لم يتم العثور على باركود متطابق
        print('لم يتم العثور على باركود متطابق.');
      }
    } catch (e) {
      print('Error querying Firestore: $e');
    }
  }
}

