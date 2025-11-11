class JourneyResponse {
  final bool success;
  final int statusCode;
  final String message;
  final JourneyData? data;

  JourneyResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory JourneyResponse.fromJson(Map<String, dynamic> json) {
    return JourneyResponse(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? JourneyData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'status_code': statusCode,
    'message': message,
    'data': data?.toJson(),
  };
}

class JourneyData {
  final String id;
  final String userId;
  final String journeyId;
  final String status;
  final int progress;
  final String? startedAt;
  final String? completedAt;
  final List<JourneyBusiness> businesses;

  JourneyData({
    required this.id,
    required this.userId,
    required this.journeyId,
    required this.status,
    required this.progress,
    this.startedAt,
    this.completedAt,
    required this.businesses,
  });

  factory JourneyData.fromJson(Map<String, dynamic> json) {
    return JourneyData(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      journeyId: json['journeyId'] ?? '',
      status: json['status'] ?? '',
      progress: json['progress'] ?? 0,
      startedAt: json['startedAt'],
      completedAt: json['completedAt'],
      businesses: (json['businesses'] as List<dynamic>?)
          ?.map((e) => JourneyBusiness.fromJson(e))
          .toList() ??
          [],
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
    'businesses': businesses.map((e) => e.toJson()).toList(),
  };
}

class JourneyBusiness {
  final String id;
  final String userJourneyId;
  final String businessId;
  final String? visitedAt;
  final String status;
  final String? mapImage;
  final BusinessDetails? business;

  JourneyBusiness({
    required this.id,
    required this.userJourneyId,
    required this.businessId,
    this.visitedAt,
    required this.status,
    this.mapImage,
    this.business,
  });

  factory JourneyBusiness.fromJson(Map<String, dynamic> json) {
    return JourneyBusiness(
      id: json['id'] ?? '',
      userJourneyId: json['userJourneyId'] ?? '',
      businessId: json['businessId'] ?? '',
      visitedAt: json['visitedAt'],
      status: json['status'] ?? '',
      mapImage: json['mapImage'],
      business: json['business'] != null
          ? BusinessDetails.fromJson(json['business'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userJourneyId': userJourneyId,
    'businessId': businessId,
    'visitedAt': visitedAt,
    'status': status,
    'mapImage': mapImage,
    'business': business?.toJson(),
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
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final int participantPreRegistration;
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
  final GpsCoordinates? gpsCoordinates;

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
    required this.participantPreRegistration,
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
    this.gpsCoordinates,
  });

  factory BusinessDetails.fromJson(Map<String, dynamic> json) {
    return BusinessDetails(
      id: json['id'] ?? '',
      ownerId: json['ownerId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      companyName: json['companyName'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      googleMapLink: json['googleMapLink'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      extendedDescription: json['extendedDescription'] ?? '',
      videoLink: json['videoLink'] ?? '',
      regularOpeningHours: json['regularOpeningHours'] ?? '',
      specialOpeningHours: json['specialOpeningHours'] ?? '',
      experienceName: json['experienceName'] ?? '',
      experienceDescription: json['experienceDescription'] ?? '',
      participantLimit: json['participantLimit'] ?? 0,
      minimumPurchase: json['minimumPurchase'] ?? '',
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      participantPreRegistration: json['participantPreRegisteration'] ?? 0,
      socialMediaLink: json['socialMediaLink'] ?? '',
      step: json['step'] ?? 0,
      website: json['website'] ?? '',
      accessible: json['accessible'] ?? false,
      discounts: List<String>.from(json['discounts'] ?? []),
      familyFriendly: json['familyFriendly'] ?? false,
      petsAllowed: json['petsAllowed'] ?? false,
      pointReceive: json['pointReceive'] ?? 0,
      pointRedeemType: json['pointRedeemType'] ?? 0,
      registerationEmail: json['registerationEmail'] ?? '',
      registerationPhone: json['registerationPhone'] ?? '',
      registerationWebsite: json['registerationWebsite'] ?? '',
      spaceLimitation: json['spaceLimitation'] ?? false,
      specialCondition: json['specialCondition'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      experienceAvailable: json['experienceAvailable'] ?? 0,
      gpsCoordinates: json['gpsCoordinates'] != null
          ? GpsCoordinates.fromJson(json['gpsCoordinates'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ownerId': ownerId,
    'categoryId': categoryId,
    'companyName': companyName,
    'email': email,
    'address': address,
    'googleMapLink': googleMapLink,
    'shortDescription': shortDescription,
    'extendedDescription': extendedDescription,
    'videoLink': videoLink,
    'regularOpeningHours': regularOpeningHours,
    'specialOpeningHours': specialOpeningHours,
    'experienceName': experienceName,
    'experienceDescription': experienceDescription,
    'participantLimit': participantLimit,
    'minimumPurchase': minimumPurchase,
    'deletedAt': deletedAt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'participantPreRegisteration': participantPreRegistration,
    'socialMediaLink': socialMediaLink,
    'step': step,
    'website': website,
    'accessible': accessible,
    'discounts': discounts,
    'familyFriendly': familyFriendly,
    'petsAllowed': petsAllowed,
    'pointReceive': pointReceive,
    'pointRedeemType': pointRedeemType,
    'registerationEmail': registerationEmail,
    'registerationPhone': registerationPhone,
    'registerationWebsite': registerationWebsite,
    'spaceLimitation': spaceLimitation,
    'specialCondition': specialCondition,
    'tags': tags,
    'experienceAvailable': experienceAvailable,
    'gpsCoordinates': gpsCoordinates?.toJson(),
  };
}

class GpsCoordinates {
  final double lat;
  final double lng;

  GpsCoordinates({
    required this.lat,
    required this.lng,
  });

  factory GpsCoordinates.fromJson(Map<String, dynamic> json) {
    return GpsCoordinates(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };
}
