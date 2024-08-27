import 'package:stripcard/language/strings.dart';
import 'package:stripcard/utils/custom_color.dart';
import 'package:stripcard/utils/dimensions.dart';
import 'package:stripcard/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stripcard/widgets/text_labels/custom_title_heading_widget.dart';

extension limit on Widget {
  Widget limitWidget({required fee, required limit}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical*0.2
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          
          Row(
            children: [
                CustomTitleHeadingWidget(
            text:    Strings.transferFee,
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.primaryLightTextColor,
                ),
              ),
              Text(
                " : ${fee}",
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.primaryLightTextColor,
                ),
              ),
            ],
          ),verticalSpace(Dimensions.heightSize*0.2),
          Row(
            children: [
              CustomTitleHeadingWidget(
                text: 
                Strings.limit,
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.primaryLightTextColor,
                ),
              ),
              Text(
                " : ${limit}",
                            textAlign: TextAlign.left,
              
                style: GoogleFonts.inter(
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.primaryLightTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//  limitWidget(fee: Strings.uSD2,limit: Strings.limitusd2)