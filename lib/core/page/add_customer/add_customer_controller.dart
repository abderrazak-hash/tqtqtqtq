import 'package:cloud_toq_system/core/common/translation/app_text.dart';
import 'package:cloud_toq_system/utils/dialog/overlay_helper.dart';
import 'package:get/get.dart';

class AddCustomerController extends GetxController{

  var customerName = ''.obs;
  var email = ''.obs;
  var address = ''.obs;
  var phoneNumber = ''.obs;
  var startBalanceHave = ''.obs;
  var startBalanceNotHave = ''.obs;
  var notes = ''.obs;

  onOkClick() {
    // validate name
    if(
        !notes.value.isNotEmpty){
      OverlayHelper.showErrorToast(AppText.invalidUserName);
      return;
    }
    // callLoginApi();
    Get.back();
  }

}