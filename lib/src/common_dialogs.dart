import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_component/flutter_component.dart';

typedef EditCallBack = bool Function(String);

/// 显示通用dialog。可控制是否显示标题，是否是单个按钮。单个按钮则确认按钮有效，取消按钮无效。
/// 点击取消按钮返回0， 点击确认按钮返回1
Future<int> showTipsDialog(
    BuildContext context, {
      String titleText,
      Color titleTextColor = color333333,
      bool outsideCancellable = false,
      String contentText,
      double contentTextSize = 16,
      Color contentTextColor = color333333,
      TextAlign contentTextAlign = TextAlign.center,
      String cancelText = "取消",
      double cancelTextSize = 18,
      Color cancelTextColor = color666666,
      String confirmText = "确定",
      double confirmTextSize = 18,
      Color confirmTextColor = color5FC48D,
      bool singleButton = false,
      double circularRadius = 10,
      bool isEditable = true,
      String editHintText,
      double editTextSize = 16,
      Color editTextColor = color333333,
      double editHintTextSize = 16,
      int valueLength = 50,
      Color editHintTextColor = colorC9C9C9,
      EditCallBack onEditValue,
    }) {
  return showDialog<int>(
    context: context,
    barrierDismissible: outsideCancellable,
    builder: (context) => SimpleDialog(
      title: titleText == null
          ? null
          : Text(
        titleText,
        textAlign: TextAlign.center,
        style: TextStyle(color: titleTextColor),
      ),
      titlePadding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 0),
      contentPadding: EdgeInsets.only(top: titleText == null ? 24 : 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularRadius)),
      children: [
        TipsDialogWidget(
          contentText: contentText,
          contentTextSize: contentTextSize,
          contentTextColor: contentTextColor,
          contentTextAlign: contentTextAlign,
          cancelText: cancelText,
          cancelTextSize: cancelTextSize,
          cancelTextColor: cancelTextColor,
          confirmText: confirmText,
          confirmTextSize: confirmTextSize,
          confirmTextColor: confirmTextColor,
          singleButton: singleButton,
          circularRadius: circularRadius,
          isEditable: isEditable,
          editTextSize: editTextSize,
          editTextColor: editTextColor,
          editHintText: editHintText,
          editHintTextSize: editHintTextSize,
          editHintTextColor: editHintTextColor,
          valueLength:valueLength,
          cancelTap: () => Navigator.pop(context, 0),
          confirmTap: (value) {
            if (onEditValue != null) {
              if (onEditValue(value)) Navigator.pop(context, 1);
            } else {
              Navigator.pop(context, 1);
            }
          },
        ),
      ],
    ),
  );
}

class TipsDialogWidget extends StatefulWidget {
  final String contentText;
  final double contentTextSize;
  final Color contentTextColor;
  final TextAlign contentTextAlign;
  final String cancelText;
  final double cancelTextSize;
  final Color cancelTextColor;
  final String confirmText;
  final double confirmTextSize;
  final Color confirmTextColor;
  final bool singleButton;
  final double circularRadius;
  final bool isEditable;
  final VoidCallback cancelTap;
  final Function(String) confirmTap;
  final double editTextSize;
  final Color editTextColor;
  final String editHintText;
  final double editHintTextSize;
  final Color editHintTextColor;
  final int valueLength;

  const TipsDialogWidget(
      {Key key,
        this.contentText,
        this.contentTextSize,
        this.contentTextColor,
        this.contentTextAlign,
        this.cancelText,
        this.cancelTextSize,
        this.cancelTextColor,
        this.confirmText,
        this.confirmTextSize,
        this.confirmTextColor,
        this.singleButton,
        this.circularRadius,
        this.cancelTap,
        this.confirmTap,
        this.isEditable,
        this.editHintText,
        this.editTextSize,
        this.editTextColor,
        this.editHintTextSize,
        this.valueLength = 50,
        this.editHintTextColor})
      : super(key: key);

  @override
  _TipsDialogWidgetState createState() => _TipsDialogWidgetState();
}

class _TipsDialogWidgetState extends State<TipsDialogWidget> {
  TextEditingController _textController;
  var formatterList = <TextInputFormatter>[];
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    formatterList..add(LengthLimitingTextInputFormatter(widget.valueLength));
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: widget.contentText == null
                ? Container()
                : Text(
              widget.contentText,
              textAlign: widget.contentTextAlign,
              style: TextStyle(
                  color: color333333, fontSize: 16, height: 1.5),
            ),
          ),
          widget.isEditable
              ? Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 16),
            child: TextField(
              controller: _textController,
              cursorColor: Theme.of(context).primaryColor,
              minLines: 3,
              maxLines: 3,
              inputFormatters: formatterList,
              style: TextStyle(
                  color: widget.editTextColor,
                  fontSize: widget.editTextSize),
              decoration: InputDecoration(
                hintText: widget.editHintText,
                hintStyle: TextStyle(
                    color: widget.editHintTextColor,
                    fontSize: widget.editHintTextSize),
                contentPadding:
                EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                fillColor: colorFAFAFA,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: colorE5E5E5, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorE5E5E5, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorE5E5E5, width: 1)),
              ),
            ),
          )
              : Container(),
          SizedBox(height: 24),
          Divider(thickness: 1, height: 1, color: colorF1F1F1),
          IntrinsicHeight(
            child: Row(
              children: [
                widget.singleButton
                    ? Container()
                    : Expanded(
                  child: FlatButton(
                    onPressed: widget.cancelTap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft:
                            Radius.circular(widget.circularRadius))),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      widget.cancelText,
                      style: TextStyle(
                          color: widget.cancelTextColor,
                          fontSize: widget.cancelTextSize,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                widget.singleButton
                    ? Container()
                    : VerticalDivider(
                    width: 1, thickness: 1, color: colorF1F1F1),
                Expanded(
                  child: FlatButton(
                    onPressed: () => widget.confirmTap(_textController.text),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(widget.circularRadius),
                        bottomLeft: widget.singleButton
                            ? Radius.circular(widget.circularRadius)
                            : Radius.circular(0),
                      ),
                    ),
                    splashColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    highlightColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      widget.confirmText,
                      style: TextStyle(
                          color: widget.confirmTextColor,
                          fontSize: widget.confirmTextSize,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
