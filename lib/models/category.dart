import 'enums.dart';

class Category {
  final int id;
  final String name;

  /// Nombre del ícono de Material Icons (ej: 'restaurant', 'directions_car').
  final String iconName;

  /// Color almacenado como valor ARGB (ej: Color(0xFF...).value).
  final int colorValue;

  final CategoryType type;

  /// true = viene con la app; false = creada por el usuario.
  final bool isDefault;

  const Category({
    required this.id,
    required this.name,
    required this.iconName,
    required this.colorValue,
    required this.type,
    this.isDefault = false,
  });

  Category copyWith({
    int? id,
    String? name,
    String? iconName,
    int? colorValue,
    CategoryType? type,
    bool? isDefault,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorValue: colorValue ?? this.colorValue,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
