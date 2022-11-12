import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

Future showConfirmDialog(
    BuildContext context,
    String titleText,
    String contentText,
    void Function() okHandle,
    void Function() cancelHandle) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: [
            TextButton(
              onPressed: okHandle,
              child: const Text("OK"),
            ),
            TextButton(
              onPressed: cancelHandle,
              child: const Text("CANCEL"),
            )
          ],
        );
      });
}

Future showFlashDialog(
    BuildContext context, String flashTitle, String flashText) {
  return showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return Flash.bar(
          position: FlashPosition.bottom,
          backgroundGradient:
              const LinearGradient(colors: [Colors.black, Colors.blueGrey]),
          //enableDrag: true,
          enableVerticalDrag: true,
          horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
          margin: const EdgeInsets.all(8),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          controller: controller,
          child: FlashBar(
            content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      flashTitle,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    flashText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ]),
          ),
        );
      });
}
