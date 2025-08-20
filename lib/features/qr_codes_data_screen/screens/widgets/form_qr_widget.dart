import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/core/validation/input_validation.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/calender_selection_widget.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/core/common/noraml_button_widget.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/show_select_image.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FormQrWidget extends StatelessWidget {
  const FormQrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final QrCodesDataController homeController = QrCodesDataController.to;
    return Form(
      key: homeController.formKey,
      child: Column(
        spacing: 20,

        children: [
          TextFormField(
            validator: (value) =>
                AppFieldValidator.validateEmpty(value, 'الاسم'),

            controller: homeController.nameController,
            decoration: InputDecoration(
              suffixIcon: Icon(Iconsax.user),
              filled: true,
              fillColor: AppColors.grey,
              hintText: 'ادخل اسم المشترك',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Row(
            spacing: 10,
            children: [
              CalenderSelectionWidget(
                label: 'تاريخ البدء',
                controller: homeController.firstDateController,
              ),
              CalenderSelectionWidget(
                label: 'تاريخ الانتهاء',
                controller: homeController.endDateController,
              ),
            ],
          ),

          // Obx(
          //   () => TextFormField(
          //     readOnly: true,
          //     decoration: InputDecoration(
          //       suffixIcon: TextButton(
          //         onPressed: () {
          //           showSelectImage();
          //         },
          //         child: homeController.imagePath.value == ''
          //             ? Text('اختر صورة')
          //             : Text('تم اختيار صورة'),
          //       ),
          //       filled: true,

          //       fillColor: AppColors.grey,
          //       hintText: homeController.imagePath.value == ''
          //           ? 'اختر صورة'
          //           : 'تم اختيار صورة',
          //       border: OutlineInputBorder(
          //         borderSide: BorderSide.none,
          //         borderRadius: BorderRadius.circular(15),
          //       ),
          //     ),
          //   ),
          // ),
          Obx(
            () => NoramlButtonWidget(
              onPressed: () async {
                if (homeController.isEdit.value) {
                  await homeController.editUser();
                } else {
                  await homeController.addUser();
                }
              },
              text: homeController.isEdit.value
                  ? 'تعديل المشترك'
                  : 'عرض رمز الاستجابة السريعة',
            ),
          ),
        ],
      ),
    );
  }
}
