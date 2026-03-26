<?php
/**
 * Filmaniak REST: biblioteca de entradas (misma lógica que el buscador web).
 *
 * Requiere `login.php` cargado antes (filmaniak_auth_validate_token).
 * Registrar este archivo en el plugin / Code Snippets después del auth.
 */

if (!defined('ABSPATH')) {
    exit;
}

add_action('rest_api_init', function () {
    register_rest_route('filmaniak/v1', '/library', [
        'methods' => 'GET',
        'callback' => 'filmaniak_rest_get_library',
        'permission_callback' => '__return_true',
    ]);
    register_rest_route('filmaniak/v1', '/library/(?P<id>\d+)', [
        'methods' => 'GET',
        'callback' => 'filmaniak_rest_get_library_entry',
        'permission_callback' => '__return_true',
    ]);
    register_rest_route('filmaniak/v1', '/library/(?P<id>\d+)/aporte', [
        'methods' => 'GET',
        'callback' => 'filmaniak_rest_get_library_entry_aporte',
        'permission_callback' => '__return_true',
    ]);
});

/**
 * Autentica token y comprueba estado de cuenta activa.
 *
 * @param WP_REST_Request $request
 * @return int|WP_Error
 */
function filmaniak_library_get_active_user_id(WP_REST_Request $request) {
    if (!function_exists('filmaniak_auth_validate_token')) {
        return new WP_Error('auth_not_available', 'Autenticación no disponible.', ['status' => 500]);
    }
    $user_id = filmaniak_auth_validate_token($request);
    if (is_wp_error($user_id)) {
        return $user_id;
    }
    $user_id = (int) $user_id;
    $account_status = get_user_meta($user_id, 'filmaniak_account_status', true) ?: 'active';
    if ($account_status !== 'active') {
        return new WP_Error('account_not_active', 'Cuenta no activa.', ['status' => 403]);
    }
    return $user_id;
}

/**
 * Devuelve términos de una taxonomía como [{id, slug, name}, ...].
 *
 * @param int $post_id
 * @param string $taxonomy
 * @return array<int, array<string, mixed>>
 */
function filmaniak_library_get_terms_payload($post_id, $taxonomy) {
    $terms = get_the_terms((int) $post_id, (string) $taxonomy);
    if (!$terms || is_wp_error($terms)) {
        return [];
    }
    $out = [];
    foreach ($terms as $t) {
        $out[] = [
            'id' => isset($t->term_id) ? (int) $t->term_id : 0,
            'slug' => isset($t->slug) ? (string) $t->slug : '',
            'name' => isset($t->name) ? (string) $t->name : '',
        ];
    }
    return $out;
}

/**
 * Convierte título de rango a nivel numérico.
 *
 * @param string $rank_title
 * @return int
 */
function filmaniak_library_rank_title_to_level($rank_title) {
    switch ((string) $rank_title) {
        case 'Novato': return 1;
        case 'Aficionado': return 2;
        case 'Profesional': return 3;
        case 'Maestro': return 4;
        case 'Leyenda': return 5;
        case 'Titán': return 6;
        default: return 7;
    }
}

/**
 * Usuario habilitado para endpoint de aporte.
 *
 * @param int $user_id
 * @return bool
 */
function filmaniak_library_is_retroteca_user($user_id) {
    return (bool) get_user_meta((int) $user_id, 'filmaniak_retroteca_user', true);
}

/**
 * Resuelve categoría principal por nombre (si existe).
 *
 * @param int $post_id
 * @return string
 */
function filmaniak_library_primary_category_name($post_id) {
    $cats = get_the_terms((int) $post_id, 'category');
    if (!$cats || is_wp_error($cats) || !isset($cats[0])) {
        return '';
    }
    return isset($cats[0]->name) ? (string) $cats[0]->name : '';
}

/**
 * Construye datos generales de una ficha.
 *
 * @param int $post_id
 * @param WP_REST_Request $request
 * @param int $user_id
 * @return array<string, mixed>
 */
