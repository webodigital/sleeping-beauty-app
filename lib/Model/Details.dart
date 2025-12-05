class BusinessDetailResponse {
  final bool success;
  final int statusCode;
  final String message;
  final BusinessData? data;

  BusinessDetailResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory BusinessDetailResponse.fromJson(Map<String, dynamic> json) {
    return BusinessDetailResponse(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? BusinessData.fromJson(json['data']) : null,
    );
  }
}

class BusinessData {
  final Business? business;

  BusinessData({this.business});

  factory BusinessData.fromJson(Map<String, dynamic> json) {
    return BusinessData(
      business: json['business'] != null
          ? Business.fromJson(json['business'])
          : null,
    );
  }
}

class Business {
  final String id;
  final String ownerId;
  final String categoryId;
  final String companyName;
  final String? email;
  final String? address;
  final String? googleMapLink;
  final String? shortDescription;
  final String? extendedDescription;
  final String? videoLink;
  final String? regularOpeningHours;
  final String? specialOpeningHours;
  final String? experienceName;
  final String? experienceDescription;
  final int? participantLimit;
  final String? minimumPurchase;
  final int? participantPreRegisteration;
  final String? socialMediaLink;
  final int? step;
  final String? website;
  final bool? accessible;
  final List<String>? discounts;
  final bool? familyFriendly;
  final bool? petsAllowed;
  final int? pointReceive;
  final int? pointRedeemType;
  final String? registerationEmail;
  final String? registerationPhone;
  final String? registerationWebsite;
  final bool? spaceLimitation;
  final String? specialCondition;
  final List<String>? tags;
  final int? experienceAvailable;
  final GpsCoordinates? gpsCoordinates;
  final Owner? owner;
  final Category? category;
  final List<BusinessImage>? images;
  final double? distance;
  final int? pointEarn;


  Business({
    required this.id,
    required this.ownerId,
    required this.categoryId,
    required this.companyName,
    this.email,
    this.address,
    this.googleMapLink,
    this.shortDescription,
    this.extendedDescription,
    this.videoLink,
    this.regularOpeningHours,
    this.specialOpeningHours,
    this.experienceName,
    this.experienceDescription,
    this.participantLimit,
    this.minimumPurchase,
    this.participantPreRegisteration,
    this.socialMediaLink,
    this.step,
    this.website,
    this.accessible,
    this.discounts,
    this.familyFriendly,
    this.petsAllowed,
    this.pointReceive,
    this.pointRedeemType,
    this.registerationEmail,
    this.registerationPhone,
    this.registerationWebsite,
    this.spaceLimitation,
    this.specialCondition,
    this.tags,
    this.experienceAvailable,
    this.gpsCoordinates,
    this.owner,
    this.category,
    this.images,
    this.distance,
    this.pointEarn
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? '',
      ownerId: json['ownerId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      companyName: json['companyName'] ?? '',
      email: json['email'],
      address: json['address'],
      googleMapLink: json['googleMapLink'],
      shortDescription: json['shortDescription'],
      extendedDescription: json['extendedDescription'],
      videoLink: json['videoLink'],
      regularOpeningHours: json['regularOpeningHours'],
      specialOpeningHours: json['specialOpeningHours'],
      experienceName: json['experienceName'],
      experienceDescription: json['experienceDescription'],
      participantLimit: json['participantLimit'],
      minimumPurchase: json['minimumPurchase'],
      participantPreRegisteration: json['participantPreRegisteration'],
      socialMediaLink: json['socialMediaLink'],
      step: json['step'],
      website: json['website'],
      accessible: json['accessible'],
      discounts:
      json['discounts'] != null ? List<String>.from(json['discounts']) : [],
      familyFriendly: json['familyFriendly'],
      petsAllowed: json['petsAllowed'],
      pointReceive: json['pointReceive'],
      pointRedeemType: json['pointRedeemType'],
      registerationEmail: json['registerationEmail'],
      registerationPhone: json['registerationPhone'],
      registerationWebsite: json['registerationWebsite'],
      spaceLimitation: json['spaceLimitation'],
      specialCondition: json['specialCondition'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      experienceAvailable: json['experienceAvailable'],
      gpsCoordinates: json['gpsCoordinates'] != null
          ? GpsCoordinates.fromJson(json['gpsCoordinates'])
          : null,
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      images: json['images'] != null
          ? (json['images'] as List)
          .map((e) => BusinessImage.fromJson(e))
          .toList()
          : [],
      distance: (json['distance'] ?? 0).toDouble(),
      pointEarn: (json['pointEarn'] ?? 0),

    );
  }
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

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class Category {
  final String id;
  final String name;
  final String? description;

  Category({
    required this.id,
    required this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
    );
  }
}

class BusinessImage {
  final int id;
  final String url;
  final String fileName;
  final String? fileType;
  final int? fileSize;

  BusinessImage({
    required this.id,
    required this.url,
    required this.fileName,
    this.fileType,
    this.fileSize,
  });

  factory BusinessImage.fromJson(Map<String, dynamic> json) {
    return BusinessImage(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      fileName: json['fileName'] ?? '',
      fileType: json['fileType'],
      fileSize: json['fileSize'],
    );
  }
}
