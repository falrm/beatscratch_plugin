import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:base_x/base_x.dart';
import 'midi_theory.dart';
import 'my_platform.dart';
import 'package:unification/unification.dart';
import 'package:http/http.dart' as http;

import 'generated/protos/music.pb.dart';
import 'util.dart';

var _base58 = BaseXCodec('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
final urlPrefix = MyPlatform.isDebug ? "http://localhost:8000/app-staging/" : "https://beatscratch.io/app/";

extension URLConversions on Score {
  String convertToUrl() {
    final dataString = toUrlHashValue();
    final urlString = "$urlPrefix#/score/$dataString";
    return urlString;
  }

  Future<String> convertToShortUrl() async {
    try {
      http.Response response = await http.post(
        'https://api.paste.ee/v1/pastes',
        headers: <String, String>{
          "X-Auth-Token": "aoOBUGRTRNe1caTvisGYOjCpGT1VmwthQcqC8zrjX",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'expiration': 31536000,
          'sections': [{
            'contents': convertToUrl()
          }],
        }),
      );
      String pasteeeShortcode = jsonDecode(response.body)['id'];
      final urlString = "$urlPrefix#/s/$pasteeeShortcode";
      return urlString;
    } catch (any) {
      return null;
    }
  }

  String toUrlHashValue() {
    final data = writeToBuffer();
    final bz2Data = BZip2Encoder().encode(data);
    final dataToConvert = (data.length <= bz2Data.length) ? data : bz2Data;
    final dataString = _base58.encode(dataToConvert);
    return dataString;
  }
}

Score scoreFromUrlHashValue(String urlString) {
  final dataBytes = _base58.decode(urlString);
  Score score;
  try {
    score = Score.fromBuffer(dataBytes);
  } catch (any) {
    try {
      score = Score.fromBuffer(BZip2Decoder().decodeBytes(dataBytes));
    } catch (any) {
    }
  }
  return score;
}

Future<Score> scoreFromShortUrl() {

}

