'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "0af9743f33413c5b4f122edf236aa16c",
"version.json": "87b1d73e4285b87e5556c838540c2ee0",
"index.html": "d0bcc5a1e6b8135ed8a6ac503071c9c0",
"/": "d0bcc5a1e6b8135ed8a6ac503071c9c0",
"main.dart.js": "edc2ca2c4102fbe4c25f36260e7ffb6e",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "ca028769906b5024f6ca8d61a26dce0a",
"icons/Icon-192.png": "dd29c4afd7c8fbc1952d3416fd7faffb",
"icons/Icon-maskable-192.png": "dd29c4afd7c8fbc1952d3416fd7faffb",
"icons/Icon-maskable-512.png": "4324ca697dc1decbbb4c3e39126b2f72",
"icons/Icon-512.png": "4324ca697dc1decbbb4c3e39126b2f72",
"manifest.json": "e20e67d3f10ebcd9bf5f1d3577f0bdf2",
"assets/AssetManifest.json": "47dcf2cc5019d59eacd629d0a353905c",
"assets/NOTICES": "b8be670235e0fe7a1a0d38797ff6b0c0",
"assets/FontManifest.json": "355ed0ad63ab873c8b97a42abc967366",
"assets/AssetManifest.bin.json": "7784739ee277841fb703c21f7b0306b0",
"assets/packages/fluttericon/lib/fonts/Octicons.ttf": "7242d2fe9e36eb4193d2bc7e521779bf",
"assets/packages/fluttericon/lib/fonts/Maki.ttf": "9ecdcd7d24a2461a55d532b86b2740bd",
"assets/packages/fluttericon/lib/fonts/Brandico.ttf": "791921e9b25210e2551b6eda3f86c733",
"assets/packages/fluttericon/lib/fonts/Entypo.ttf": "58edfaf27b1032ea4778b69297c02b5a",
"assets/packages/fluttericon/lib/fonts/Fontelico.ttf": "3a1e1cecf0a3eae6be5cba3677379ba2",
"assets/packages/fluttericon/lib/fonts/Iconic.ttf": "34e12214307f5f7cf7bc62086fbf55a3",
"assets/packages/fluttericon/lib/fonts/LineariconsFree.ttf": "276b1d61e45eb9b2dde9482545d9e3ac",
"assets/packages/fluttericon/lib/fonts/RpgAwesome.ttf": "99232001effca5cf2b5aa92cc3f3e892",
"assets/packages/fluttericon/lib/fonts/Typicons.ttf": "3386cae1128e52caf268508d477fb660",
"assets/packages/fluttericon/lib/fonts/FontAwesome.ttf": "799bb4e5c577847874f20bd0e9b38a9d",
"assets/packages/fluttericon/lib/fonts/Zocial.ttf": "c29d6e34d8f703a745c6f18d94ce316d",
"assets/packages/fluttericon/lib/fonts/WebSymbols.ttf": "4fd66aa74cdc6e5eaff0ec916ac269c6",
"assets/packages/fluttericon/lib/fonts/Linecons.ttf": "2d0ac407ed11860bf470cb01745fb144",
"assets/packages/fluttericon/lib/fonts/FontAwesome5.ttf": "221b27a41202ddd33990e299939e4504",
"assets/packages/fluttericon/lib/fonts/Elusive.ttf": "23f24df0388819e94db2b3c19841841c",
"assets/packages/fluttericon/lib/fonts/MfgLabs.ttf": "09daa533ea11600a98e3148b7531afe3",
"assets/packages/fluttericon/lib/fonts/Meteocons.ttf": "8b9c7982496155bb39c67eaf2a243731",
"assets/packages/fluttericon/lib/fonts/ModernPictograms.ttf": "5046c536516be5b91c15eb7795e0352d",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ecfb26941bde0365b034b4ab3933f261",
"assets/fonts/MaterialIcons-Regular.otf": "5704f22bce2242655d727d56ac08abed",
"assets/assets/database/classes.yaml": "6a0b989133d864c7563897002ee92f56",
"assets/assets/database/rarities.yaml": "0e8ca0a537e5c45872cc236103cc08ba",
"assets/assets/database/characters.yaml": "e4d9205850e23bd035387c64aa093933",
"assets/assets/database/factions.yaml": "e91a45d50c13e94da48b214e79910b2f",
"assets/assets/database/bonds.yaml": "0d1ee401846303760d18cea3c8b25098",
"assets/assets/database/skills.yaml": "61e87086b584e7f440c131158eb08c14",
"assets/assets/images/top_heroes_logo.png": "648aedaf03955b1b71eb04ecf2da2440",
"assets/assets/images/heroes/39.webp": "cf7a04330d71543a161dea64498d73c8",
"assets/assets/images/heroes/35.webp": "3d235d2689dede1b4e32c58c849733de",
"assets/assets/images/heroes/23.webp": "ee850c63529afd398d22904f4e94393e",
"assets/assets/images/heroes/43.webp": "9f59903dbb6f2418e4f37d0d1cf9f806",
"assets/assets/images/heroes/33.webp": "046b525fa72b28111718ed4135042cd0",
"assets/assets/images/heroes/25.webp": "9ef2e3be12b376e36f865ed2398cf10b",
"assets/assets/images/heroes/29.webp": "04aaf208aab133e3c9b9b6da1a70e07b",
"assets/assets/images/heroes/28.webp": "b39466d63094959a51f84b89a3283b27",
"assets/assets/images/heroes/27.webp": "83afa795eecb9a7e3864164c5d8a8694",
"assets/assets/images/heroes/31.webp": "fae2b756f33716d0c415c99e831c1089",
"assets/assets/images/heroes/30.webp": "ce86855d5d6ecfe8856b02bd9b0dde2e",
"assets/assets/images/heroes/26.webp": "a4fdb544b001f1c7cccc557df06376eb",
"assets/assets/images/heroes/21.webp": "c21d484d4548c7ede705aed0095721dd",
"assets/assets/images/heroes/37.webp": "6bae865c3e1da2c0dbf04d59c64e4363",
"assets/assets/images/heroes/36.webp": "3034947d90115a0f8d79b30d1a3d59b2",
"assets/assets/images/heroes/20.webp": "fa4902aec8ebce5a54413bdb40f4b118",
"assets/assets/images/heroes/16.webp": "79c937c1cff1f9fd34f7bc90f892ade3",
"assets/assets/images/heroes/41.webp": "96f2bcddd80589b4f01e08e123497b65",
"assets/assets/images/top_heroes_banner.png": "fcd0938aa3028c6ccdcbfd6d610f8dd8",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
