import 'package:flutter/material.dart';

///Type of button
///
///Possible values:
///
/// - call
/// - microsoftTeams
enum ButtonType {
  call,
  microsoftTeams,
  mail,
}

///Image position
///
///Possible values:
/// - left
/// - right
enum ImagePosition {
  left,
  right,
}

///Button size.
///
///Possible values:
/// - nano
/// - small
/// - medium
/// - large
enum ButtonSize {
  nano,
  small,
  medium,
  large,
}

// ignore: must_be_immutable
class SignInButton extends StatelessWidget {
  ButtonType? buttonType;
  Function onPressed;
  ImagePosition? imagePosition;
  double elevation;
  ButtonSize buttonSize;
  Color? btnColor;
  Color? btnTextColor;
  String? btnText;
  double? width;
  double? padding;
  Widget? _image;
  double? _fontSize;
  double? _imageSize;
  ShapeBorder? shape;
  bool mini;

  SignInButton({
    this.buttonType,
    required this.onPressed,
    this.imagePosition: ImagePosition.left,
    this.buttonSize: ButtonSize.small,
    this.btnColor,
    this.btnTextColor,
    this.btnText,
    this.elevation: 5.0,
    this.width,
    this.padding,
    this.shape,
  }) : mini = false;

  SignInButton.nano({
    this.buttonType,
    required this.onPressed,
    this.buttonSize: ButtonSize.nano,
    this.btnColor,
    this.elevation: 5.0,
    this.padding,
  }) : mini = true;

  SignInButton.mini({
    this.buttonType,
    required this.onPressed,
    this.buttonSize: ButtonSize.small,
    this.btnColor,
    this.elevation: 5.0,
    this.padding,
  }) : mini = true;

  @override
  Widget build(BuildContext context) {
    _setButtonSize();
    _createStyle();
    return !mini
        ? MaterialButton(
            color: btnColor,
            shape: shape ?? StadiumBorder(),
            onPressed: onPressed as void Function(),
            elevation: elevation,
            child: Container(
              width: width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: imagePosition == ImagePosition.left
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding!),
                    child: imagePosition == ImagePosition.left
                        ? _image
                        : Text(
                            btnText!,
                            style: TextStyle(
                              fontSize: _fontSize,
                              color: btnTextColor,
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding!),
                    child: imagePosition == ImagePosition.left
                        ? Text(
                            btnText!,
                            style: TextStyle(
                              fontSize: _fontSize,
                              color: btnTextColor,
                            ),
                          )
                        : _image,
                  ),
                ],
              ),
            ),
          )
        : MaterialButton(
            onPressed: onPressed as void Function(),
            color: btnColor,
            child: _image,
            elevation: elevation,
            padding: EdgeInsets.all(padding!),
            shape: CircleBorder(),
          );
  }

  void _setButtonSize() {
    if (buttonSize == ButtonSize.nano) {
      padding ??= !mini ? 0 : 1.0;
      width ??= 100;
      _fontSize = 15.0;
      _imageSize = !mini ? 22.0 : 30.0;
    } else if (buttonSize == ButtonSize.small) {
      padding ??= !mini ? 5.0 : 6.0;
      width ??= 200;
      _fontSize = 15.0;
      _imageSize = !mini ? 24.0 : 30.0;
    } else if (buttonSize == ButtonSize.medium) {
      padding ??= !mini ? 5.5 : 6.5;
      width ??= 220;
      _fontSize = 17.0;
      _imageSize = !mini ? 28.0 : 34.0;
    } else {
      padding ??= !mini ? 6.0 : 7.0;
      width ??= 250;
      _fontSize = 19.0;
      _imageSize = !mini ? 32.0 : 38.0;
    }
  }

  void _createStyle() {
    switch (buttonType) {
      case ButtonType.call:
        btnText ??= 'Call ';
        btnTextColor ??= Colors.white;
        btnColor ??= Color(0xFF1877F2);
        _image = Icon(Icons.phone, color: Colors.white, size: 30);

        break;

      case ButtonType.microsoftTeams:
        btnText ??= 'Teams Chat';
        btnTextColor ??= Colors.white;
        btnColor ??= Colors.deepPurple[700];
        _image = Image.asset(
          'images/icons/microsoft_teams.png',
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.mail:
        btnText ??= 'Send Mail';
        btnTextColor ??= Colors.white;
        btnColor ??= Color(0xFF20639B);
        _image = Icon(Icons.mail, color: Colors.white, size: 30);

        break;
      case null:
        break;
    }
  }
}
