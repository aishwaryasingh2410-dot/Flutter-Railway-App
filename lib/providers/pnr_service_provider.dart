import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/pnr_service.dart';

final pnrServiceProvider = Provider<PnrService>((ref) => PnrService());
