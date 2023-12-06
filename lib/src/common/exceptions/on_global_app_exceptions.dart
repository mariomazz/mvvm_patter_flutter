import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm_patter_flutter/src/common/exceptions/http_failure_500.dart';
import 'connection_error_exception.dart';
import 'http_failure_400.dart';

void onGlobalAppException(
  Object error, {
  StackTrace? stacktrace,
  ProviderContainer? appRivContainer,
  BuildContext? context,
}) async {
  if (error is ConnectionErrorException) {
    if (context != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Center(
                child: Text("Controlla la tua connessione a internet .."),
              ),
            );
          },
        );
      });
    } else {
      await Fluttertoast.showToast(
        msg: "Controlla la tua connessione a internet ..",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        /*  backgroundColor: Colors.red,
        textColor: Colors.white, */
        fontSize: 16.0,
        webPosition: "center",
      );
    }
  } else if (error is HttpFailure500) {
    if (context != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Center(
                child:
                    Text("Contenuto non disponibile, riprovare più tardi .."),
              ),
            );
          },
        );
      });
    } else {
      await Fluttertoast.showToast(
        msg: "Contenuto non disponibile, riprovare più tardi ..",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        /*  backgroundColor: Colors.red,
        textColor: Colors.white, */
        fontSize: 16.0,
        webPosition: "center",
      );
    }
  } else if (error is HttpFailure400) {
    if (context != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Center(
                child: Text(error.toString()),
              ),
            );
          },
        );
      });
    } else {
      await Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        /*  backgroundColor: Colors.red,
        textColor: Colors.white, */
        fontSize: 16.0,
        webPosition: "center",
      );
    }
  }
}
