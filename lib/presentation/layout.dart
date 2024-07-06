import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:top_heroes_companion_app/presentation/theme.dart';

class NavigationData {
  final Icon icon;
  final String title;
  final Widget target;

  NavigationData(
      {required this.icon, required this.title, required this.target});
}

class Layout extends StatelessWidget {
  const Layout(
      {required this.child, required this.navigation, this.drawer, super.key});

  final Widget child;
  final Widget? drawer;
  final List<NavigationData> navigation;

  @override
  Widget build(BuildContext context) {
    final isMobile = getValueForScreenType<bool>(
        context: context, mobile: true, desktop: false);
    final drawerButtonOrSizedBox = isMobile
        ? Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          )
        : const SizedBox();

    final bottomNavigation = navigation.isEmpty
        ? const SizedBox()
        : BottomNavigationBar(
            backgroundColor: appBarColor,
            selectedIconTheme: Theme.of(context)
                .iconTheme
                .copyWith(color: appBarSelectedTabColor),
            selectedItemColor: appBarSelectedTabColor,
            unselectedIconTheme:
                Theme.of(context).iconTheme.copyWith(color: appBarTextColor),
            unselectedItemColor: appBarTextColor,
            items: navigation
                .map((nav) =>
                    BottomNavigationBarItem(icon: nav.icon, label: nav.title))
                .toList());

    return Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: isMobile ? bottomNavigation : null,
        drawer: drawer,
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: drawerButtonOrSizedBox,
          title: isMobile
              ? const Text('Top Heroes!')
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Top Heroes!'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: navigation
                          .map((nav) => TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => nav.target));
                              },
                              child: Text(nav.title)))
                          .toList(),
                    )
                  ],
                ),
          //bottom: isMobile ? null : topNavigation
        ),
        body: child);
  }
}
