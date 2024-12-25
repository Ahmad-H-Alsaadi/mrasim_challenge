// documentation_model.dart
class DocFeature {
  final String title;
  final String description;

  DocFeature({
    required this.title,
    required this.description,
  });

  factory DocFeature.fromJson(Map<String, dynamic> json) {
    return DocFeature(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}

class DocumentationModel {
  final String title;
  final List<DocFeature> features;

  DocumentationModel({
    required this.title,
    required this.features,
  });

  factory DocumentationModel.fromJson(Map<String, dynamic> json) {
    final docData = json['documentation'] as Map<String, dynamic>;
    return DocumentationModel(
      title: docData['title'] as String,
      features: (docData['features'] as List)
          .map((feature) => DocFeature.fromJson(feature as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentation': {
        'title': title,
        'features': features.map((feature) => feature.toJson()).toList(),
      }
    };
  }
}

class AppDocumentation {
  static final DocumentationModel pages = DocumentationModel(
    title: 'App Documntation',
    features: [
      DocFeature(
        title: 'Product List Management',
        description:
            'Browse and manage your product inventory with an intuitive list interface. Easily view product names, images, and prices.',
      ),
      DocFeature(
        title: 'Quick Actions',
        description:
            'Perform common tasks efficiently: Add new products with the floating action button, remove items with a simple swipe gesture.',
      ),
      DocFeature(
        title: 'Data Validation',
        description:
            'Smart form validation ensures all product information is complete and correct before saving.',
      ),
      DocFeature(
        title: 'Local Storage',
        description:
            'Reliable local data persistence using SQLite keeps your product data safe and accessible.',
      ),
      DocFeature(
        title: 'Search & Filter',
        description:
            'Find products quickly with powerful search and filtering options by name, price, or date added.',
      ),
      DocFeature(
        title: 'Theme Support',
        description: 'Comfortable viewing in any lighting with automatic dark mode support.',
      ),
    ],
  );
}
