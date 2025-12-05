class BusinessResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<Business> data;
  final Pagination pagination;
  final dynamic errors;

  BusinessResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.pagination,
    this.errors,
  });

  factory BusinessResponse.fromJson(Map<String, dynamic> json) {
    return BusinessResponse(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Business.fromJson(e))
          .toList() ??
          [],
      pagination: Pagination.fromJson(json['pagination']),
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'status_code': statusCode,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
    'pagination': pagination.toJson(),
    'errors': errors,
  };
}

class Business {
  final String id;
  final String companyName;
  final String address;
  final GpsCoordinates gpsCoordinates;
  final String shortDescription;
  final String extendedDescription;
  final int pointReceive;
  final int pointEarn;

  final List<BusinessImage> images;
  final double distanceKm;

  Business({
    required this.id,
    required this.companyName,
    required this.gpsCoordinates,
    required this.shortDescription,
    required this.extendedDescription,
    required this.pointReceive,
    required this.images,
    required this.distanceKm,
    required this.address,
    required this.pointEarn,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? '',
      companyName: json['companyName'] ?? '',
      address: json['address'] ?? '',
      gpsCoordinates: GpsCoordinates.fromJson(json['gpsCoordinates']),
      shortDescription: json['shortDescription'] ?? '',
      extendedDescription: json['extendedDescription'] ?? '',
      pointReceive: json['pointReceive'] ?? 0,
      pointEarn: json['pointEarn'] ?? 0,

      images: (json['images'] as List<dynamic>?)
          ?.map((e) => BusinessImage.fromJson(e))
          .toList() ??
          [],
      distanceKm: (json['distance_km'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'companyName': companyName,
    'gpsCoordinates': gpsCoordinates.toJson(),
    'shortDescription': shortDescription,
    'extendedDescription': extendedDescription,
    'pointReceive': pointReceive,
    'images': images.map((e) => e.toJson()).toList(),
    'distance_km': distanceKm,
    'address': address,
  };
}

class GpsCoordinates {
  final double lat;
  final double lng;

  GpsCoordinates({required this.lat, required this.lng});

  factory GpsCoordinates.fromJson(Map<String, dynamic> json) {
    return GpsCoordinates(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };
}

class BusinessImage {
  final int id;
  final String url;
  final String fileName;

  BusinessImage({
    required this.id,
    required this.url,
    required this.fileName,
  });

  factory BusinessImage.fromJson(Map<String, dynamic> json) {
    return BusinessImage(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      fileName: json['fileName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'fileName': fileName,
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

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      totalItems: json['total_items'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'total_pages': totalPages,
    'total_items': totalItems,
    'limit': limit,
  };
}
