class HistoryModel {
  String phoneNumber;
  DateTime timestamp;

  HistoryModel({
    required this.phoneNumber,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

