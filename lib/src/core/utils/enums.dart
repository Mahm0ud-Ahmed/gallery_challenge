enum ApiRoute {
  login('auth/login'),
  uploadImg('upload'),
  gallery('my-gallery');

  final String route;

  const ApiRoute(this.route);
}

enum DeviceScreenType { mobile, tablet }

enum ApiRequestType { get, post }
