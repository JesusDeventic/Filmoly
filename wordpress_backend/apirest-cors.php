<?php
/**
 * CORS delegado a Nginx Proxy Manager.
 *
 * Este snippet SOLO desactiva el CORS nativo de WordPress REST para evitar
 * cabeceras duplicadas (error "multiple Access-Control-Allow-Origin values").
 *
 * Configuración recomendada en Nginx Proxy Manager:
 * 1) Proxy Host -> Advanced: dejar vacío.
 * 2) Proxy Host -> Custom locations:
 *    - Crear location "/"
 *    - Mismo upstream que en Details (scheme/host/port)
 *    - Custom Nginx Configuration:
 *
 *      add_header Access-Control-Allow-Origin "*" always;
 *      add_header Access-Control-Allow-Methods "GET, POST, PUT, PATCH, DELETE, OPTIONS" always;
 *      add_header Access-Control-Allow-Headers "Authorization, Content-Type, X-API-Key, X-Requested-With, Accept, Origin" always;
 *      add_header Access-Control-Expose-Headers "Content-Length, Content-Range" always;
 *      add_header Vary "Origin" always;
 *
 *      if ($request_method = OPTIONS) {
 *          add_header Content-Length 0;
 *          add_header Content-Type text/plain;
 *          return 204;
 *      }
 */
add_action('rest_api_init', function () {
    remove_filter('rest_pre_serve_request', 'rest_send_cors_headers');
});