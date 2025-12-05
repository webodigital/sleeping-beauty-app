import 'dart:convert';

class ApiResponse {
  final bool success;
  final int statusCode;
  final String message;
  final JourneyData? data;
  final dynamic pagination;
  final dynamic errors;

  ApiResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
    this.pagination,
    this.errors,
  });

  factory ApiResponse.fromRawJson(String str) =>
      ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    success: json["success"] ?? false,
    statusCode: json["status_code"] ?? 0,
    message: json["message"] ?? "",
    data: json["data"] == null ? null : JourneyData.fromJson(json["data"]),
    pagination: json["pagination"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
    "pagination": pagination,
    "errors": errors,
  };
}

// -------------------------------------------------------------
// Data Class: JourneyData
// -------------------------------------------------------------
class JourneyData {
  final String id;
  final String userId;
  final String journeyId;
  final String status;
  final int progress;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final UserJourney? journey;
  final List<UserBusiness> businesses;
  final List<ImageDetails> multimedia;
  final Summary? summary;

  JourneyData({
    required this.id,
    required this.userId,
    required this.journeyId,
    required this.status,
    required this.progress,
    this.startedAt,
    this.completedAt,
    this.journey,
    required this.businesses,
    required this.multimedia,
    this.summary,
  });

  factory JourneyData.fromJson(Map<String, dynamic> json) => JourneyData(
    id: json["id"] ?? "",
    userId: json["userId"] ?? "",
    journeyId: json["journeyId"] ?? "",
    status: json["status"] ?? "",
    progress: json["progress"] ?? 0,
    startedAt:
    json["startedAt"] != null ? DateTime.tryParse(json["startedAt"]) : null,
    completedAt:
    json["completedAt"] != null ? DateTime.tryParse(json["completedAt"]) : null,
    journey: json["journey"] == null
        ? null
        : UserJourney.fromJson(json["journey"]),
    businesses: json["businesses"] == null
        ? []
        : List<UserBusiness>.from(
        json["businesses"].map((x) => UserBusiness.fromJson(x))),
    multimedia: json["multimedia"] == null
        ? []
        : List<ImageDetails>.from(
        json["multimedia"].map((x) => ImageDetails.fromJson(x))),
    summary:
    json["summary"] == null ? null : Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "journeyId": journeyId,
    "status": status,
    "progress": progress,
    "startedAt": startedAt?.toIso8601String(),
    "completedAt": completedAt?.toIso8601String(),
    "journey": journey?.toJson(),
    "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
    "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
    "summary": summary?.toJson(),
  };
}

// -------------------------------------------------------------
// UserJourney
// -------------------------------------------------------------
class UserJourney {
  final String id;
  final String name;
  final String type;
  final int? duration;
  final String? description;
  final String? rewardName;
  final String? rewardType;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? iconUrl;
  final String? backgroundImage;
  final int? totalPoi;
  final int? stops;

  UserJourney({
    required this.id,
    required this.name,
    required this.type,
    this.duration,
    this.description,
    this.rewardName,
    this.rewardType,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.iconUrl,
    this.backgroundImage,
    this.totalPoi,
    this.stops,
  });

  factory UserJourney.fromJson(Map<String, dynamic> json) => UserJourney(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    type: json["type"] ?? "",
    duration: json["duration"],
    description: json["description"],
    rewardName: json["rewardName"],
    rewardType: json["rewardType"],
    deletedAt: json["deletedAt"] == null
        ? null
        : DateTime.tryParse(json["deletedAt"]),
    createdAt: DateTime.tryParse(json["createdAt"]) ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"]) ?? DateTime.now(),
    iconUrl: json["iconUrl"],
    backgroundImage: json["backgroundImage"],
    totalPoi: json["totalPoi"],
    stops: json["stops"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "duration": duration,
    "description": description,
    "rewardName": rewardName,
    "rewardType": rewardType,
    "deletedAt": deletedAt?.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "iconUrl": iconUrl,
    "backgroundImage": backgroundImage,
    "totalPoi": totalPoi,
    "stops": stops,
  };
}

// -------------------------------------------------------------
// UserBusiness
// -------------------------------------------------------------
class UserBusiness {
  final String id;
  final String userJourneyId;
  final String businessId;
  final DateTime? visitedAt;
  final DateTime? visitedEndAt;
  final String status;
  final String? mapImage;
  final dynamic distance;
  final GpsCoordinates? sourceGPS;
  final GpsCoordinates? destinationGPS;
  final BusinessDetails? business;

  UserBusiness({
    required this.id,
    required this.userJourneyId,
    required this.businessId,
    this.visitedAt,
    this.visitedEndAt,
    required this.status,
    this.mapImage,
    this.distance,
    this.sourceGPS,
    this.destinationGPS,
    this.business,
  });

