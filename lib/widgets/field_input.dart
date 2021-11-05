import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  const Field({
    Key? key,
    required this.size,
    required this.icon,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final IconData icon;
  final String hintText;
  final TextEditingController controller;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  bool _show = false;
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height / 15,
      width: widget.size.width / 1.3,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.hintText == "email"
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.hintText == "password"
              ? _show
                  ? IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _show = false;
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _show = true;
                        });
                      })
              : null,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        obscureText: widget.hintText == "password"
            ? _show
                ? false
                : true
            : false,
      ),
    );
  }

  void _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
