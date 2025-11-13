
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

  factory ApiResponse.fromRawJson(String str) => ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
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
  final DateTime startedAt;
  final DateTime completedAt;
  final UserJourney journey;
  final List<UserBusiness> businesses;
  final List<ImageDetails> multimedia;
  final Summary summary;

  JourneyData({
    required this.id,
    required this.userId,
    required this.journeyId,
    required this.status,
    required this.progress,
    required this.startedAt,
    required this.completedAt,
    required this.journey,
    required this.businesses,
    required this.multimedia,
    required this.summary,
  });

  factory JourneyData.fromJson(Map<String, dynamic> json) => JourneyData(
    id: json["id"],
    userId: json["userId"],
    journeyId: json["journeyId"],
    status: json["status"],
    progress: json["progress"],
    startedAt: DateTime.parse(json["startedAt"]),
    completedAt: DateTime.parse(json["completedAt"]),
    journey: UserJourney.fromJson(json["journey"]),
    businesses: List<UserBusiness>.from(json["businesses"].map((x) => UserBusiness.fromJson(x))),
    multimedia: List<ImageDetails>.from(json["multimedia"].map((x) => ImageDetails.fromJson(x))),
    summary: Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "journeyId": journeyId,
    "status": status,
    "progress": progress,
    "startedAt": startedAt.toIso8601String(),
    "completedAt": completedAt.toIso8601String(),
    "journey": journey.toJson(),
    "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
    "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
    "summary": summary.toJson(),
  };
}

// -------------------------------------------------------------
// Nested Classes
// -------------------------------------------------------------

class UserJourney {
  final String id;
  final String name;
  final String type;
  final int duration;
  final String description;
  final String rewardName;
  final String rewardType;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? iconUrl;
  final String backgroundImage;
  final int totalPoi;
  final int stops;

  UserJourney({
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
    required this.backgroundImage,
    required this.totalPoi,
    required this.stops,
  });