function filmaniak_library_build_entry_general_data($post_id, WP_REST_Request $request, $user_id) {
    $post_id = (int) $post_id;
    $title_display_preference = filmaniak_library_get_title_display_preference($request, $user_id);
    $requested_language = filmaniak_library_get_requested_language($request, $user_id);

    $tmdb_id = (string) get_field('ficha_tmdb_id', $post_id);
    $imdb_id = (string) get_field('ficha_imdb_id', $post_id);
    $titulos_alternativos_raw = (string) get_field('ficha_titulos_alternativos', $post_id);
    $ficha_fecha = (string) get_field('ficha_fecha', $post_id);
    $year = '';
    if ($ficha_fecha !== '') {
        $ts = strtotime($ficha_fecha);
        $year = $ts ? gmdate('Y', $ts) : trim($ficha_fecha);
    }

    $category_name = filmaniak_library_primary_category_name($post_id);
    $tmdb_base = 'https://www.themoviedb.org';
    if (in_array($category_name, ['Película', 'Cortometraje', 'Documental'], true)) {
        $tmdb_base .= '/movie/';
    } elseif (in_array($category_name, ['Serie', 'Programa TV'], true)) {
        $tmdb_base .= '/tv/';
    } else {
        $tmdb_base .= '/';
    }
    $tmdb_url = $tmdb_id !== '' ? $tmdb_base . $tmdb_id : '';
    $imdb_url = ($imdb_id !== '' && strtolower($imdb_id) !== 'serie')
        ? 'https://www.imdb.com/title/' . $imdb_id
        : '';

    $alt_lines = preg_split('/\r\n|\r|\n/', $titulos_alternativos_raw);
    $alt_titles = [];
    if (is_array($alt_lines)) {
        foreach ($alt_lines as $line) {
            $clean = trim((string) $line);
            if ($clean !== '') {
                $alt_titles[] = $clean;
            }
        }
    }

    return [
        'id' => $post_id,
        'title' => $title_display_preference === 'original'
            ? html_entity_decode(get_the_title($post_id), ENT_QUOTES, 'UTF-8')
            : filmaniak_library_get_localized_title($post_id, $requested_language),
        'title_original' => html_entity_decode(get_the_title($post_id), ENT_QUOTES, 'UTF-8'),
        'content' => (string) get_post_field('post_content', $post_id),
        'thumbnail_url' => get_the_post_thumbnail_url($post_id, 'large') ?: '',
        'rf_average' => get_post_meta($post_id, 'rf_average', true) !== ''
            ? (float) get_post_meta($post_id, 'rf_average', true)
            : null,
        'rf_total' => get_post_meta($post_id, 'rf_total', true) !== ''
            ? (int) get_post_meta($post_id, 'rf_total', true)
            : 0,
        'ids' => [
            'retro_id' => $post_id,
            'tmdb_id' => $tmdb_id,
            'imdb_id' => $imdb_id,
            'tmdb_url' => $tmdb_url,
            'imdb_url' => $imdb_url,
        ],
        'titles' => [
            'alternatives_raw' => $titulos_alternativos_raw,
            'alternatives' => $alt_titles,
        ],
        'technical' => [
            'year' => $year,
            'duration_minutes' => (int) get_field('ficha_duracion', $post_id),
            'guion' => (string) get_field('ficha_guion', $post_id),
            'musica' => (string) get_field('ficha_musica', $post_id),
            'fotografia' => (string) get_field('ficha_fotografia', $post_id),
        ],
        'taxonomies' => [
            'category' => filmaniak_library_get_terms_payload($post_id, 'category'),
            'post_tag' => filmaniak_library_get_terms_payload($post_id, 'post_tag'),
            'genero' => filmaniak_library_get_terms_payload($post_id, 'genero'),
            'subgenero' => filmaniak_library_get_terms_payload($post_id, 'subgenero'),
            'paises' => filmaniak_library_get_terms_payload($post_id, 'paises'),
            'direccion' => filmaniak_library_get_terms_payload($post_id, 'direccion'),
            'reparto' => filmaniak_library_get_terms_payload($post_id, 'reparto'),
            'productoras' => filmaniak_library_get_terms_payload($post_id, 'productoras'),
        ],
    ];
}

