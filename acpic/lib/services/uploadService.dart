// IMPORT FLUTTER PACKAGES
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
// import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//IMPORT SCREENS
import 'package:acpic/screens/grid.dart';
import 'package:acpic/screens/offline.dart';
// IMPORT UI ELEMENTS
import 'package:acpic/ui_elements/material_elements.dart';

class UploadService {
  UploadService._privateConstructor();
  static final UploadService instance = UploadService._privateConstructor();

  Future<String> uploadStart(
      String op, String csrf, List tags, String cookie, int total) async {
    try {
      final response = await http.post(
        Uri.parse('https://altocode.nl/picdev/upload'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': cookie
        },
        body: jsonEncode(<String, dynamic>{
          'op': op,
          'csrf': csrf,
          'tags': tags,
          'total': total
        }),
      );
      if (response.statusCode == 200) {
        return response.body.substring(6, response.body.indexOf('}'));
      } else {
        print(response.statusCode);
        print(response.body);
        return 'error';
      }
    } on SocketException catch (_) {
      return 'offline';
    }
  }

  Future<int> uploadEnd(String op, String csrf, int id, String cookie) async {
    try {
      final response = await http.post(
        Uri.parse('https://altocode.nl/picdev/upload'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': cookie
        },
        body: jsonEncode(<String, dynamic>{'op': op, 'csrf': csrf, 'id': id}),
      );
      if (response.statusCode == 200) {
        print(response.body);
        print(response.headers);
        print('uploadEnd done');
        return response.statusCode;
      } else {
        print(response.statusCode);
        print(response.body);
        print(response.headers);
        return response.statusCode;
      }
    } on SocketException catch (_) {
      return 0;
    }
  }

  Future<int> uploadError(
      String op, String csrf, Object error, int id, String cookie) async {
    try {
      final response = await http.post(
        Uri.parse('https://altocode.nl/picdev/upload'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': cookie
        },
        body: jsonEncode(<String, dynamic>{
          'op': op,
          'csrf': csrf,
          'id': id,
          'error': error
        }),
      );
      if (response.statusCode == 200) {
        print(response.body);
        print(response.headers);
        print('uploadError done');
        return response.statusCode;
      } else {
        print(response.statusCode);
        print(response.body);
        print(response.headers);
        return response.statusCode;
      }
    } on SocketException catch (_) {
      return 0;
    }
  }

  uiReset(BuildContext context) {
    Provider.of<ProviderController>(context, listen: false)
        .selectAllTapped(false);
    Provider.of<ProviderController>(context, listen: false).redraw();
    Provider.of<ProviderController>(context, listen: false)
        .selectionInProcess(false);
    Provider.of<ProviderController>(context, listen: false)
        .showUploadingProcess(false);
    Provider.of<ProviderController>(context, listen: false)
        .uploadProgressFunction(0);
  }

  uiCancelReset(BuildContext context) {
    Provider.of<ProviderController>(context, listen: false)
        .showUploadingProcess(false);
    Provider.of<ProviderController>(context, listen: false)
        .selectionInProcess(true);
    Provider.of<ProviderController>(context, listen: false)
        .uploadProgressFunction(0);
  }

  // upload(int id, String csrf, String cookie, List tags,
  //     List<AssetEntity> list) async {
  //   try {
  //     for (int i = 0; i < list.length; i++) {
  //       File image = await list[i].file;
  //       var stream = new http.ByteStream(image.openRead());
  //       stream.cast();
  //       var length = await image.length();
  //       var uri = Uri.parse('https://altocode.nl/picdev/piv');
  //       var request = http.MultipartRequest('POST', uri);
  //       request.headers['cookie'] = cookie;
  //       request.fields['id'] = id.toString();
  //       request.fields['csrf'] = csrf;
  //       request.fields['tags'] = tags.toString();
  //       request.fields['lastModified'] =
  //           list[i].modifiedDateTime.millisecondsSinceEpoch.abs().toString();
  //       var picture = http.MultipartFile('piv', stream, length,
  //           filename: basename(image.path));
  //       request.files.add(picture);
  //       var response = await request.send();
  //       final respStr = await response.stream.bytesToString();
  //       print(respStr);
  //       print(response.statusCode);
  //       print('${i + 1} of ${list.length}');
  //       if (i + 1 == list.length) {
  //         return response.statusCode;
  //       }
  //     }
  //   } on SocketException catch (_) {
  //     return 0;
  //   }
  // }

