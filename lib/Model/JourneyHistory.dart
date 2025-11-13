class UserJourneysResponse {
  final bool success;
  final int statusCode;
  final String message;
  final UserJourneyDataWrapper? data;
  final dynamic pagination;
  final dynamic errors;

  UserJourneysResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
    this.pagination,
    this.errors,
  });

  factory UserJourneysResponse.fromJson(Map<String, dynamic> json) {
    final dataField = json['data'];


    UserJourneyDataWrapper? wrapper;
    if (dataField is Map<String, dynamic>) {
      wrapper = UserJourneyDataWrapper.fromJson(dataField);
    } else if (dataField is List) {
      wrapper = UserJourneyDataWrapper(
        data: dataField.map((e) => UserJourney.fromJson(e)).toList(),
        pagination: null,
      );
    }

    return UserJourneysResponse(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: wrapper,
      pagination: json['pagination'],
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'status_code': statusCode,
    'message': message,
    'data': data?.toJson(),
    'pagination': pagination,
    'errors': errors,
  };
}

class UserJourneyDataWrapper {
  final List<UserJourney>? data;
  final JourneyPagination? pagination;

  UserJourneyDataWrapper({
    this.data,
    this.pagination,
  });

  factory UserJourneyDataWrapper.fromJson(Map<String, dynamic> json) {
    return UserJourneyDataWrapper(
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => UserJourney.fromJson(e))
          .toList()
          : [],
      pagination: json['pagination'] != null
          ? JourneyPagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
    'pagination': pagination?.toJson(),
  };
}

class UserJourney {
  final String? id;
  final String? userId;
  final String? journeyId;
  final String? status;
  final int? progress;
  final String? startedAt;
  final String? completedAt;
  final Journey? journey;

  UserJourney({
    this.id,
    this.userId,
    this.journeyId,
    this.status,
    this.progress,
    this.startedAt,
    this.completedAt,
    this.journey,
  });

  factory UserJourney.fromJson(Map<String, dynamic> json) {
    return UserJourney(
      id: json['id'],
      userId: json['userId'],
      journeyId: json['journeyId'],
      status: json['status'],
      progress: json['progress'],
      startedAt: json['startedAt'],
      completedAt: json['completedAt'],
      journey:
      json['journey'] != null ? Journey.fromJson(json['journey']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'journeyId': journeyId,
    'status': status,
    'progress': progress,
    'startedAt': startedAt,
    'completedAt': completedAt,
    'journey': journey?.toJson(),
  };
}

class Journey {
  final String? id;
  final String? name;
  final String? type;
  final int? duration;
  final String? description;
  final String? rewardName;
  final String? rewardType;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? iconUrl;
  final String? backgroundImage;
  final int? totalPoi;

  Journey({
    this.id,
    this.name,
    this.type,
    this.duration,
    this.description,
    this.rewardName,
    this.rewardType,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.iconUrl,
    this.backgroundImage,
    this.totalPoi,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      duration: json['duration'],
      description: json['description'],
      rewardName: json['rewardName'],
      rewardType: json['rewardType'],
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iconUrl: json['iconUrl'],
      backgroundImage: json['backgroundImage'],
      totalPoi: json['totalPoi'],
    );
  }

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
    'backgroundImage': backgroundImage,
    'totalPoi': totalPoi,
  };
}

class JourneyPagination {
  final int? currentPage;
  final int? totalPages;
  final int? totalItems;
  final int? limit;

  JourneyPagination({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  factory JourneyPagination.fromJson(Map<String, dynamic> json) {
    return JourneyPagination(
      currentPage: json['current_page'],
      totalPages: json['total_pages'],
      totalItems: json['total_items'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'total_pages': totalPages,
    'total_items': totalItems,
    'limit': limit,
  };
}
