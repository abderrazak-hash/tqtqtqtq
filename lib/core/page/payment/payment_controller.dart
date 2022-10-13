import 'dart:io';

import 'package:cloud_toq_system/core/common/theme/app_colors.dart';
import 'package:cloud_toq_system/core/page/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final ProductController controller = Get.put(ProductController());

class PaymentController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    payValue = (controller.price.value / divider.value).toPrecision(2).obs;
    rest.value = 0;
    values = RxList<double>([controller.price.value]);
  }

  RxList<double> values = RxList<double>([]);

  Rx<int> divider = 1.obs;
  late Rx<double> payValue;
  Rx<double> rest = 0.0.obs;

  void divide() {
    double price = controller.price.value;
    if (divider < price / 2) {
      divider.value = (divider.value + 1);
      payValue.value = (price / divider.value).toPrecision(2);
      values.clear();
      for (int i = 0; i < divider.value; i++) {
        values.add(payValue.value);
      }
      rest.value = 0;
      values.refresh();
      payValue.refresh();
      divider.refresh();
      rest.refresh();
    }
  }

  void undivide() {
    double price = controller.price.value;
    if (divider > 1) {
      divider.value = (divider.value - 1);
      payValue.value = (price / divider.value).toPrecision(2);
      values.clear();
      for (int i = 0; i < divider.value; i++) {
        values.add(payValue.value);
      }
      rest.value = 0;
      rest.refresh();
      values.refresh();
      payValue.refresh();
      divider.refresh();
    }
  }

  void updateValue(int index, double value) {
    values[index] = value;
    double sum = 0;
    for (double val in values) {
      sum += val;
    }
    rest.value = controller.price.value - sum;
    rest.refresh();
    values.refresh();
  }

  // get payment method
  final url = 'https://6o9.live/api/GetPaimentMethod';
  Future<List<PaymentModel>> getPaymentMethod(String branchId) async {
    List<PaymentModel> payments = [];
    final response = await http.post(Uri.parse(url), body: {
      'branch_id': branchId,
    });

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print(responseBody.toString());
      for (var payment in responseBody) {
        payments.add(PaymentModel.fromJson(payment));
      }
    } else {
      print('Exception');
      return throw Exception();
    }

    return payments;
  }

  // send fatora to server

  void sendMyFatouraToServer(
      int customer_id,
      int discount,
      int price,
      double priceAferDiscont,
      double priceNoTaxed,
      int stock_id,
      double tax) async {
    final _baseUrl = "https://6o9.live/api/SaveSelle";

    try {
      final response = await http.post(Uri.parse(_baseUrl), body: {
        'customer_id': customer_id,
        'discount': discount,
        'price': price,
        'priceAferDiscont': priceAferDiscont,
        'priceNoTaxed': priceNoTaxed,
        'stock_id': stock_id,
        'tax': tax,
        // 'total': total,
        // list from product [
        // داخلها باراميتر]
        // list from payment [
        // داخلها باراميتر]
      });
      switch (response.statusCode) {
        case 200:
          break;
        case 401:
          break;
        default:
          Get.snackbar(
            '\u{1F643}',
            'من فضلك تأكد من صحة البيانات!',
            colorText: Colors.white,
            snackStyle: SnackStyle.FLOATING,
            backgroundColor: AppColors.current.success,
            snackPosition: SnackPosition.BOTTOM,
          );
          break;
      }
    } on SocketException {
      Get.snackbar(
        '\u{1F643}',
        'لا يتوفر اتصال بالانترنت',
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: AppColors.current.success,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class PaymentModel {
  PaymentModel({
    required this.id,
    required this.companyId,
    required this.typeCompany,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int companyId;
  String typeCompany;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        companyId: json["company_id"],
        typeCompany: json["type_company"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "type_company": typeCompany,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
