// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $homeRoute,
      $loginRoute,
    ];

GoRoute get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'family/:fid',
          factory: $FamilyRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'person/:pid',
              factory: $PersonRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'details/:details',
                  factory: $PersonDetailsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $FamilyRouteExtension on FamilyRoute {
  static FamilyRoute _fromState(GoRouterState state) => FamilyRoute(
        state.params['fid']!,
      );

  String get location => GoRouteData.$location(
        '/family/${Uri.encodeComponent(fid)}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $PersonRouteExtension on PersonRoute {
  static PersonRoute _fromState(GoRouterState state) => PersonRoute(
        state.params['fid']!,
        int.parse(state.params['pid']!),
      );

  String get location => GoRouteData.$location(
        '/family/${Uri.encodeComponent(fid)}/person/${Uri.encodeComponent(pid.toString())}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $PersonDetailsRouteExtension on PersonDetailsRoute {
  static PersonDetailsRoute _fromState(GoRouterState state) =>
      PersonDetailsRoute(
        state.params['fid']!,
        int.parse(state.params['pid']!),
        state.params['details']!,
        $extra: state.extra as int?,
      );

  String get location => GoRouteData.$location(
        '/family/${Uri.encodeComponent(fid)}/person/${Uri.encodeComponent(pid.toString())}/details/${Uri.encodeComponent(details)}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute(
        from: state.queryParams['from'],
      );

  String get location => GoRouteData.$location(
        '/login',
        queryParams: {
          if (from != null) 'from': from!,
        },
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}
