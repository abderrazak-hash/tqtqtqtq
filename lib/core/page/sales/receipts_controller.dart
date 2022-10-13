import 'package:get/get.dart';

class ReceiptsController extends GetxController{

  List<Receipts> list = [
    Receipts(title: 'فاتورة ضريبة مبسطة',
        numberOfInvoice: 1,
        date: '13/6/2022',
        totalPrice: 1200.00,
        paidPrice: 800.00,
        remainingPrice: 400.00,
        tax: 120.00,
        isExpanded: false.obs),
    Receipts(title: 'فاتورة ضريبة مبسطة',
        numberOfInvoice: 1,
        date: '13/6/2022',
        totalPrice: 1200.00,
        paidPrice: 800.00,
        remainingPrice: 400.00,
        tax: 120.00,
        isExpanded: false.obs),
    Receipts(title: 'فاتورة ضريبة ',
        numberOfInvoice: 2,
        date: '14/7/2022',
        totalPrice: 1200.00,
        paidPrice: 800.00,
        remainingPrice: 400.00,
        tax: 120.00,
        isExpanded: false.obs),
    Receipts(title: 'فاتورة ضريبة ',
        numberOfInvoice: 2,
        date: '14/7/2022',
        totalPrice: 1200.00,
        paidPrice: 800.00,
        remainingPrice: 400.00,
        tax: 120.00,
        isExpanded: false.obs)
  ].obs;

  Rx<List<Receipts>> foundList = Rx<List<Receipts>>([]);
  @override
  void onInit() {
    super.onInit();
    foundList.value = list;
  }
  void filterReceipts(String receiptTitle) {
    List<Receipts> results = [];
    if (receiptTitle.isEmpty) {
      results = list;
    } else {
      results = list
          .where((element) => element.title
          .toString()
          .toLowerCase()
          .contains(receiptTitle.toLowerCase()))
          .toList();
    }
    foundList.value = results;
  }
}


class Receipts{
  String title;
  int numberOfInvoice;
  String date;
  double totalPrice;
  double tax;
  double paidPrice;
  double remainingPrice;
  RxBool isExpanded;
  Receipts({required this.title,
    required this.numberOfInvoice,
    required this.date,
    required this.totalPrice,
    required this.tax,
    required this.paidPrice,
    required this.remainingPrice,
    required this.isExpanded});
}