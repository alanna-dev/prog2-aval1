part of 'exchange.dart';

class TsvData extends DelimitedData {
  String _fileContent = '';
  List<String> list = [];
  List<String> _fields = [];
  String line1 = '';

  @override
  void load(String fileName) {
    if (File(fileName).existsSync()) {
      _fileContent = File(fileName).readAsStringSync();
      list = _fileContent.split('\n');
    } else {
      throw Exception('O arquivo $fileName não existe.');
    }

    // Verificar se o formato do arquivo é válido
    if (!isValidFileFormat()) {
      throw Exception('Formato de arquivo inválido.');
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
  String get delimiter => '\t';

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
      _fields = list[0].split(delimiter);
    } else {
      throw Exception('Não há dados carregados.');
    }
    return _fields;
  }

  @override
  bool get hasData {
    return _fileContent.isNotEmpty;
  }

  @override
  set data(String value) {
    if (value.isNotEmpty) {
      _fileContent = value;

      // Verificar se o formato do arquivo é válido
      if (!isValidFileFormat()) {
        throw Exception('Formato de arquivo inválido.');
      }
    } else {
      throw Exception('O valor dos dados está vazio.');
    }
  }

  bool isValidFileFormat() {
    // Verificar se a primeira linha contém o delimitador
    return list.isNotEmpty && list[0].contains(delimiter);
  }
}