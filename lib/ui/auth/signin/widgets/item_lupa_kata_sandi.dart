import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/ui/auth/reset_password/reset_password_page.dart';

class ItemLupaKataSandi extends StatelessWidget {
  const ItemLupaKataSandi({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Nav.push(context, ResetPasswordPage()),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Lupa kata sandi? Klik ", style: TextStyle(color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.w400)),
              Text("disini. ", style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