/**
 * Construye datos de aporte para un usuario.
 *
 * @param int $post_id
 * @param int $user_id
 * @return array<string, mixed>|WP_Error
 */
function filmaniak_library_build_entry_aporte_data_for_user($post_id, $user_id) {
    $post_id = (int) $post_id;
    $user_id = (int) $user_id;

    if (!filmaniak_library_is_retroteca_user($user_id)) {
        return new WP_Error('library_aporte_forbidden', 'No tienes acceso al aporte.', ['status' => 403]);
    }

    if ($post_id <= 0 || get_post_type($post_id) !== 'post') {
        return new WP_Error('library_not_found', 'Ficha no encontrada.', ['status' => 404]);
    }

    $required_rank_title = (string) get_field('aporte_rango', $post_id);

    $tipo_aporte = filmaniak_library_primary_category_name($post_id);
    $tickets_download = 10;
    if ($tipo_aporte === 'Serie' || $tipo_aporte === 'Programa TV') {
        $tickets_download = 2;
    } elseif ($tipo_aporte === 'Cortometraje') {
        $tickets_download = 4;
    }
    if ((string) get_field('aporte_modificacion', $post_id) === 'Exclusivo') {
        $tickets_download = $tickets_download * 2;
    }
    $tickets_online = (int) round(($tickets_download / 2), 0, PHP_ROUND_HALF_DOWN);

    $post_author_id = (int) get_post_field('post_author', $post_id);
    $author_login = (string) get_the_author_meta('user_login', $post_author_id);
    $author_display = (string) get_the_author_meta('display_name', $post_author_id);

    return [
        'post_id' => $post_id,
        'author' => [
            'id' => $post_author_id,
            'login' => $author_login,
            'display_name' => $author_display,
        ],
        'aporte' => [
            'calidad' => (string) get_field('aporte_calidad', $post_id),
            'resolucion' => (string) get_field('aporte_resolucion', $post_id),
            'tamano_mb' => (int) get_field('aporte_tamano', $post_id),
            'audio' => (string) get_field('aporte_audio', $post_id),
            'subtitulos' => (string) get_field('aporte_subtitulos', $post_id),
            'modificacion' => (string) get_field('aporte_modificacion', $post_id),
            'rango_necesario' => $required_rank_title,
            'info' => (string) get_field('aporte_info', $post_id),
            'tickets_descarga' => $tickets_download,
            'tickets_online' => $tickets_online,
        ],
    ];
}

/**
 * GET /library/{id}
 *
 * @param WP_REST_Request $request
 * @return WP_REST_Response|WP_Error
 */
function filmaniak_rest_get_library_entry(WP_REST_Request $request) {
    $user_id = filmaniak_library_get_active_user_id($request);
    if (is_wp_error($user_id)) {
        return $user_id;
    }
    $post_id = (int) $request->get_param('id');
    if ($post_id <= 0 || get_post_type($post_id) !== 'post') {
        return new WP_Error('library_not_found', 'Ficha no encontrada.', ['status' => 404]);
    }

    $data = filmaniak_library_build_entry_general_data($post_id, $request, (int) $user_id);
    return new WP_REST_Response([
        'success' => true,
        'entry' => $data,
    ], 200);
}

/**
 * GET /library/{id}/aporte
 *
 * @param WP_REST_Request $request
 * @return WP_REST_Response|WP_Error
 */
function filmaniak_rest_get_library_entry_aporte(WP_REST_Request $request) {
    $user_id = filmaniak_library_get_active_user_id($request);
    if (is_wp_error($user_id)) {
        return $user_id;
    }
    $post_id = (int) $request->get_param('id');
    $data = filmaniak_library_build_entry_aporte_data_for_user($post_id, (int) $user_id);
    if (is_wp_error($data)) {
        return $data;
    }
    return new WP_REST_Response([
        'success' => true,
        'entry_aporte' => $data,
    ], 200);
}

/**
 * Busca IDs de posts por texto en:
 * - post_title
 * - ID interno del post (si el texto es numérico)
 * - ficha_titulos_alternativos
 *
 * @param string $texto
 * @return int[]
 */
