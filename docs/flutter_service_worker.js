'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "1cd7676805357f14ff577791630607dd",
"/": "1cd7676805357f14ff577791630607dd",
"version.json": "086fc57ded0069964e5ef53313d5a8a8",
"favicon.png": "0d84db161ba6273cb9dcf106d5789fa3",
"manifest.json": "46b631fda72251aa3100f870add40085",
"icons/android-icon-48x48.png": "e74d8bd8567c9761b543b313dff1da56",
"icons/android-icon-96x96.png": "117c452a03aab6b0841d1170288ae8c8",
"icons/apple-icon-57x57.png": "a5008e29eccd14a92118bbdedb90a07b",
"icons/apple-icon-60x60.png": "5a237c87040252a2a7686334c92df6e3",
"icons/ms-icon-150x150.png": "97d82883cfcbd9537dd53643d5c024c0",
"icons/apple-icon-180x180.png": "a5af033b39fd832dac5edca99edbb71f",
"icons/android-icon-144x144.png": "02344839e3f12bb249f216fe6300bcb9",
"icons/apple-icon.png": "9f1a862afb8dda7a839b67ba1b6ec7d3",
"icons/apple-icon-152x152.png": "c0eddcd5e7839aaddfbdca48674e292a",
"icons/favicon-32x32.png": "271b91ecc363e7e3eecff9e29609ece5",
"icons/apple-icon-114x114.png": "5eee45a78b12b2a2cee8d3bcf097f90d",
"icons/android-icon-72x72.png": "ce1bebb97a98146802e5ed64c3f62c10",
"icons/favicon.ico": "d705fbdd16e2c2b2729f921e04f67456",
"icons/favicon-16x16.png": "4b8c7cf31e356596e926c6e39cba1370",
"icons/ms-icon-144x144.png": "23679252db16cc7f8a005cd0b4779c99",
"icons/apple-icon-76x76.png": "c9301ded06de075c0908ff3bbe309e5e",
"icons/apple-icon-precomposed.png": "9f1a862afb8dda7a839b67ba1b6ec7d3",
"icons/ms-icon-310x310.png": "2589166883bde9c1b7163d764e467931",
"icons/apple-icon-72x72.png": "ce1bebb97a98146802e5ed64c3f62c10",
"icons/android-icon-192x192.png": "bbe7ec97f3ea369b8284eda01c98a398",
"icons/favicon-96x96.png": "a038c1b6f716bd15c2a9a8328e4d173a",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/apple-icon-120x120.png": "9afab21d2298f0da64ebfbc28cd96b1e",
"icons/launcher_original.png": "85e49b05aea4a98ddc5166e00b69e21a",
"icons/android-icon-36x36.png": "ef48e87369c494dad19ca5f359dc87a6",
"icons/apple-icon-144x144.png": "23679252db16cc7f8a005cd0b4779c99",
"icons/ms-icon-70x70.png": "ac6d0176b0bdefed19e2b7be48bd4b1c",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/NOTICES": "33ea8f6b072f82ecb2a1a272b54f5a17",
"assets/assets/launcher_without_border_360.png": "a2dfdddcd40272879899c7c0de8bf2a3",
"assets/assets/banner_500.png": "af79f78af2c5179e58df1d017b34ddbf",
"assets/assets/logo.jpg": "9f4565bb1241d26ffd92bb3d7495daab",
"assets/assets/launcher_500.png": "85e49b05aea4a98ddc5166e00b69e21a",
"assets/AssetManifest.json": "f16809828307b6f88b65ce88dac86bf0",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"main.dart.js": "a78d04610402c12f0dcd691a58eba771"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