  // void backgroundHandler() {
  //   // Needed so that plugin communication works.
  //   WidgetsFlutterBinding.ensureInitialized();
  //
  //   // This uploader instance works within the isolate only.
  //   FlutterUploader uploader = FlutterUploader();
  //
  //   // You have now access to:
  //   uploader.progress.listen((progress) {
  //     // upload progress
  //   });
  //   uploader.result.listen((result) {
  //     // upload results
  //   });
  //   FlutterUploader().setBackgroundHandler(backgroundHandler);
  // }
  //
  // uploadBackground(
  //     BuildContext context,
  //     int id,
  //     Future<File> piv,
  //     AssetEntity asset,
  //     String csrf,
  //     String cookie,
  //     List tags,
  //     List<AssetEntity> list,
  //     uploadRecurrence) async {
  //   StreamSubscription subscription;
  //   File image = await piv;
  //   var uri = Uri.parse('https://altocode.nl/picdev/piv');
  //   FlutterUploader().clearUploads();
  //   // final taskId =
  //   await FlutterUploader().enqueue(
  //     MultipartFormDataUpload(
  //       url: uri.toString(),
  //       files: [
  //         FileItem(path: image.path, field: 'piv'),
  //       ], //
  //       method: UploadMethod.POST,
  //       headers: {"cookie": cookie},
  //       allowCellular: true,
  //       data: {
  //         "id": id.toString(),
  //         "csrf": csrf,
  //         "lastModified":
  //             asset.modifiedDateTime.millisecondsSinceEpoch.abs().toString(),
  //         "tags": tags.toString()
  //       },
  //     ),
  //   );
  //   streamListener() async {
  //     subscription = FlutterUploader().result.listen((result) {
  //       if (result.statusCode == null) return;
  //       // print('result is $result');
  //       // print(
  //       //     'I am in result and isUploadCancel is ${Provider.of<ProviderController>(context, listen: false).isUploadCancel}');
  //       print(
  //           'the result is ${result.statusCode} and response is ${result.response}');
  //
  //       if (result.statusCode == 200 && list.isNotEmpty) {
  //         subscription.cancel();
  //
  //         uploadRecurrence();
  //         return;
  //       }
  //       if (result.statusCode == 200 && list.isEmpty) {
  //         uploadEnd(context, 'complete', csrf, id, cookie);
  //         Provider.of<ProviderController>(context, listen: false)
  //             .selectAllTapped(false);
  //         Provider.of<ProviderController>(context, listen: false).redraw();
  //         Provider.of<ProviderController>(context, listen: false)
  //             .selectionInProcess(false);
  //         Provider.of<ProviderController>(context, listen: false)
  //             .showUploadingProcess(false);
  //         Provider.of<ProviderController>(context, listen: false)
  //             .uploadProgressFunction(0);
  //         subscription.cancel();
  //         return;
  //       } else if (result.statusCode == 409) {
  //         subscription.cancel();
  //         return;
  //       }
  //     });
  //   }
  //
  //   await streamListener();
  // }

  uploadMain(BuildContext context, int id, String csrf, String cookie,
      List tags, List<AssetEntity> list) {
    recursiveUpload() async {
      if (list.isEmpty) {
        uploadEnd('complete', csrf, id, cookie);
        uiReset(context);
        return 0;
      }
      if (list.last.width == 00 && list.last.height == 00) {
        uploadEnd('cancel', csrf, id, cookie);
        list.clear();
        uiCancelReset(context);
        return 0;
      }

      var asset = list[0];
      var piv = asset.file;
      list.removeAt(0);
      Provider.of<ProviderController>(context, listen: false)
          .uploadProgressFunction(
              Provider.of<ProviderController>(context, listen: false)
                      .selectedItems
                      .length -
                  list.length);
      // await uploadBackground(
      //     context, id, piv, asset, csrf, cookie, tags, list, recursiveUpload);
      File image = await piv;
      var stream = new http.ByteStream(image.openRead());
      stream.cast();
      var length = await image.length();
      var uri = Uri.parse('https://altocode.nl/picdev/piv');
      var request = http.MultipartRequest('POST', uri);
      try {
        request.headers['cookie'] = cookie;
        request.fields['id'] = id.toString();
        request.fields['csrf'] = csrf;
        request.fields['tags'] = tags.toString();
        request.fields['lastModified'] =
            asset.modifiedDateTime.millisecondsSinceEpoch.abs().toString();
        var upiv = http.MultipartFile('piv', stream, length,
            filename: basename(image.path));
        request.files.add(upiv);
        var response = await request.send();
        final respStr = await response.stream.bytesToString();
        print(respStr);
        print(
            'DEBUG response ' + response.statusCode.toString() + ' ' + respStr);
        if (response.statusCode == 400 && respStr == '{"error":"file"}') {
          //TODO 2: MODIFY THE STATUSCODE AND ERROR STRING
          print('hello world');
          //TODO 1: Fix the Object error problem
          uploadError('error', csrf, respStr, id, cookie);
          uiReset(context);
          SnackBarGlobal.buildSnackBar(
              context, 'You\'ve run out of space.', 'red');
          return 0;
        } else if (response.statusCode >= 500) {
          uiReset(context);
          SnackBarGlobal.buildSnackBar(
              context, 'Something is wrong on our side. Sorry.', 'red');
          return 0;
        }
        recursiveUpload();
      } on SocketException catch (_) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => OfflineScreen()));
        return 0;
      }
    }

    recursiveUpload();
  }
}