function filmaniak_library_find_ids_for_text_search($texto) {
    global $wpdb;

    $texto = trim((string) $texto);
    if ($texto === '') {
        return [];
    }

    $like = '%' . $wpdb->esc_like($texto) . '%';
    $internal_post_id = ctype_digit($texto) ? (int) $texto : 0;

    $exact_id_matches = [];
    if ($internal_post_id > 0) {
        $exact_id_matches = $wpdb->get_col(
            $wpdb->prepare(
                "SELECT ID
                 FROM {$wpdb->posts}
                 WHERE post_type = %s
                   AND post_status = %s
                   AND ID = %d",
                'post',
                'publish',
                $internal_post_id
            )
        );
    }

    $title_ids = $wpdb->get_col(
        $wpdb->prepare(
            "SELECT ID
             FROM {$wpdb->posts}
             WHERE post_type = %s
               AND post_status = %s
               AND post_title LIKE %s",
            'post',
            'publish',
            $like
        )
    );

    $meta_ids = $wpdb->get_col(
        $wpdb->prepare(
            "SELECT DISTINCT p.ID
             FROM {$wpdb->posts} p
             INNER JOIN {$wpdb->postmeta} pm ON pm.post_id = p.ID
             WHERE p.post_type = %s
               AND p.post_status = %s
               AND pm.meta_key IN ('ficha_titulos_alternativos')
               AND pm.meta_value LIKE %s",
            'post',
            'publish',
            $like
        )
    );

    $merged = array_merge(
        is_array($exact_id_matches) ? $exact_id_matches : [],
        is_array($title_ids) ? $title_ids : [],
        is_array($meta_ids) ? $meta_ids : []
    );

    $merged = array_values(array_unique(array_map('intval', $merged)));
    return $merged;
}

/**
 * Obtiene idioma solicitado para títulos localizados.
 * Prioridad: query `language` > header `Accept-Language` > idioma del usuario.
 * Si no hay idioma usable, devolvemos vacío y se usa título original.
 *
 * @param WP_REST_Request $request
 * @param int $user_id
 * @return string
 */
function filmaniak_library_get_requested_language(WP_REST_Request $request, $user_id) {
    $lang = sanitize_text_field((string) $request->get_param('language'));
    if ($lang === '') {
        $accept = (string) $request->get_header('accept-language');
        if ($accept !== '') {
            $parts = explode(',', $accept);
            $first = trim((string) ($parts[0] ?? ''));
            $lang = $first;
        }
    }
    if ($lang === '' && (int) $user_id > 0) {
        $lang = (string) get_user_meta((int) $user_id, 'filmaniak_language', true);
    }
    $lang = strtolower(str_replace('_', '-', trim($lang)));
    if ($lang === '') {
        return '';
    }
    // Nos quedamos con la parte de idioma base (ej. es-ES -> es).
    $chunks = explode('-', $lang);
    $base = trim((string) ($chunks[0] ?? ''));
    return $base !== '' ? $base : '';
}

/**
 * Preferencia de visualización del título.
 * - localized: intenta título en idioma del usuario
 * - original: usa siempre post_title
 *
 * Prioridad: query `title_display_preference` > usermeta.
 *
 * @param WP_REST_Request $request
 * @param int $user_id
 * @return string
 */
function filmaniak_library_get_title_display_preference(WP_REST_Request $request, $user_id) {
    $preference = sanitize_text_field((string) $request->get_param('title_display_preference'));
    if ($preference === '' && (int) $user_id > 0) {
        $preference = (string) get_user_meta((int) $user_id, 'filmaniak_title_display_preference', true);
    }
    if (!in_array($preference, ['localized', 'original'], true)) {
        return 'localized';
    }
    return $preference;
}

/**
 * Mapea idioma -> posibles códigos de país en títulos alternativos TMDB (iso_3166_1).
 *
 * @param string $lang
 * @return string[]
 */
