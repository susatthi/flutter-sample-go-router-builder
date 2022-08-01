import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'entities/person.dart';
import 'pages/components/auth_user.dart';
import 'pages/family_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/person_details_page.dart';
import 'pages/person_page.dart';
import 'repositories/auth_repository.dart';

part 'router.g.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    routes: $appRoutes,

    // redirect to the login page if the user is not logged in
    redirect: (state) {
      final loggedIn = ref.read(authRepositoryProvider).loggedIn;

      // check just the subloc in case there are query parameters
      final loginLoc = const LoginRoute().location;
      final goingToLogin = state.subloc == loginLoc;

      // the user is not logged in and not headed to /login, they need to login
      if (!loggedIn && !goingToLogin) {
        return LoginRoute(from: state.subloc).location;
      }

      // the user is logged in and headed to /login, no need to login again
      if (loggedIn && goingToLogin) {
        return const HomeRoute().location;
      }

      // no need to redirect at all
      return null;
    },

    // changes on the listenable will cause the router to refresh it's route
    refreshListenable: ref.watch(authUserStateNotifierProvider),
  ),
);

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<FamilyRoute>(
      path: 'family/:fid',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<PersonRoute>(
          path: 'person/:pid',
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<PersonDetailsRoute>(path: 'details/:details'),
          ],
        ),
      ],
    )
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context) => const HomePage();
}

class FamilyRoute extends GoRouteData {
  const FamilyRoute(
    this.fid,
  );

  final String fid;

  @override
  Widget build(BuildContext context) => FamilyPage(fid: fid);
}

class PersonRoute extends GoRouteData {
  const PersonRoute(
    this.fid,
    this.pid,
  );

  final String fid;
  final int pid;

  @override
  Widget build(BuildContext context) {
    return PersonPage(fid: fid, pid: pid);
  }
}

class PersonDetailsRoute extends GoRouteData {
  const PersonDetailsRoute(
    this.fid,
    this.pid,
    this.details, {
    this.$extra,
  });

  final String fid;
  final int pid;
  final String details;
  final int? $extra;

  @override
  Page<void> buildPage(BuildContext context) {
    return MaterialPage<Object>(
      fullscreenDialog: true,
      child: PersonDetailsPage(
        fid: fid,
        pid: pid,
        details: PersonDetails.valueOf(details),
        extra: $extra,
      ),
    );
  }
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
class LoginRoute extends GoRouteData {
  const LoginRoute({
    this.from,
  });

  final String? from;

  @override
  Widget build(BuildContext context) => LoginPage(from: from);
}
