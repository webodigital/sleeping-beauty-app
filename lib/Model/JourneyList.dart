class JourneysResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<Journey> data;
  final Pagination? pagination;
  final dynamic errors;

  JourneysResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    this.pagination,
    this.errors,
  });

  factory JourneysResponse.fromJson(Map<String, dynamic> json) => JourneysResponse(
    success: json['success'] ?? false,
    statusCode: json['status_code'] ?? 0,
    message: json['message'] ?? '',
    data: json['data'] != null
        ? List<Journey>.from(json['data'].map((x) => Journey.fromJson(x)))
        : [],
    pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    errors: json['errors'],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'status_code': statusCode,
    'message': message,
    'data': data.map((x) => x.toJson()).toList(),
    'pagination': pagination?.toJson(),
    'errors': errors,
  };
}

class Journey {
  final String id;
  final String name;
  final String type;
  final int duration;
  final String description;
  final String rewardName;
  final String rewardType;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final String? iconUrl;
  final int totalPoi;

  Journey({
    required this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.description,
    required this.rewardName,
    required this.rewardType,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.iconUrl,
    required this.totalPoi,
  });

  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    type: json['type'] ?? '',
    duration: json['duration'] ?? 0,
    description: json['description'] ?? '',
    rewardName: json['rewardName'] ?? '',
    rewardType: json['rewardType'] ?? '',
    deletedAt: json['deletedAt'],
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
    iconUrl: json['iconUrl'],
    totalPoi: json['totalPoi'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'duration': duration,
    'description': description,
    'rewardName': rewardName,
    'rewardType': rewardType,
    'deletedAt': deletedAt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'iconUrl': iconUrl,
    'totalPoi': totalPoi,
  };
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json['current_page'] ?? 0,
    totalPages: json['total_pages'] ?? 0,
    totalItems: json['total_items'] ?? 0,
    limit: json['limit'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'total_pages': totalPages,
    'total_items': totalItems,
    'limit': limit,
  };
}