function filmaniak_library_country_candidates_for_language($lang) {
    $lang = strtolower(trim((string) $lang));
    switch ($lang) {
        case 'es': return ['ES', 'MX', 'AR'];
        case 'en': return ['US', 'GB', 'CA', 'AU'];
        case 'pt': return ['PT', 'BR'];
        case 'ca': return ['ES'];
        case 'zh': return ['CN', 'TW', 'HK'];
        case 'ar': return ['SA', 'AE', 'EG'];
        case 'de': return ['DE', 'AT', 'CH'];
        case 'fr': return ['FR', 'CA', 'BE', 'CH'];
        case 'it': return ['IT', 'CH'];
        case 'ja': return ['JP'];
        case 'ko': return ['KR'];
        case 'nl': return ['NL', 'BE'];
        case 'pl': return ['PL'];
        case 'ro': return ['RO'];
        case 'ru': return ['RU', 'UA'];
        case 'sv': return ['SE'];
        case 'tr': return ['TR'];
        case 'uk': return ['UA'];
        case 'hi': return ['IN'];
        case 'id': return ['ID'];
        default:
            $upper = strtoupper($lang);
            return $upper !== '' ? [$upper] : [];
    }
}

/**
 * Normaliza título para comparaciones flexibles.
 *
 * @param string $title
 * @return string
 */
function filmaniak_library_normalize_title_for_compare($title) {
    $title = remove_accents((string) $title);
    $title = strtolower(trim($title));
    $title = preg_replace('/[^a-z0-9]+/i', '', $title);
    return (string) $title;
}

/**
 * Intenta resolver título localizado desde `ficha_titulos_alternativos` por idioma del usuario.
 *
 * Formato esperado por línea: `Título (ES)`
 *
 * @param int $post_id
 * @param string $lang
 * @return string
 */
function filmaniak_library_get_localized_title($post_id, $lang) {
    $fallback_title = html_entity_decode(get_the_title($post_id), ENT_QUOTES, 'UTF-8');
    $alternatives_raw = (string) get_post_meta($post_id, 'ficha_titulos_alternativos', true);
    if ($alternatives_raw === '') {
        return $fallback_title;
    }

    $wanted = filmaniak_library_country_candidates_for_language($lang);
    if (empty($wanted)) {
        return $fallback_title;
    }
    $wanted_lookup = array_fill_keys($wanted, true);

    $lines = preg_split('/\r\n|\r|\n/', $alternatives_raw);
    if (!is_array($lines) || empty($lines)) {
        return $fallback_title;
    }

    $matches = [];
    foreach ($lines as $line) {
        $line = trim((string) $line);
        if ($line === '') {
            continue;
        }
        if (preg_match('/^(.*?)\s*\(([A-Za-z]{2}(?:-[A-Za-z]{2})?)\)\s*$/', $line, $m) !== 1) {
            continue;
        }
        $title = trim((string) ($m[1] ?? ''));
        $country_or_locale = strtoupper(trim((string) ($m[2] ?? '')));
        if ($title === '' || $country_or_locale === '') {
            continue;
        }
        $country = explode('-', $country_or_locale)[0];
        if (isset($wanted_lookup[$country])) {
            $matches[] = html_entity_decode($title, ENT_QUOTES, 'UTF-8');
        }
    }

    if (empty($matches)) {
        return $fallback_title;
    }

    // Si hay una alternativa casi idéntica al título original (post_title),
    // la priorizamos para evitar traducciones "agresivas" en idiomas como inglés.
    $fallback_norm = filmaniak_library_normalize_title_for_compare($fallback_title);
    if ($fallback_norm !== '') {
        foreach ($matches as $candidate) {
            if (filmaniak_library_normalize_title_for_compare($candidate) === $fallback_norm) {
                return $candidate;
            }
        }

        $best_candidate = '';
        $best_score = null;
        foreach ($matches as $candidate) {
            $candidate_norm = filmaniak_library_normalize_title_for_compare($candidate);
            if ($candidate_norm === '') {
                continue;
            }
            $score = levenshtein($candidate_norm, $fallback_norm);
            if ($best_score === null || $score < $best_score) {
                $best_score = $score;
                $best_candidate = $candidate;
            }
        }

        if ($best_candidate !== '') {
            return $best_candidate;
        }
    }

    // Fallback: primer candidato por idioma/país.
    return (string) $matches[0];
}

