part of 'exchange.dart';

class JsonData extends Data {
  List<Map<String, dynamic>> _data = [];
  String fileContent = '';
  bool modified = false;

  @override
  void load(String fileName) {
    modified = false;
    if (File(fileName).existsSync()) {
      final fileContent = File(fileName).readAsStringSync();
      final jsonData = json.decode(fileContent) as List<dynamic>;

      _data = jsonData.map((dynamic item) {
        final mapItem = item as Map<String, dynamic>;
        final convertedValues =
            mapItem.values.map((dynamic value) => value.toString()).toList();
        final Map<String, dynamic> convertedMap =
            Map.fromIterables(mapItem.keys, convertedValues);
        return convertedMap;
      }).toList();
    } else {
      throw Exception('O arquivo $fileName não existe.');
    }
  }

  @override
  bool get hasData {
    return _data.isNotEmpty;
  }

  @override
  void save(String fileName) {
    if (_data.isNotEmpty) {
      final fileContent = json.encode(_data);
      File(fileName).writeAsStringSync(fileContent);
    } else {
      throw Exception('Nenhum dado para salvar.');
    }
  }

  @override
  void clear() {
    _data = [];
  }

  @override
  List<String> get fields {
    final Set<String> fieldSet = {};
    for (final record in _data) {
      fieldSet.addAll(record.keys);
    }
    return fieldSet.toList();
  }

  @override
  String get data {
    return json.encode(_data);
  }

  @override
  set data(String value) {
    try {
      final dynamic jsonData = json.decode(value);

      if (jsonData is! List<dynamic>) {
        throw FormatException('Formato inválido do arquivo JSON');
      }

      _data = jsonData.map((dynamic item) {
        final mapItem = item as Map<String, dynamic>;
        final convertedValues =
            mapItem.values.map((dynamic value) => value.toString()).toList();
        final Map<String, dynamic> convertedMap =
            Map.fromIterables(mapItem.keys, convertedValues);
        return convertedMap;
      }).toList();
    } catch (e) {
      throw Exception('Erro ao processar o arquivo JSON: $e');
    }
  }
}
