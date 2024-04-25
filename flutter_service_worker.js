'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "70fc573a350f1b3a5e87cd2de5ee8fa7",
"assets/AssetManifest.bin.json": "feaf1dfbb1449634ce482ea7f9e6c4aa",
"assets/AssetManifest.json": "88af73dfcf5ccf3d72b6b87a786d8940",
"assets/assets/fonts/blyssIcons.ttf": "687eb165316ff7c70d5c212ec76c6201",
"assets/assets/fonts/Roboto-Bold.ttf": "b8e42971dec8d49207a8c8e2b919a6ac",
"assets/assets/fonts/Roboto-Medium.ttf": "68ea4734cf86bd544650aee05137d7bb",
"assets/assets/fonts/Roboto-Regular.ttf": "8a36205bd9b83e03af0591a004bc97f4",
"assets/assets/images/blyss_logo.png": "3e7fdb72b548ff2d5756d4a75257faae",
"assets/assets/images/getting_started/gs_screen1.png": "3043029b052160d2149e91399104499f",
"assets/assets/images/getting_started/gs_screen1_w.png": "6fdd508243a3becd4f80e63ba4a77e42",
"assets/assets/images/getting_started/gs_screen2.png": "73c32fae960c2b4d15f2c1b863424a2b",
"assets/assets/images/getting_started/gs_screen2_w.png": "e1b8c28812f03d9800ba6f17fa3cee63",
"assets/assets/images/getting_started/gs_screen3.png": "f26fe90a46bedac71609db4a348ac094",
"assets/assets/images/getting_started/gs_screen3_w.png": "7b9bc4efaf57500e6852c990cba2fa8a",
"assets/assets/images/products/deluxe_energy_elixir.jpg": "2b160d39d29b4d5af88898ada2f4eb00",
"assets/assets/images/products/gucci_seal_teddy.jpg": "b3fdcbb35f209658937fb3e7e4407033",
"assets/assets/images/products/premium_ball_valve.jpg": "aa9f66fd551bea6a5fe94f11f2362aa0",
"assets/assets/images/products/supreme_porsche_model.jpg": "93a80c39b1a8a86664757dd299d5cf3d",
"assets/assets/images/triangle.png": "5c41d2d821e68c06145e13a34acbbeee",
"assets/assets/models/chair/chair_fabric_albedo.png": "9e166ea3f3fbb560a06342fc94d0a341",
"assets/assets/models/chair/chair_fabric_normal.png": "e09bf3a3cc8024f10dd2f843d8f61e5f",
"assets/assets/models/chair/chair_label.png": "a7d414dba1dc6b298c9082b92f9eede1",
"assets/assets/models/chair/chair_occlusion.png": "80f9ae25f92bc8d7aa122ec3560648a9",
"assets/assets/models/chair/chair_woodblack_roughnessmetallic.png": "00f7a11b53d646f883a9bb74c67ce850",
"assets/assets/models/chair/chair_woodbrown_roughnessmetallic.png": "336605a0e173dea9c0fad93ed856cad5",
"assets/assets/models/chair/chair_wood_albedo.png": "43313300e025fc08c0e3b5fc6a881d9b",
"assets/assets/models/chair/SheenChair.bin": "42bd0ba7f0464999c56038a13e862a81",
"assets/assets/models/chair/SheenChair.gltf": "1a6adce892d32a77c7a7a42e859cd9a0",
"assets/assets/models/Chicken_01/Chicken_01.bin": "c57a219d7d33e867fe4954559630030d",
"assets/assets/models/Chicken_01/Chicken_01.gltf": "85e29d3e9fc06d10dd34db4c6a63874a",
"assets/assets/models/deluxe_energy_elixir/baked_mesh_tex0.png": "7b3e980d58bdec0209740ef7a93bcf39",
"assets/assets/models/deluxe_energy_elixir/deluxe_energy_elixir.bin": "279f4396978706b24a19422c8930555e",
"assets/assets/models/deluxe_energy_elixir/deluxe_energy_elixir.gltf": "f71f9e9568b07bd476e41c70492da179",
"assets/assets/models/gucci_seal_teddy/baseColor_1.png": "edaa099c62906d839f42462f00a38c79",
"assets/assets/models/gucci_seal_teddy/baseColor_2.png": "d945feca5cbaf42fd2fe9264b903f1e0",
"assets/assets/models/gucci_seal_teddy/baseColor_3.png": "60305a8f9fc2a0e238dbb53b9b4c6dcf",
"assets/assets/models/gucci_seal_teddy/baseColor_4.png": "e9e33d5d7da5877bb7a4e9b4de093165",
"assets/assets/models/gucci_seal_teddy/gucci_seal_teddy.bin": "248f3d1434de3d1864615be80e388395",
"assets/assets/models/gucci_seal_teddy/gucci_seal_teddy.gltf": "08145b59726fdc9aec169c1942e8216d",
"assets/assets/models/premium_ball_valve/premium_ball_valve.bin": "23196d73eaafc42619636ab597653211",
"assets/assets/models/premium_ball_valve/premium_ball_valve.gltf": "029ccb5572af7de5927141cca8a96911",
"assets/assets/models/supreme_porsche_model/930_chromes_baseColor.png": "46efb2802288aa8e676c46f78c48705a",
"assets/assets/models/supreme_porsche_model/930_chromes_metallicRoughness.png": "13abc7498282a2900903eb0ff4be8bdd",
"assets/assets/models/supreme_porsche_model/930_lights_baseColor.png": "1f9b933747d1e5fa8c2756c87796c049",
"assets/assets/models/supreme_porsche_model/930_lights_metallicRoughness.png": "1674cb1a2337036a02a45b7ceb57af05",
"assets/assets/models/supreme_porsche_model/930_lights_normal.png": "f875a277aa85696650c5b89a1dd69f05",
"assets/assets/models/supreme_porsche_model/930_plastics_baseColor.png": "435073790bef3bfc5a8e62a23b30bcc5",
"assets/assets/models/supreme_porsche_model/930_plastics_metallicRoughness.png": "2402f0cec52ec68f05871061d0b6d1e4",
"assets/assets/models/supreme_porsche_model/930_rim_baseColor.png": "57ca9aaad5ed2b10b74bf6f65f892fc7",
"assets/assets/models/supreme_porsche_model/930_rim_metallicRoughness.png": "a888fd7a1588e06871d508d580ae4d63",
"assets/assets/models/supreme_porsche_model/930_rim_normal.png": "08e73b6542141fdafa14accaa26a7ada",
"assets/assets/models/supreme_porsche_model/930_stickers_baseColor.png": "eb3b8276dc467987a12a836ad5ad32fb",
"assets/assets/models/supreme_porsche_model/930_tire_baseColor.png": "344801092c428982c071a28e0e7f3191",
"assets/assets/models/supreme_porsche_model/930_tire_metallicRoughness.png": "d867745cda5b0c3259575210b82f5437",
"assets/assets/models/supreme_porsche_model/930_tire_normal.png": "75771f42de0a492e324c946550eee8c4",
"assets/assets/models/supreme_porsche_model/930_wunderbaum_baseColor.png": "0709f5cc910a1eec04386c7eac77b0d9",
"assets/assets/models/supreme_porsche_model/930_wunderbaum_metallicRoughness.png": "3223df21f32011443153d11522f0cd09",
"assets/assets/models/supreme_porsche_model/coat_baseColor.png": "91adc7644153f2a212549cbb3f4aa1ec",
"assets/assets/models/supreme_porsche_model/coat_metallicRoughness.png": "967d0a0923794858478a1faa7f382166",
"assets/assets/models/supreme_porsche_model/glass_baseColor.png": "5319ff62e2aeda8da2c1a7425a85aba2",
"assets/assets/models/supreme_porsche_model/glass_metallicRoughness.png": "4572f7129e231c3e9daa6c60312dd824",
"assets/assets/models/supreme_porsche_model/material_0_baseColor.png": "f6646c97e05c7c063755beaaf983c664",
"assets/assets/models/supreme_porsche_model/paint_clearcoat.png": "25e446f477a4e21c3ce893e39e77b365",
"assets/assets/models/supreme_porsche_model/paint_clearcoat_normal.png": "1f5216fdea688a9b1d36e8e7e34a5b70",
"assets/assets/models/supreme_porsche_model/paint_clearcoat_roughness.png": "967d0a0923794858478a1faa7f382166",
"assets/assets/models/supreme_porsche_model/paint_metallicRoughness.png": "9d050831481451366c6895514bb56fee",
"assets/assets/models/supreme_porsche_model/plate_baseColor.png": "9b23dd5cd5ed8b2489b4c55b970fc3b3",
"assets/assets/models/supreme_porsche_model/plate_normal.png": "85202d00bc473ba0098802916c0f25de",
"assets/assets/models/supreme_porsche_model/scene.bin": "8b23cfaf5e1cde368b765b03e3b8abd5",
"assets/assets/models/supreme_porsche_model/scene.gltf": "1f4f2ea1d9a9ad728faa2d72e71eb03a",
"assets/FontManifest.json": "dce2cb904595ab30d6cdeee731df7896",
"assets/fonts/MaterialIcons-Regular.otf": "e5797cd6923026897cc59f5548bd202d",
"assets/NOTICES": "a50c9956de8ffd04b5cf2f8fd4306214",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "06f6c246bfc12032b8f5f9dbf8591062",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "2290fa28a1e19a2cf00c22996336f293",
"icons/Icon-512.png": "a33cfd942cafb89c0fb5ce12be62cf62",
"icons/Icon-maskable-192.png": "2290fa28a1e19a2cf00c22996336f293",
"icons/Icon-maskable-512.png": "a33cfd942cafb89c0fb5ce12be62cf62",
"index.html": "bd5d427f7bc00892199f82b85b97e41b",
"/": "bd5d427f7bc00892199f82b85b97e41b",
"main.dart.js": "e4e7e7f57f18f7b1a3a71b4949121014",
"manifest.json": "31e8fb0ca0f6e0ef3b865479ecb1d8bd",
"version.json": "24ef23dc45253e87b39c5dc6a1e7ee0e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
