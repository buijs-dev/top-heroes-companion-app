flutter clean
flutter pub get
dart run build_runner build
flutter build web --release --base-href '/top-heroes-companion-app/'
dart run dhttpd --path build/web