const CACHE = 'hlhh-v2';
const ASSETS = ['/', '/index.html', '/manifest.json'];

self.addEventListener('install', e => {
    e.waitUntil(caches.open(CACHE).then(c => c.addAll(ASSETS)));
    self.skipWaiting();
});

self.addEventListener('activate', e => {
    e.waitUntil(caches.keys().then(keys =>
        Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    ));
    self.clients.claim();
});

// Network-first for API calls, cache-first for app shell
self.addEventListener('fetch', e => {
    const url = new URL(e.request.url);
    const isAPI = url.hostname.includes('yahoo') ||
                  url.hostname.includes('polygon') ||
                  url.hostname.includes('corsproxy') ||
                  url.hostname.includes('allorigins') ||
                  url.hostname.includes('unpkg');

    if (isAPI) {
        // Network-first — always try to get fresh data
        e.respondWith(
            fetch(e.request).catch(() => caches.match(e.request))
        );
    } else {
        // Cache-first for app shell
        e.respondWith(
            caches.match(e.request).then(cached => cached || fetch(e.request))
        );
    }
});
