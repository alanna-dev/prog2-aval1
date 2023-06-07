part of 'exchange.dart';

class XmlData extends Data {
  XmlDocument? fileContent;

  @override
  void load(String fileName) {
    try {
      var xmlString = File(fileName).readAsStringSync();
      fileContent = XmlDocument.parse(xmlString);
    } catch (e) {
      throw FileLoadException('Erro ao carregar o arquivo XML: $e');
    }
  }

  @override
  void clear() {
    if (fileContent == null) {
      throw NoDataException('Não há dados carregados para limpar.');
    }
    fileContent = null;
  }

  @override
  String get data {
    if (fileContent == null) {
      throw NoDataException('Não há dados carregados para acessar.');
    }
    return fileContent!.toString();
  }

  @override
  List<String> get fields {
    if (fileContent == null) {
      throw NoDataException('Não há dados carregados para obter os campos.');
    }

    List<String> fieldList = [];

    var records = fileContent!.findAllElements('record');
    if (records.isNotEmpty) {
      var firstRecord = records.first;
      for (var attribute in firstRecord.attributes) {
        fieldList.add(attribute.name.local);
      }
    }

    return fieldList;
  }

  @override
  bool get hasData => fileContent != null;

  @override
  void save(String fileName) {
    if (fileContent == null) {
      throw NoDataException('Não há dados carregados para salvar.');
    }
    try {
      File(fileName).writeAsStringSync(fileContent!.toString());
    } catch (e) {
      throw FileSaveException('Erro ao salvar o arquivo XML: $e');
    }
  }

  @override
  set data(String value) {
    try {
      fileContent = XmlDocument.parse(value);
    } catch (e) {
      throw InvalidDataException('Dados XML inválidos: $e');
    }
  }
}

class FileLoadException implements Exception {
  final String message;

  FileLoadException(this.message);

  @override
  String toString() {
    return 'FileLoadException: $message';
  }
}

class FileSaveException implements Exception {
  final String message;

  FileSaveException(this.message);

  @override
  String toString() {
    return 'FileSaveException: $message';
  }
}

class NoDataException implements Exception {
  final String message;

  NoDataException(this.message);

  @override
  String toString() {
    return 'NoDataException: $message';
  }
}

class InvalidDataException implements Exception {
  final String message;

  InvalidDataException(this.message);

  @override
  String toString() {
    return 'InvalidDataException: $message';
  }
}
