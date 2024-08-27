import 'package:google_fonts/google_fonts.dart';
import 'package:stripcard/utils/basic_screen_import.dart';

import '../../language/language_controller.dart';

class AuthPrimaryInputWidget extends StatefulWidget {
  final String hint, icon, label;
  final int maxLines;
  final bool isValidator;
  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;
  final TextInputType? keyboardInputType;
  const AuthPrimaryInputWidget({
    Key? key,
    required this.controller,
    required this.hint,
    this.icon = "",
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    this.keyboardInputType,
  }) : super(key: key);

  @override
  State<AuthPrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<AuthPrimaryInputWidget> {
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
        verticalSpace(7),
        TextFormField(
          validator: widget.isValidator == false
              ? null
              : (String? value) {
                  if (value!.isEmpty) {
                     return Get.find<LanguageController>()
                        .getTranslation(Strings.pleaseFillOutTheField);
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
            color: CustomColor.whiteColor,
          ),
          keyboardType: widget.keyboardInputType,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText:
                Get.find<LanguageController>().getTranslation(widget.hint),
            hintStyle: GoogleFonts.inter(
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w500,
              color: CustomColor.whiteColor.withOpacity(0.6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: BorderSide(
                width: 1,
                color: CustomColor.whiteColor.withOpacity(0.6),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(
                width: 2,
                color: CustomColor.whiteColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(
                width: 2,
                color: CustomColor.whiteColor,
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
