import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'entities/person.dart';
import 'pages/components/auth_user.dart';
import 'pages/family_screen.dart';
import 'pages/home_screen.dart';
import 'pages/login_screen.dart';
import 'pages/person_details_page.dart';
import 'pages/person_screen.dart';
import 'repositories/auth_repository.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'family/:fid',
            builder: (context, state) => FamilyScreen(
              fid: state.params['fid']!,
            ),
            routes: [
              GoRoute(
                path: 'person/:pid',
                builder: (context, state) => PersonScreen(
                  fid: state.params['fid']!,
                  pid: int.parse(state.params['pid']!),
                ),
                routes: [
                  GoRoute(
                    path: 'details/:details',
                    builder: (context, state) => PersonDetailsPage(
                      fid: state.params['fid']!,
                      pid: int.parse(state.params['pid']!),
                      details: PersonDetails.valueOf(state.params['details']),
                      extra: state.extra as int?,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(
          from: state.queryParams['from'],
        ),
      ),
    ],

    // redirect to the login page if the user is not logged in
    redirect: (state) {
      // final loggedIn = loginInfo.loggedIn;

      // // check just the subloc in case there are query parameters
      // final String loginLoc = const LoginRoute().location;
      // final goingToLogin = state.subloc == loginLoc;

      // // the user is not logged in and not headed to /login, they need to login
      // if (!loggedIn && !goingToLogin) {
      //   return LoginRoute(fromPage: state.subloc).location;
      // }

      // // the user is logged in and headed to /login, no need to login again
      // if (loggedIn && goingToLogin) {
      //   return const HomeRoute().location;
      // }

      // // no need to redirect at all
      // return null;

      final loggedIn = ref.read(authRepositoryProvider).loggedIn;
      // check just the subloc in case there are query parameters
      const loginLoc = '/login';
      final goingToLogin = state.subloc == loginLoc;

      // the user is not logged in and not headed to /login, they need to login
      if (!loggedIn && !goingToLogin) {
        return '/login?from=${state.subloc}';
      }

      // the user is logged in and headed to /login, no need to login again
      if (loggedIn && goingToLogin) {
        return '/';
      }

      // no need to redirect at all
      return null;
    },

    // changes on the listenable will cause the router to refresh it's route
    refreshListenable: ref.watch(authUserStateNotifierProvider),
  ),
);

// @TypedGoRoute<HomeRoute>(
//   path: '/',
//   routes: <TypedGoRoute<GoRouteData>>[
//     TypedGoRoute<FamilyRoute>(
//       path: 'family/:fid',
//       routes: <TypedGoRoute<GoRouteData>>[
//         TypedGoRoute<PersonRoute>(
//           path: 'person/:pid',
//           routes: <TypedGoRoute<GoRouteData>>[
//             TypedGoRoute<PersonDetailsRoute>(path: 'details/:details'),
//           ],
//         ),
//       ],
//     )
//   ],
// )
// class HomeRoute extends GoRouteData {
//   const HomeRoute();

//   @override
//   Widget build(BuildContext context) => const HomeScreen();
// }

// @TypedGoRoute<LoginRoute>(
//   path: '/login',
// )
// class LoginRoute extends GoRouteData {
//   const LoginRoute({this.fromPage});

//   final String? fromPage;

//   @override
//   Widget build(BuildContext context) => LoginScreen(from: fromPage);
// }

// class FamilyRoute extends GoRouteData {
//   const FamilyRoute(this.fid);

//   final String fid;

//   @override
//   Widget build(BuildContext context) => FamilyScreen(family: familyById(fid));
// }

// class PersonRoute extends GoRouteData {
//   const PersonRoute(this.fid, this.pid);

//   final String fid;
//   final int pid;

//   @override
//   Widget build(BuildContext context) {
//     final Family family = familyById(fid);
//     final Person person = family.person(pid);
//     return PersonScreen(family: family, person: person);
//   }
// }

// class PersonDetailsRoute extends GoRouteData {
//   const PersonDetailsRoute(this.fid, this.pid, this.details, {this.$extra});

//   final String fid;
//   final int pid;
//   final PersonDetails details;
//   final int? $extra;

//   @override
//   Page<void> buildPage(BuildContext context) {
//     final Family family = familyById(fid);
//     final Person person = family.person(pid);

//     return MaterialPage<Object>(
//       fullscreenDialog: true,
//       child: PersonDetailsPage(
//         family: family,
//         person: person,
//         detailsKey: details,
//         extra: $extra,
//       ),
//     );
//   }
// }
