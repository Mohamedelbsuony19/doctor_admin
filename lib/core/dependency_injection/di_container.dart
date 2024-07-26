import 'package:clinic_package/clinic_package.dart';

import 'register_commands.dart';
import 'register_data_sources.dart';
import 'register_factories.dart';
import 'register_queries.dart';
import 'register_repositories.dart';
import 'register_singletons.dart';

final String restBaseUrl = getIt<AppConfig>().restBaseUrl;

Future<void> initDependencyInjection() async {
  await registerSingletons();
  registerDataSources();
  registerRepositories();
  registerQueries();
  registerCommands();
  registerFactories();
}
