import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:domain_hunter/screens/favorites/favorites_screen.dart';
import 'package:domain_hunter/screens/search/search_screen.dart';
import 'package:domain_hunter/screens/settings/settings_screen.dart';
import 'package:domain_hunter/widgets/nav/custom_app_bar.dart';
import 'package:domain_hunter/widgets/nav/custom_navigation.dart';

class App extends StatefulWidget {
  static const routeName = '/home';

  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int navigationIndex = 0;

  Widget _getPage(int index) {
    return [
      const SearchScreen(),
      const FavoritesScreen(),
      const SettingsScreen(),
    ].elementAt(navigationIndex);
  }

  String _getTitle(BuildContext context, int index) {
    return [
      AppLocalizations.of(context)!.search,
      AppLocalizations.of(context)!.favorites,
      AppLocalizations.of(context)!.settings,
    ].elementAt(navigationIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: _getPage(navigationIndex),
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        appBar: CustomAppBar(
          title: _getTitle(context, navigationIndex)
        ),
        bottomNavigationBar: CustomNavigation(
          index: navigationIndex,
          onTap: (int index) {
            setState(() {
              navigationIndex = index;
            });
          },
        ),
    );
  }
}