/**
 * @param WP_REST_Request $request
 * @return array<string, mixed>
 */
function filmaniak_library_build_query_args(WP_REST_Request $request, $viewer_user_id) {
    $order_by = 'date';
    $order_type = 'DESC';
    $meta_key = null;
    $meta_type = null;

    $orderby_param = sanitize_text_field((string) $request->get_param('orderby'));
    if ($orderby_param === '') {
        $orderby_param = 'date';
    }

    switch ($orderby_param) {
        case 'date':
            $order_by = 'date';
            $order_type = 'DESC';
            break;
        case 'date_asc':
            $order_by = 'date';
            $order_type = 'ASC';
            break;
        case 'modified':
            $order_by = 'modified';
            $order_type = 'DESC';
            break;
        case 'modified_asc':
            $order_by = 'modified';
            $order_type = 'ASC';
            break;
        case 'title':
            $order_by = 'title';
            $order_type = 'ASC';
            break;
        case 'title_desc':
            $order_by = 'title';
            $order_type = 'DESC';
            break;
        case 'ficha_fecha_asc':
            $order_by = 'meta_value_num';
            $meta_key = 'ficha_fecha';
            $order_type = 'ASC';
            $meta_type = 'NUMERIC';
            break;
        case 'ficha_fecha_desc':
            $order_by = 'meta_value_num';
            $meta_key = 'ficha_fecha';
            $order_type = 'DESC';
            $meta_type = 'NUMERIC';
            break;
        case 'rf_average_asc':
            $order_by = 'meta_value_num';
            $meta_key = 'rf_average';
            $order_type = 'ASC';
            $meta_type = 'NUMERIC';
            break;
        case 'rf_average_desc':
            $order_by = 'meta_value_num';
            $meta_key = 'rf_average';
            $order_type = 'DESC';
            $meta_type = 'NUMERIC';
            break;
        case 'rf_total':
            $order_by = 'meta_value_num';
            $meta_key = 'rf_total';
            $order_type = 'DESC';
            $meta_type = 'NUMERIC';
            break;
        default:
            $order_by = 'date';
            $order_type = 'DESC';
            break;
    }

    $page = max(1, (int) $request->get_param('page'));
    if ($page < 1) {
        $page = 1;
    }
    $per_page = (int) $request->get_param('per_page');
    if ($per_page < 1) {
        $per_page = 24;
    }
    $per_page = min(128, $per_page);

    $args = [
        'post_type' => 'post',
        'posts_per_page' => $per_page,
        'paged' => $page,
        'post_status' => 'publish',
        'orderby' => $order_by,
        'order' => $order_type,
    ];

    if ($meta_key !== null && $meta_key !== '') {
        $args['meta_key'] = $meta_key;
        if ($meta_type !== null) {
            $args['meta_type'] = $meta_type;
        }
    }

    $meta_query = ['relation' => 'AND'];
    $tax_query = [];

    $opcion_busqueda = sanitize_text_field((string) $request->get_param('opcion_busqueda'));
    $texto_busqueda = sanitize_text_field((string) $request->get_param('texto_busqueda'));

    if ($texto_busqueda !== '' && $opcion_busqueda !== '') {
        switch ($opcion_busqueda) {
            case 'title':
                $matching_ids = filmaniak_library_find_ids_for_text_search($texto_busqueda);
                $args['post__in'] = !empty($matching_ids) ? $matching_ids : [0];
                break;
            case 'direccion':
            case 'reparto':
            case 'productoras':
                $term_ids = get_terms([
                    'taxonomy' => $opcion_busqueda,
                    'name__like' => $texto_busqueda,
                    'fields' => 'ids',
                    'hide_empty' => false,
                ]);
                if (is_wp_error($term_ids)) {
                    $term_ids = [];
                }
                if (!empty($term_ids)) {
                    $tax_query[] = [
                        'taxonomy' => $opcion_busqueda,
                        'field' => 'term_id',
                        'terms' => array_map('intval', $term_ids),
                    ];
                } else {
                    $tax_query[] = [
                        'taxonomy' => $opcion_busqueda,
                        'field' => 'term_id',
                        'terms' => [0],
                    ];
                }
                break;
            case 'other_person':
                $meta_query[] = [
                    'relation' => 'OR',
                    [
                        'key' => 'ficha_guion',
                        'value' => $texto_busqueda,
                        'compare' => 'LIKE',
                    ],
                    [
                        'key' => 'ficha_musica',
                        'value' => $texto_busqueda,
                        'compare' => 'LIKE',
                    ],
                    [
                        'key' => 'ficha_fotografia',
                        'value' => $texto_busqueda,
                        'compare' => 'LIKE',
                    ],
                ];
                break;
            case 'tmdb_id':
                $meta_query[] = [
                    'key' => 'ficha_tmdb_id',
                    'value' => $texto_busqueda,
                    'compare' => 'LIKE',
                ];
                break;
            case 'imdb_id':
                $meta_query[] = [
                    'key' => 'ficha_imdb_id',
                    'value' => $texto_busqueda,
                    'compare' => 'LIKE',
                ];
                break;
        }
    }

    $categoria = sanitize_text_field((string) $request->get_param('categoria'));
    if ($categoria !== '') {
        $args['category_name'] = $categoria;
    }

    $estilo = sanitize_text_field((string) $request->get_param('estilo'));
    if ($estilo !== '') {
        $tax_query[] = [
            'taxonomy' => 'post_tag',
            'field' => 'slug',
            'terms' => $estilo,
        ];
    }

    $genero = sanitize_text_field((string) $request->get_param('genero'));
    if ($genero !== '') {
        $tax_query[] = [
            'taxonomy' => 'genero',
            'field' => 'slug',
            'terms' => $genero,
        ];
    }

    $subgenero = sanitize_text_field((string) $request->get_param('subgenero'));
    if ($subgenero !== '') {
        $tax_query[] = [
            'taxonomy' => 'subgenero',
            'field' => 'slug',
            'terms' => $subgenero,
        ];
    }

    $saga_grupo = sanitize_text_field((string) $request->get_param('saga_grupo'));
    if ($saga_grupo !== '') {
        $tax_query[] = [
            'taxonomy' => 'saga_grupo',
            'field' => 'slug',
            'terms' => $saga_grupo,
        ];
    }

    $year_min = $request->get_param('year_min');
    $year_max = $request->get_param('year_max');
    $anio_min_filter = ($year_min !== null && $year_min !== '') ? (int) $year_min : 1890;
    $anio_max_filter = ($year_max !== null && $year_max !== '') ? (int) $year_max : (int) gmdate('Y');
    $current_year = (int) gmdate('Y');
    if (($anio_min_filter > 1890 || $anio_max_filter < $current_year) && $anio_min_filter <= $anio_max_filter) {
        $meta_query[] = [
            'key' => 'ficha_fecha',
            'value' => [$anio_min_filter, $anio_max_filter],
            'type' => 'NUMERIC',
            'compare' => 'BETWEEN',
        ];
    }

    $pais = sanitize_text_field((string) $request->get_param('pais'));
    if ($pais !== '') {
        $tax_query[] = [
            'taxonomy' => 'paises',
            'field' => 'slug',
            'terms' => $pais,
        ];
    }

    $calidad = sanitize_text_field((string) $request->get_param('calidad'));
    if ($calidad !== '' && $viewer_user_id > 0) {
        $meta_query[] = [
            'key' => 'aporte_calidad',
            'value' => $calidad,
            'compare' => '=',
        ];
    }

    $rango = sanitize_text_field((string) $request->get_param('rango'));
    if ($rango !== '' && $viewer_user_id > 0) {
        $meta_query[] = [
            'key' => 'aporte_rango',
            'value' => $rango,
            'compare' => '=',
        ];
    }

    $usuario = $request->get_param('usuario');
    if ($usuario !== null && $usuario !== '' && $viewer_user_id > 0) {
        $args['author'] = absint($usuario);
    }

    $ficha_tmdb_empty = sanitize_text_field((string) $request->get_param('ficha_tmdb_id'));
    if ($ficha_tmdb_empty === 'empty') {
        $meta_query[] = [
            'key' => 'ficha_tmdb_id',
            'compare' => 'NOT EXISTS',
        ];
    }

    // Solo si hay al menos una clausa además de 'relation'.
    if (count($meta_query) > 1) {
        $args['meta_query'] = $meta_query;
    }

    if (!empty($tax_query)) {
        if (count($tax_query) > 1) {
            $args['tax_query'] = array_merge(['relation' => 'AND'], array_values($tax_query));
        } else {
            $args['tax_query'] = [$tax_query[0]];
        }
    }

    return [
        'wp_query_args' => $args,
        'page' => $page,
        'per_page' => $per_page,
    ];
}

