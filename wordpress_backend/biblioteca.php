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
});

/**
 * Usuario "leyenda" (mycred retroaportes >= 80): puede ver entradas private.
 */
function filmaniak_library_user_is_leyenda($user_id) {
    $user_id = (int) $user_id;
    if ($user_id <= 0) {
        return false;
    }
    if (!function_exists('mycred_display_users_total_balance')) {
        return false;
    }
    $nivel = mycred_display_users_total_balance($user_id, 'mycred_retroaportes');
    return ((float) $nivel) >= 80.0;
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
        case 'modified':
            $order_by = 'modified';
            $order_type = 'DESC';
            break;
        case 'title':
            $order_by = 'title';
            $order_type = 'ASC';
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
    $leyenda = filmaniak_library_user_is_leyenda($viewer_user_id);

    if (!$leyenda) {
        $meta_query[] = [
            'key' => 'private',
            'value' => 'false',
            'compare' => '=',
        ];
    }

    $opcion_busqueda = sanitize_text_field((string) $request->get_param('opcion_busqueda'));
    $texto_busqueda = sanitize_text_field((string) $request->get_param('texto_busqueda'));

    if ($texto_busqueda !== '' && $opcion_busqueda !== '') {
        switch ($opcion_busqueda) {
            case 'title':
                $meta_query[] = [
                    'relation' => 'OR',
                    [
                        'key' => 'ficha_titulo_espanol',
                        'value' => $texto_busqueda,
                        'compare' => 'LIKE',
                    ],
                    [
                        'key' => 'ficha_titulo_original',
                        'value' => $texto_busqueda,
                        'compare' => 'LIKE',
                    ],
                    [
                        'key' => 'ficha_titulos_alternativos',
                        'value' => $texto_busqueda,
                        'compare' => 'LIKE',
                    ],
                ];
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

    $private_param = sanitize_text_field((string) $request->get_param('private'));
    if ($private_param !== '' && $leyenda) {
        $meta_query[] = [
            'key' => 'private',
            'value' => $private_param,
            'compare' => '=',
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
        'leyenda' => $leyenda,
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
            'title' => html_entity_decode(get_the_title(), ENT_QUOTES, 'UTF-8'),
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
        'viewer' => [
            'leyenda' => (bool) $built['leyenda'],
        ],
    ], 200);
}
