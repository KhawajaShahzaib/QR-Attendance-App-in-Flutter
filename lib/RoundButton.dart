import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onTap;

  const RoundButton({Key? key,
  required this.title,
  required this.onTap,
    this.loading = false
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,):
          Text(title, style: TextStyle(color: Colors.white, fontSize: 25),),
        ),
      ),
    );
  }
}
