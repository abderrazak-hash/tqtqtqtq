import 'package:cloud_toq_system/core/common/theme/app_assets.dart';
import 'package:cloud_toq_system/core/common/theme/app_colors.dart';
import 'package:cloud_toq_system/core/page/sales/_widgets/header.dart';
import 'package:cloud_toq_system/core/page/sales/receipts_controller.dart';
import 'package:cloud_toq_system/core/page/side_menu/side_menu_view.dart';
import 'package:cloud_toq_system/utils/empty.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ReceiptsView extends StatelessWidget {

  final ReceiptsController controller = Get.find();
   ReceiptsView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.current.neutral,
      drawer: SideMenuView(),
      appBar: _buildToolbar(),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(AppAssets.background_app),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  TextField(
                    onChanged: (value)=>controller.filterReceipts(value),
                    decoration: InputDecoration(
                        hintText: 'ابحث عن فاتورة بيع',
                        hintStyle: TextStyle(
                          color: AppColors.current.dimmedLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Tajawal',
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.current.primary,
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.current.dimmedLight.withOpacity(0.2),
                            width: 1
                        ),
                    ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.current.dimmedLight.withOpacity(0.2),
                            width: 1
                        ),
                    ),
                  ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child:Obx((){
                      return ListView.builder(
                        itemCount:controller.foundList.value.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                          child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                  extentRatio: 0.85,
                                  motion: const ScrollMotion(),
                                  // dismissible: DismissiblePane(onDismissed: () {}),
                                  children: [

                                    Expanded(

                                      child: InkWell(
                                        onTap: (){},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Container(
                                            width: 58,
                                            height: 68,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff5AED72),
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:const Icon(Icons.print,color: Colors.white,size: 36,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(

                                      child: InkWell(
                                        onTap: (){},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Container(
                                            width: 58,
                                            height: 68,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff9747FF),

                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:const Icon(Icons.restart_alt_outlined,color: Colors.white,size: 36,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(

                                      child: InkWell(
                                        onTap: (){},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Container(
                                            width: 58,
                                            height: 68,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffED5A5A),
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:const Icon(Icons.camera_enhance_outlined,color: Colors.white,size: 36,),

                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(

                                      child: InkWell(
                                        onTap: (){

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Container(
                                            width: 58,
                                            height: 68,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff5A7BED),
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child:const Icon(Icons.list,color: Colors.white,size: 36,),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // SlidableAction(
                                    //   onPressed: (thing){},
                                    //  // spacing: 16,
                                    //   borderRadius: BorderRadius.circular(8),
                                    //   padding: const EdgeInsets.symmetric(horizontal: 0),
                                    //   backgroundColor: Color(0xFFFE4A49),
                                    //   foregroundColor: Colors.white,
                                    //   icon: Icons.delete,
                                    //   //label: '',
                                    // ),

                                  ]),
                              direction: Axis.horizontal,
                              useTextDirection: true,
                              dragStartBehavior: DragStartBehavior.start,
                              child: Header(receipts:controller.foundList.value[index])),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  AppBar _buildToolbar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColors.current.primary,
      leadingWidth: 40,
      elevation: 0.0,
      titleSpacing: 0,
      foregroundColor: AppColors.current.success,
      title:  Text('المبيعات',
        style: TextStyle(
            color: AppColors.current.success,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'Tajawal'
        ),
      ),
      actions: [
        GestureDetector(child: Icon(Icons.arrow_forward,
          size: 30,
          color: AppColors.current.success,),
          onTap:()=>Get.back(),
        ),
      ],

    );
  }
}
