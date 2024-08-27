import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stripcard/utils/basic_screen_import.dart';

import '../../language/language_controller.dart';

class ForgotInputWidget extends StatefulWidget {
  final String hint, icon, label;
  final int maxLines;
  final bool isValidator;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;
  final TextInputType? keyboardInputType;
  final List<TextInputFormatter>? inputFormatters;
  const ForgotInputWidget({
    Key? key,
    required this.controller,
    required this.hint,
    this.icon = "",
    this.isValidator = true,
    this.prefixIcon,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    this.keyboardInputType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<ForgotInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<ForgotInputWidget> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading4Widget(
          text: widget.label,
          fontWeight: FontWeight.w600,
        ),
        verticalSpace(Dimensions.heightSize * 0.5),
        TextFormField(
          inputFormatters: widget.inputFormatters,
          validator: widget.isValidator == false
              ? null
              : (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
          textInputAction: TextInputAction.next,
          controller: widget.controller,
          onTap: () {
            setState(() {
              focusNode!.requestFocus();
            });
          },
          onFieldSubmitted: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
          focusNode: focusNode,
          textAlign: TextAlign.left,
          style: CustomStyle.darkHeading3TextStyle.copyWith(
            color: CustomColor.thirdLightTextColor,
          ),
          keyboardType: widget.keyboardInputType,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            hintText:
                Get.find<LanguageController>().getTranslation(widget.hint),
            hintStyle: GoogleFonts.inter(
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w500,
              color: CustomColor.thirdLightTextColor.withOpacity(0.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: BorderSide(
                color: CustomColor.thirdLightTextColor.withOpacity(0.2),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(
                width: 2,
                color: CustomColor.thirdLightTextColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(
                width: 2,
                color: CustomColor.thirdLightTextColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.heightSize * 1.7,
              vertical: Dimensions.widthSize,
            ),
          ),
        ),
      ],
    );
  }
}
