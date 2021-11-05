import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.size,
    required this.text,
    required this.controllerList,
  }) : super(key: key);

  final Size size;
  final String text;
  final List<TextEditingController> controllerList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if(controllerList.length < 3){
            // for login
            if(controllerList[0].text.isNotEmpty && controllerList[1].text.isNotEmpty){
              if(!CheckEmail(controllerList[0].text)){
                _showToast(context, "Enter Valid Email Address");
              }
            }else{
              _showToast(context, "Please fill email and password");
            }
          }else{
            //for sign up
            if(controllerList[0].text.isNotEmpty && controllerList[1].text.isNotEmpty && controllerList[2].text.isNotEmpty){

            }else{
              _showToast(context, "Please fill all data");
            }
          }
        },
        child: Container(
          height: size.height / 14,
          width: size.width / 1.3,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 1.1,
            ),
          ),
        ),
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

  bool CheckEmail(email){
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }


}
