import 'package:gsheets/gsheets.dart';
import 'package:flutter_application_1/pages/numberChange_page.dart';

class NumberChange {
  static const String _sheetId = '1kk6-cMV7PMmwxqJmSofvcS7sI4-m_fP2txC-Zgt0uu0';

  static const _sheetCredentials = r'''
{
  "type": "service_account",
  "project_id": "powerful-star-379506",
  "private_key_id": "79352e77f48fc2767921c68b316edca41f37a050",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDvkj2F0S4RXhsg\nAEky2R/J80MGJQc6tB6ZKymqKzf4QpCJk9ktQJhXuHpxcajP5lCEeZCyKtMtAxS5\n/LKxJH51AbJv7cVWU+RSc0h2WhpINRLIHpmrlXG1gd3vWrqHkUwVJuzxrhZ6jgpv\n6yIGOJcMvnkY2xrrSWwtzru0vPEfscV3zzTrU63xAbw5v4JtyhyGTtU93DtYpQuN\n1aY9WT43ygN6He7hCUPLL5AO4X9znPcgYaYEW5clKdwzAM5cn53VvCFZFEK9ycjr\nYpbZNiSW+K8yz4vEyYPavGmcOx6SYnWJjc+eMVE5ntoaJBvfimbefVNgxP0XikdK\nbgHT2AP9AgMBAAECggEAIVUxHzHUHZGA56pyhNMl86TXof6760SNb1VMlkMuJeop\nDyNVl9DBgY8G5krgqJCMimoZoliICl6/3wLUYAZKXABQ8fbcup6wiXJF1kXCG2Lb\nCqILUo7YA9+eYAO5KUyjj9vbIuNMeF/T/u9xy/jKt3i3A6jUrYEJPrRhdIvHZtfB\nzh9bVkwiJh70oI4VByRzCZl3eLQT4X7qHmVsGx5SgN424p8orz/klNQKI87ay5yK\ncN4YKtbootN7PzRl/pWWCvnxFRsmxstsA56CJW0TJmF5ujZkEXNof2QBzI48WV8x\nffbXTcKwgLI5eXRmCOmy2HXXF9yr17Ua/6SeLF1TQQKBgQD4pIwoujdc4qmM1KCX\ncsdp5knbLLN17aoWyNn91dGxArXPEPaL2XzflTaFIi++e0Sc7LWUXo88NMEq4itv\nS5jHBdqHOCI1oZvgTyHmt6pOfXpSSqqHStmnAk56uPIGZn4DE6tvqm1Bo4xUByzU\nTivykDg4sblKfouJbCNVBCRynQKBgQD2qPoKTnaw3j/Z8vZ5TKN9t31m0vGzOS5t\nlKMYiLOuhtrMd+uCPLhKh7y9KWRnoxYqIFd27ef+3Hj5Vh8arUK7rQ4OjbNgpew4\nD5VTeNaufL+epxeMOO4xlK9QY8wChdQq5LbWWtQgVgcCHhZNcNZ3gHZjVe3K0Mf5\n23BXsGXo4QKBgQCHc2x/S2KZkUj4VWTe3EJSKIgXhDSHi99a5jQLGg5PtcBBe2Y0\nLVjfnDPFNyh3RkPMkQ8iMpkpHTwWFnu+95nU4hV4EFZijRWTjshTHb8DX0vhxJc9\neMM1PgZuyI3gerkvB+oevOMkHOp3ZClBxwwd6f8Ws4rTUDjHtkdRKx6H6QKBgQDc\nCStczFgHOYweQiZrWNmzyV79vgnNRqJLMMA5n6EifLxskEGwIbiJDANrf6RI62xX\nUhiUSHCfo0/rpU8D/jG8uAkFJJUzD3DlJcmg9/gTGcfaoNZZyWN7KVcnUI9qZLY7\nOWJ9X/NBkVyZH/vnQ1SesCNsQ/hn582s73uNThfrIQKBgGIkJQa8MOBv0zLhvoZd\n8g7N3QPG3CN8LWBQNXKS0WX3tPmSpw7DK2QhNC5yTje+gJY3I6Sow/oCucDyU+ZE\nR3i7+miqXnCNiY5fVTR+AuiajOoyM7EIC4xRt8cj+3mqEZrWmydvyBC7rDlBNWcb\nD5GCqtGDXn8gqVNuqnf8d7Yj\n-----END PRIVATE KEY-----\n",
  "client_email": "slt-644@powerful-star-379506.iam.gserviceaccount.com",
  "client_id": "112731139145131725498",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/slt-644%40powerful-star-379506.iam.gserviceaccount.com"
}

''';

  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);

  static Future init() async {
    try{
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);

      _userSheet = await _getWorkSheet(spreadsheet, title: "Number Change");
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}