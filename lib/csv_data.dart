part of 'exchange.dart';

class CsvData extends DelimitedData {
  String _fileContent = '';
  List<String> list = [];

  @override
  void load(String fileName) {
    if (File(fileName).existsSync()) {
      _fileContent = File(fileName).readAsStringSync();
      list = _fileContent.split('\n');
    } else {
      throw Exception('O arquivo $fileName não existe.');
    }
  }

  @override
  void save(String fileName) {
    if (_fileContent.isNotEmpty) {
      File(fileName).writeAsStringSync(_fileContent);
    } else {
      throw Exception('Nenhum dado para salvar.');
    }
  }

  @override
  void clear() {
    _fileContent = '';
  }

  @override
  String get data {
    return _fileContent;
  }

  @override
  List<String> get fields {
    if (list.isNotEmpty) {
      return list[0].split(delimiter);
    } else {
      throw Exception('Não há dados carregados.');
    }
  }

  @override
  bool get hasData {
    return _fileContent.isNotEmpty;
  }

  @override
  set data(String? value) {
    if (value != null) {
      _fileContent = value;
    } else {
      throw Exception('O valor dos dados é nulo.');
    }
  }

  @override
  String get delimiter => ',';
}