  factory UserBusiness.fromJson(Map<String, dynamic> json) => UserBusiness(
    id: json["id"] ?? "",
    userJourneyId: json["userJourneyId"] ?? "",
    businessId: json["businessId"] ?? "",
    visitedAt: json["visitedAt"] == null
        ? null
        : DateTime.tryParse(json["visitedAt"]),
    visitedEndAt: json["visitedEndAt"] == null
        ? null
        : DateTime.tryParse(json["visitedEndAt"]),
    status: json["status"] ?? "",
    mapImage: json["mapImage"],
    distance: json["distance"],
    sourceGPS: json["sourceGPS"] == null
        ? null
        : GpsCoordinates.fromJson(json["sourceGPS"]),
    destinationGPS: json["destinationGPS"] == null
        ? null
        : GpsCoordinates.fromJson(json["destinationGPS"]),
    business: json["business"] == null
        ? null
        : BusinessDetails.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userJourneyId": userJourneyId,
    "businessId": businessId,
    "visitedAt": visitedAt?.toIso8601String(),
    "visitedEndAt": visitedEndAt?.toIso8601String(),
    "status": status,
    "mapImage": mapImage,
    "distance": distance,
    "sourceGPS": sourceGPS?.toJson(),
    "destinationGPS": destinationGPS?.toJson(),
    "business": business?.toJson(),
  };
}

// -------------------------------------------------------------
// BusinessDetails
// -------------------------------------------------------------
class BusinessDetails {
  final String id;
  final String companyName;
  final String? address;
  final bool? accessible;
  final int? pointEarn;
  final int? pointRedeemType;
  final List<String> discounts;
  final GpsCoordinates? gpsCoordinates;
  final Category? category;
  final Owner? owner;
  final List<ImageDetails> images;

  BusinessDetails({
    required this.id,
    required this.companyName,
    this.address,
    this.accessible,
    this.pointEarn,
    this.pointRedeemType,
    required this.discounts,
    this.gpsCoordinates,
    this.category,
    this.owner,
    required this.images,
  });

  factory BusinessDetails.fromJson(Map<String, dynamic> json) => BusinessDetails(
    id: json["id"] ?? "",
    companyName: json["companyName"] ?? "",
    address: json["address"],
    accessible: json["accessible"],
    pointEarn: json["pointEarn"] ?? 0,
    pointRedeemType: json["pointRedeemType"] ?? 0,
    discounts: json["discounts"] == null
        ? []
        : List<String>.from(json["discounts"].map((x) => x ?? "")),
    gpsCoordinates: json["gpsCoordinates"] == null
        ? null
        : GpsCoordinates.fromJson(json["gpsCoordinates"]),
    category:
    json["category"] == null ? null : Category.fromJson(json["category"]),
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
    images: json["images"] == null
        ? []
        : List<ImageDetails>.from(
        json["images"].map((x) => ImageDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "address": address,
    "accessible": accessible,
    "pointEarn": pointEarn,
    "pointRedeemType": pointRedeemType,
    "discounts": List<dynamic>.from(discounts.map((x) => x)),
    "gpsCoordinates": gpsCoordinates?.toJson(),
    "category": category?.toJson(),
    "owner": owner?.toJson(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

// -------------------------------------------------------------
// Shared Classes
// -------------------------------------------------------------
class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class GpsCoordinates {
  final double lat;
  final double lng;

  GpsCoordinates({required this.lat, required this.lng});

  factory GpsCoordinates.fromJson(Map<String, dynamic> json) => GpsCoordinates(
    lat: (json["lat"] ?? 0).toDouble(),
    lng: (json["lng"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {"lat": lat, "lng": lng};
}

class ImageDetails {
  final int id;
  final String? url;

  ImageDetails({required this.id, this.url});

  factory ImageDetails.fromJson(Map<String, dynamic> json) => ImageDetails(
    id: json["id"] ?? 0,
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {"id": id, "url": url};
}

class Owner {
  final String id;
  final String fullName;
  final String email;

  Owner({required this.id, required this.fullName, required this.email});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"] ?? "",
    fullName: json["fullName"] ?? "",
    email: json["email"] ?? "",
  );

  Map<String, dynamic> toJson() =>
      {"id": id, "fullName": fullName, "email": email};
}

class Summary {
  final String totalDistanceCovered;
  final String totalTimeSpent;
  final String totalPointsEarned;
  final int offersRedeemed;

  Summary({
    required this.totalDistanceCovered,
    required this.totalTimeSpent,
    required this.totalPointsEarned,
    required this.offersRedeemed,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalDistanceCovered: json["totalDistanceCovered"] ?? "0 km",
    totalTimeSpent: json["totalTimeSpent"] ?? "0h 0m",
    totalPointsEarned: json["totalPointsEarned"] ?? "0",
    offersRedeemed: json["offersRedeemed"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "totalDistanceCovered": totalDistanceCovered,
    "totalTimeSpent": totalTimeSpent,
    "totalPointsEarned": totalPointsEarned,
    "offersRedeemed": offersRedeemed,
  };
}
