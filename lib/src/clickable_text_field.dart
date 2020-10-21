import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/src/color/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClickableTextField extends StatefulWidget {
  final String leftIconAssets;
  final double leftIconsSize;
  final String titleText;
  final String subTitleText;
  final double sbuTitleTextSize;
  final Color subTitleTextColor;
  final double titleTextSize;
  final Color titleTextColor;
  final TextStyle titleTextStyle;
  final String hintText;
  final Color hintTextColor;
  final Color descHintColor;
  final TextAlign descTextAlign;
  final double hintTextSize;
  final double horizontalPadding;
  final double verticalPadding;
  final bool showRightArrow;
  final String rightIconAssets;
  final bool isDescEditable;
  final bool showLine;
  final double lineStartPadding;
  final double lineEndPadding;
  final int maxDescLines;
  final int minDescLines;
  final Widget rightIconWidget;
  final VoidCallback onTap;

  const ClickableTextField(
      {Key key,
      @required this.titleText,
      this.titleTextSize,
      this.titleTextColor,
      this.titleTextStyle,
      this.hintText,
      this.hintTextColor,
      this.descHintColor,
      this.hintTextSize,
      this.horizontalPadding,
      this.verticalPadding = 10,
      this.rightIconAssets = "assets/images/ic_right_arrow.svg",
      this.isDescEditable = false,
      this.showLine = true,
      this.lineStartPadding,
      this.lineEndPadding,
      this.showRightArrow = false,
      this.maxDescLines = 3,
      this.minDescLines = 1,
      this.leftIconAssets,
      this.leftIconsSize,
      this.rightIconWidget,
      this.subTitleText,
      this.sbuTitleTextSize = 14,
      this.subTitleTextColor = color999999,
      this.descTextAlign = TextAlign.end,
      this.onTap})
      : super(key: key);

  @override
  ClickableTextFieldState createState() => ClickableTextFieldState();
}

class ClickableTextFieldState extends State<ClickableTextField> {
  TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: widget.verticalPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: widget.horizontalPadding ?? 16),
              widget.leftIconAssets != null
                  ? SvgPicture.asset(widget.leftIconAssets,
                      width: widget.leftIconsSize ?? 24,
                      height: widget.leftIconsSize ?? 24)
                  : Container(),
              SizedBox(width: widget.leftIconAssets != null ? 12 : 0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.titleText,
                    style: widget.titleTextStyle ??
                        TextStyle(
                            fontSize: widget.titleTextSize ?? 18,
                            color: widget.titleTextColor ?? color333333),
                  ),
                  SizedBox(height: widget.subTitleText != null ? 4 : 0),
                  widget.subTitleText != null
                      ? Text(
                          widget.subTitleText,
                          style: TextStyle(
                              color: widget.subTitleTextColor,
                              fontSize: widget.sbuTitleTextSize),
                        )
                      : Container(),
                ],
              ),
              SizedBox(width: widget.horizontalPadding ?? 16),
              Expanded(
                child: TextField(
                  controller: _descController,
                  textAlign: widget.descTextAlign,
                  maxLines: widget.maxDescLines,
                  minLines: widget.minDescLines,
                  enabled: widget.isDescEditable,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                          color: widget.descHintColor ?? colorC9C9C9,
                          fontSize: widget.hintTextSize ?? 16),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: widget.verticalPadding ?? 0)),
                  style: TextStyle(
                      color: widget.hintTextColor ?? color333333,
                      fontSize: widget.hintTextSize ?? 16),
                ),
              ),
              SizedBox(
                  width: widget.showRightArrow || widget.rightIconWidget != null
                      ? 8
                      : 0),
              widget.rightIconWidget != null
                  ? widget.rightIconWidget
                  : widget.showRightArrow
                      ? SvgPicture.asset(widget.rightIconAssets,
                          width: 16, height: 16)
                      : Container(),
              SizedBox(width: widget.horizontalPadding ?? 16),
            ],
          ),
          SizedBox(height: widget.verticalPadding),
          Padding(
            padding: EdgeInsets.only(
                left: widget.lineStartPadding ?? 16,
                right: widget.lineEndPadding ?? 0),
            child: Divider(
                thickness: 1,
                height: 1,
                color: widget.showLine ? colorF1F1F1 : Colors.transparent),
          )
        ],
      ),
    );
  }
}
