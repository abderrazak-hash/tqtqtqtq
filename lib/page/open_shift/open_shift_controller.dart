import 'dart:convert';
import 'package:cloud_toq_system/core/common/translation/app_text.dart';
import 'package:cloud_toq_system/core/page/product/product_screen.dart';
import 'package:cloud_toq_system/utils/dialog/overlay_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OpenShiftController extends GetxController{

  var isSelect = true.obs;
  var amount = ''.obs;
  var notes = ''.obs;

void selectedAgree(value){
  isSelect != isSelect;
}

  onLoginClick() {

    if(!amount.value.isNotEmpty){
      OverlayHelper.showErrorToast(AppText.invalidUserName);
      return;
    }
    callLoginApi(Get.arguments['device_id'],Get.arguments['USER_ID'],amount.value).then((value) => 
    Get.to(ProductListScreen()));

  }



  final _baseUrl = "https://6o9.live/api/OpenWorkTime";
  Future<OpenShfit> callLoginApi(String amount, String userDeviceId,String idUser) async {

  //  try {
      final response = await http.post(Uri.parse(_baseUrl), body: {
        'user_device_id':Get.arguments['device_id'],
        'user_id':Get.arguments['USER_ID'],
        'AmountStart': amount,
      });
      if (response.statusCode == 201) {
        return OpenShfit.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create open shift.');
      }
    //   switch (response.statusCode) {
    //     case 200:
    //       OpenShfit.fromJson(json.decode(response.body));
    //
    //       // sharedPreferences!.setString('UserName', username);
    //       // sharedPreferences!.setString('fullName',  (_apiResponse.Data as User).user!.fullName!);
    //       // sharedPreferences!.setString('avatar',  (_apiResponse.Data as User).user!.avatar!);
    //       // sharedPreferences!.setInt('id', (_apiResponse.Data as User).user!.id!);
    //       // sharedPreferences!.setString('email',  (_apiResponse.Data as User).user!.email!);
    //       // sharedPreferences!.setString('mobile',  (_apiResponse.Data as User).user!.mobile!);
    //       // print((_apiResponse.Data as User).user!.id!);
    //       Get.to(ProductListScreen(),
    //           arguments: {
    //             'branch':sharedPreferences!.getString('id_branch'),
    //           });
    //       //Get.offNamed(Routes.PRODUCT);
    //       break;
    //
    //     default:
    //       Get.snackbar('\u{1F643}', 'من فضلك تأكد من صحة البيانات!',
    //         colorText: Colors.white,
    //         snackStyle:SnackStyle.FLOATING,
    //         backgroundColor: AppColors.current.success,
    //         snackPosition: SnackPosition.BOTTOM,
    //       );
    //       // Get.to(ProductListScreen(),arguments: {
    //       //   'branch':sharedPreferences!.getInt('id_branch'),
    //       // });
    //       break;
    //   }
    // } on SocketException {
    //   Get.snackbar('\u{1F643}', 'لا يتوفر اتصال بالانترنت',
    //     colorText: Colors.white,
    //     snackStyle:SnackStyle.FLOATING,
    //     backgroundColor: AppColors.current.success,
    //     snackPosition: SnackPosition.BOTTOM,
    //   );

    //}

  }

}


class OpenShfit {
  OpenShfit({
    required this.number,
    required this.userId,
    required this.deviceId,
    required this.branchId,
    required this.dateOpen,
    required this.timeOpen,
    required this.amountOpen,
    required this.status,
    required this.id,
  });

  int number;
  String userId;
  int deviceId;
  dynamic branchId;
  DateTime dateOpen;
  String timeOpen;
  String amountOpen;
  String status;
  int id;

  factory OpenShfit.fromJson(Map<String, dynamic> json) => OpenShfit(
    number: json["Number"],
    userId: json["user_id"],
    deviceId: json["device_id"],
    branchId: json["branch_id"],
    dateOpen: DateTime.parse(json["date_open"]),
    timeOpen: json["time_open"],
    amountOpen: json["amount_open"],
    status: json["status"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "Number": number,
    "user_id": userId,
    "device_id": deviceId,
    "branch_id": branchId,
    "date_open": "${dateOpen.year.toString().padLeft(4, '0')}-${dateOpen.month.toString().padLeft(2, '0')}-${dateOpen.day.toString().padLeft(2, '0')}",
    "time_open": timeOpen,
    "amount_open": amountOpen,
    "status": status,
    "id": id,
  };
}
