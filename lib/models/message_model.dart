class MessageModel {
  String phoneNumber; // Complete number with country code
  String message;

  MessageModel({
    this.phoneNumber = '',
    this.message = '',
  });

  // Extract only digits from phone number
  String get _digitsOnly {
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  }

  // Check if phone number has at least 10 digits
  // We need at least 10 digits total (country code + phone number)
  // For most countries: country code (1-3 digits) + phone number (10 digits) = 11-13 digits
  // But we'll accept minimum 10 digits to be more flexible
  bool get hasValidPhoneNumber {
    if (phoneNumber.isEmpty) return false;
    final digits = _digitsOnly;
    // Must have at least 10 digits total
    return digits.length >= 10;
  }

  bool get isValid {
    return hasValidPhoneNumber;
  }
}