/**
 * @param WP_REST_Request $request
 * @return WP_REST_Response|WP_Error
 */
function filmaniak_rest_get_library(WP_REST_Request $request) {
    if (!function_exists('filmaniak_auth_validate_token')) {
        return new WP_Error('auth_not_available', 'Autenticación no disponible.', ['status' => 500]);
    }

    $user_id = filmaniak_auth_validate_token($request);
    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $user_id = (int) $user_id;
    $account_status = get_user_meta($user_id, 'filmaniak_account_status', true) ?: 'active';
    if ($account_status !== 'active') {
        return new WP_Error('account_not_active', 'Cuenta no activa.', ['status' => 403]);
    }

    $built = filmaniak_library_build_query_args($request, $user_id);
    $args = $built['wp_query_args'];
    $title_display_preference = filmaniak_library_get_title_display_preference($request, $user_id);
    $requested_language = filmaniak_library_get_requested_language($request, $user_id);

    $query = new WP_Query($args);

    $posts_out = [];
    while ($query->have_posts()) {
        $query->the_post();
        $post_id = get_the_ID();

        $thumb = get_the_post_thumbnail_url($post_id, 'medium');
        if (!$thumb) {
            $thumb = '';
        }

        $ficha_fecha = get_post_meta($post_id, 'ficha_fecha', true);
        $year = '';
        if (is_string($ficha_fecha) && $ficha_fecha !== '') {
            $ts = strtotime($ficha_fecha);
            $year = $ts ? gmdate('Y', $ts) : '';
        }

        $rf_average = get_post_meta($post_id, 'rf_average', true);

        // Director (taxonomy: direccion)
        $director = '';
        $director_terms = get_the_terms($post_id, 'direccion');
        if ($director_terms && !is_wp_error($director_terms)) {
            $names = [];
            foreach ($director_terms as $t) {
                $name = isset($t->name) ? (string) $t->name : '';
                if ($name !== '') {
                    $names[] = $name;
                }
            }
            $director = implode(', ', $names);
        }

        // País (taxonomy: paises) -> devolvemos slugs ISO para que la app
        // traduzca al idioma del usuario con country_picker.
        $pais = '';
        $pais_terms = get_the_terms($post_id, 'paises');
        if ($pais_terms && !is_wp_error($pais_terms)) {
            $codes = [];
            foreach ($pais_terms as $t) {
                $slug = isset($t->slug) ? strtolower((string) $t->slug) : '';
                if ($slug !== '') {
                    $codes[] = $slug;
                }
            }
            $pais = implode(',', $codes);
        }

        $posts_out[] = [
            'id' => $post_id,
            'title' => $title_display_preference === 'original'
                ? html_entity_decode(get_the_title($post_id), ENT_QUOTES, 'UTF-8')
                : filmaniak_library_get_localized_title($post_id, $requested_language),
            'thumbnail_url' => $thumb,
            'year' => $year,
            'rf_average' => $rf_average !== '' && $rf_average !== null ? (float) $rf_average : null,
            'director' => $director,
            'pais' => $pais,
        ];
    }
    wp_reset_postdata();

    $total = (int) $query->found_posts;
    $total_pages = (int) $query->max_num_pages;

    return new WP_REST_Response([
        'success' => true,
        'posts' => $posts_out,
        'pagination' => [
            'total' => $total,
            'total_pages' => $total_pages,
            'page' => $built['page'],
            'per_page' => $built['per_page'],
        ],
    ], 200);
}
