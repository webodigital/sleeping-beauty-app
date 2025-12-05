class ProfileResponse {
  final bool success;
  final int statusCode;
  final String message;
  final ProfileData? data;
  final dynamic pagination;
  final dynamic errors;

  ProfileResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
    this.pagination,
    this.errors,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
      pagination: json['pagination'],
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status_code': statusCode,
      'message': message,
      'data': data?.toJson(),
      'pagination': pagination,
      'errors': errors,
    };
  }
}

class ProfileData {
  final User? user;

  ProfileData({this.user});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
    };
  }
}

class User {
  final String? id;
  final String? fullName;
  final String? email;
  final String? otp;
  final String? otpExpires;
  final String? otpVerificationToken;
  final String? roleId;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? pointEarn;
  final Role? role;
  final Avatar? avatar;
  final String? qrUrl;

  User({
    this.id,
    this.fullName,
    this.email,
    this.otp,
    this.otpExpires,
    this.otpVerificationToken,
    this.roleId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.pointEarn,
    this.role,
    this.avatar,
    this.qrUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      otp: json['otp'],
      otpExpires: json['otpExpires'],
      otpVerificationToken: json['otpVerificationToken'],
      roleId: json['roleId'],
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      pointEarn: json['pointEarn'],
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      qrUrl: json['qrUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'otp': otp,
      'otpExpires': otpExpires,
      'otpVerificationToken': otpVerificationToken,
      'roleId': roleId,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'pointEarn': pointEarn,
      'role': role?.toJson(),
      'avatar': avatar?.toJson(),
      'qrUrl': qrUrl,
    };
  }
}

class Role {
  final String? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Role({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Avatar {
  final int? id;
  final String? userId;
  final String? businessId;
  final String? url;
  final String? fileName;
  final String? fileType;
  final int? fileSize;
  final String? createdAt;

  Avatar({
    this.id,
    this.userId,
    this.businessId,
    this.url,
    this.fileName,
    this.fileType,
    this.fileSize,
    this.createdAt,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'],
      userId: json['userId'],
      businessId: json['businessId'],
      url: json['url'],
      fileName: json['fileName'],
      fileType: json['fileType'],
      fileSize: json['fileSize'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessId': businessId,
      'url': url,
      'fileName': fileName,
      'fileType': fileType,
      'fileSize': fileSize,
      'createdAt': createdAt,
    };
  }
}
