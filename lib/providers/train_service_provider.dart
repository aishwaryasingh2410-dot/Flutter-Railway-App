import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/train_service.dart';

final trainServiceProvider = Provider<TrainService>((ref) {
  return TrainService();
});
