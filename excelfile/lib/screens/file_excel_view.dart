
// استخدم الفئة FileExcel لعرض البيانات المتعلقة بالباركود في صفحة أخرى
import 'package:excelfile/feedback_model.dart';
import 'package:flutter/material.dart';

class FileExcelPage extends StatelessWidget {
   final FeedbackModel feedbackData;
  FileExcelPage({
    required this.feedbackData });

  @override
  Widget build(BuildContext context) {
    // قم بتنسيق واجهة المستخدم هنا لعرض البيانات المتعلقة بالباركود
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 42, 68),
        title: Center(child: Text('بيانات الباركود',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Container(
                    height:100 ,
                    width: 100,
                    child: CircleAvatar(
                          backgroundImage: NetworkImage(feedbackData.profilePic),
                        ),),
              SizedBox(height: 12,),
              Text('الاسم: ${feedbackData.name}',
              style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text('الكلاس: ${feedbackData.classes}',
              style: TextStyle(fontSize: 15,color: Colors.grey[700],fontWeight: FontWeight.w500),),
              Text('العمر: ${feedbackData.age}',
              style: TextStyle(fontSize: 15,color: Colors.grey[700],fontWeight: FontWeight.w500),),
              SizedBox(height: 5,),
              Text('الباركود: ${feedbackData.barcode}',
              style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }
}