  factory UserJourney.fromJson(Map<String, dynamic> json) => UserJourney(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    duration: json["duration"],
    description: json["description"],
    rewardName: json["rewardName"],
    rewardType: json["rewardType"],
    deletedAt: json["deletedAt"] == null ? null : DateTime.parse(json["deletedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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

class UserBusiness {
  final String id;
  final String userJourneyId;
  final String businessId;
  final DateTime visitedAt;
  final DateTime? visitedEndAt;
  final String status;
  final String? mapImage;
  final dynamic distance; // Type is dynamic because it's null in JSON but named "distance"
  final BusinessDetails business;

  UserBusiness({
    required this.id,
    required this.userJourneyId,
    required this.businessId,
    required this.visitedAt,
    this.visitedEndAt,
    required this.status,
    this.mapImage,
    this.distance,
    required this.business,
  });

  factory UserBusiness.fromJson(Map<String, dynamic> json) => UserBusiness(
    id: json["id"],
    userJourneyId: json["userJourneyId"],
    businessId: json["businessId"],
    visitedAt: DateTime.parse(json["visitedAt"]),
    visitedEndAt: json["visitedEndAt"] == null ? null : DateTime.parse(json["visitedEndAt"]),
    status: json["status"],
    mapImage: json["mapImage"],
    distance: json["distance"],
    business: BusinessDetails.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userJourneyId": userJourneyId,
    "businessId": businessId,
    "visitedAt": visitedAt.toIso8601String(),
    "visitedEndAt": visitedEndAt?.toIso8601String(),
    "status": status,
    "mapImage": mapImage,
    "distance": distance,
    "business": business.toJson(),
  };
}

class BusinessDetails {
  final String id;
  final String ownerId;
  final String categoryId;
  final String companyName;
  final String email;
  final String address;
  final String googleMapLink;
  final String shortDescription;
  final String extendedDescription;
  final String videoLink;
  final String regularOpeningHours;
  final String specialOpeningHours;
  final String experienceName;
  final String experienceDescription;
  final int participantLimit;
  final String minimumPurchase;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int participantPreRegisteration;
  final String socialMediaLink;
  final int step;
  final String website;
  final bool accessible;
  final List<String> discounts;
  final bool familyFriendly;
  final bool petsAllowed;
  final int pointReceive;
  final int pointRedeemType;
  final String registerationEmail;
  final String registerationPhone;
  final String registerationWebsite;
  final bool spaceLimitation;
  final String specialCondition;
  final List<String> tags;
  final int experienceAvailable;
  final GpsCoordinates gpsCoordinates;
  final Category category;
  final Owner owner;
  final List<ImageDetails> images;

  BusinessDetails({
    required this.id,
    required this.ownerId,
    required this.categoryId,
    required this.companyName,
    required this.email,
    required this.address,
    required this.googleMapLink,
    required this.shortDescription,
    required this.extendedDescription,
    required this.videoLink,
    required this.regularOpeningHours,
    required this.specialOpeningHours,
    required this.experienceName,
    required this.experienceDescription,
    required this.participantLimit,
    required this.minimumPurchase,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.participantPreRegisteration,
    required this.socialMediaLink,
    required this.step,
    required this.website,
    required this.accessible,
    required this.discounts,
    required this.familyFriendly,
    required this.petsAllowed,
    required this.pointReceive,
    required this.pointRedeemType,
    required this.registerationEmail,
    required this.registerationPhone,
    required this.registerationWebsite,
    required this.spaceLimitation,
    required this.specialCondition,
    required this.tags,
    required this.experienceAvailable,
    required this.gpsCoordinates,
    required this.category,
    required this.owner,
    required this.images,
  });

  factory BusinessDetails.fromJson(Map<String, dynamic> json) => BusinessDetails(
    id: json["id"],
    ownerId: json["ownerId"],
    categoryId: json["categoryId"],
    companyName: json["companyName"],
    email: json["email"],
    address: json["address"],
    googleMapLink: json["googleMapLink"],
    shortDescription: json["shortDescription"],
    extendedDescription: json["extendedDescription"],
    videoLink: json["videoLink"],
    regularOpeningHours: json["regularOpeningHours"],
    specialOpeningHours: json["specialOpeningHours"],
    experienceName: json["experienceName"],
    experienceDescription: json["experienceDescription"],
    participantLimit: json["participantLimit"],
    minimumPurchase: json["minimumPurchase"],
    deletedAt: json["deletedAt"] == null ? null : DateTime.parse(json["deletedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    participantPreRegisteration: json["participantPreRegisteration"],
    socialMediaLink: json["socialMediaLink"],
    step: json["step"],
    website: json["website"],
    accessible: json["accessible"],
    discounts: List<String>.from(json["discounts"].map((x) => x)),
    familyFriendly: json["familyFriendly"],
    petsAllowed: json["petsAllowed"],
    pointReceive: json["pointReceive"],
    pointRedeemType: json["pointRedeemType"],
    registerationEmail: json["registerationEmail"],
    registerationPhone: json["registerationPhone"],
    registerationWebsite: json["registerationWebsite"],
    spaceLimitation: json["spaceLimitation"],
    specialCondition: json["specialCondition"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    experienceAvailable: json["experienceAvailable"],
    gpsCoordinates: GpsCoordinates.fromJson(json["gpsCoordinates"]),
    category: Category.fromJson(json["category"]),
    owner: Owner.fromJson(json["owner"]),
    images: List<ImageDetails>.from(json["images"].map((x) => ImageDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerId": ownerId,
    "categoryId": categoryId,
    "companyName": companyName,
    "email": email,
    "address": address,
    "googleMapLink": googleMapLink,
    "shortDescription": shortDescription,
    "extendedDescription": extendedDescription,
    "videoLink": videoLink,
    "regularOpeningHours": regularOpeningHours,
    "specialOpeningHours": specialOpeningHours,
    "experienceName": experienceName,
    "experienceDescription": experienceDescription,
    "participantLimit": participantLimit,
    "minimumPurchase": minimumPurchase,
    "deletedAt": deletedAt?.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "participantPreRegisteration": participantPreRegisteration,
    "socialMediaLink": socialMediaLink,
    "step": step,
    "website": website,
    "accessible": accessible,
    "discounts": List<dynamic>.from(discounts.map((x) => x)),
    "familyFriendly": familyFriendly,
    "petsAllowed": petsAllowed,
    "pointReceive": pointReceive,
    "pointRedeemType": pointRedeemType,
    "registerationEmail": registerationEmail,
    "registerationPhone": registerationPhone,
    "registerationWebsite": registerationWebsite,
    "spaceLimitation": spaceLimitation,
    "specialCondition": specialCondition,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "experienceAvailable": experienceAvailable,
    "gpsCoordinates": gpsCoordinates.toJson(),
    "category": category.toJson(),
    "owner": owner.toJson(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Category {
  final String id;
  final String name;
  final String description;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryTypeId;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryTypeId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    deletedAt: json["deletedAt"] == null ? null : DateTime.parse(json["deletedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    categoryTypeId: json["categoryTypeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "deletedAt": deletedAt?.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "categoryTypeId": categoryTypeId,
  };
}

class GpsCoordinates {
  final double lat;
  final double lng;

  GpsCoordinates({
    required this.lat,
    required this.lng,
  });

  factory GpsCoordinates.fromJson(Map<String, dynamic> json) => GpsCoordinates(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class ImageDetails {
  final int id;
  final String? userId;
  final String businessId;
  final String url;
  final String fileName;
  final String fileType;
  final int fileSize;
  final DateTime createdAt;

  ImageDetails({
    required this.id,
    this.userId,
    required this.businessId,
    required this.url,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.createdAt,
  });

  factory ImageDetails.fromJson(Map<String, dynamic> json) => ImageDetails(
    id: json["id"],
    userId: json["userId"],
    businessId: json["businessId"],
    url: json["url"],
    fileName: json["fileName"],
    fileType: json["fileType"],
    fileSize: json["fileSize"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "businessId": businessId,
    "url": url,
    "fileName": fileName,
    "fileType": fileType,
    "fileSize": fileSize,
    "createdAt": createdAt.toIso8601String(),
  };
}

class Owner {
  final String id;
  final String fullName;
  final String email;

  Owner({
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
  };
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
    totalDistanceCovered: json["totalDistanceCovered"],
    totalTimeSpent: json["totalTimeSpent"],
    totalPointsEarned: json["totalPointsEarned"],
    offersRedeemed: json["offersRedeemed"],
  );

  Map<String, dynamic> toJson() => {
    "totalDistanceCovered": totalDistanceCovered,
    "totalTimeSpent": totalTimeSpent,
    "totalPointsEarned": totalPointsEarned,
    "offersRedeemed": offersRedeemed,
  };
}