
import 'package:excelfile/view_model/scan_view_model.dart';
import 'package:get/get.dart';

class Binding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => ScanViewModel());
    
  }
}