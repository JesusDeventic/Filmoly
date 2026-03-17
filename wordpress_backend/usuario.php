/**
 * Filmoly Update User Endpoint
 */

if (!defined('ABSPATH')) {
    exit;
}

// Importante para subida de archivos y attachments
require_once ABSPATH . 'wp-admin/includes/file.php';
require_once ABSPATH . 'wp-admin/includes/image.php';
require_once ABSPATH . 'wp-admin/includes/media.php';

/**
 * =========================================================
 * ENDPOINT
 * =========================================================
 */
add_action('rest_api_init', function () {
    register_rest_route('filmoly/v1', '/user/update', [
        'methods' => 'POST',
        'callback' => 'filmoly_update_user',
        'permission_callback' => '__return_true',
    ]);
});

/**
 * =========================================================
 * HELPERS
 * =========================================================
 */
function filmoly_get_full_user_data($user_id) {
    $user = get_userdata($user_id);

    if (!$user) {
        return null;
    }

    $retroteca_vip = get_user_meta($user->ID, 'filmoly_retroteca_vip', false);
    $retroteca_vip = ($retroteca_vip === '') ? 1 : $retroteca_vip;

    return [
        'id' => (int) $user->ID,
        'username' => $user->user_login,
        'user_email' => $user->user_email,
        'display_name' => $user->display_name,
        'user_registered' => $user->user_registered,
        'description' => $user->description ?: '',
        'avatar_url' => function_exists('filmoly_get_user_avatar_url')
            ? filmoly_get_user_avatar_url($user->ID)
            : get_avatar_url($user->ID),
        'language' => get_user_meta($user->ID, 'filmoly_language', true) ?: 'es',
        'start_day_week' => get_user_meta($user->ID, 'filmoly_start_day_week', true) ?: 'monday',
        'date_format' => get_user_meta($user->ID, 'filmoly_date_format', true) ?: 'dd/MM/yyyy',
        'country' => get_user_meta($user->ID, 'filmoly_country', true) ?: '',
        'birthdate' => get_user_meta($user->ID, 'filmoly_birthdate', true) ?: '',
        'filmoly_retroteca_vip' => (bool) $retroteca_vip,
        'marketing_consent' => (bool) get_user_meta($user->ID, 'filmoly_marketing_consent', true),
        'account_status' => get_user_meta($user->ID, 'filmoly_account_status', true) ?: 'active',
		'filmoly_last_login' => get_user_meta($user->ID, 'filmoly_last_login', true) ?: '',
		'filmoly_review_status' => get_user_meta($user->ID, 'filmoly_review_status', true) ?: 'none',
		'filmoly_review_prompted_at' => get_user_meta($user->ID, 'filmoly_review_prompted_at', true) ?: '',
		'account_status' => get_user_meta($user->ID, 'filmoly_account_status', true) ?: 'active',
    ];
}

function filmoly_normalize_birthdate($raw_date) {
    $raw_date = trim((string) $raw_date);

    if ($raw_date === '') {
        return '';
    }

    $date_obj = DateTime::createFromFormat('Y-m-d', $raw_date);
    if ($date_obj && $date_obj->format('Y-m-d') === $raw_date) {
        return $date_obj->format('Y-m-d');
    }

    $date_obj = DateTime::createFromFormat('d-m-Y', $raw_date);
    if ($date_obj) {
        return $date_obj->format('Y-m-d');
    }

    $date_obj = DateTime::createFromFormat('d/m/Y', $raw_date);
    if ($date_obj) {
        return $date_obj->format('Y-m-d');
    }

    return false;
}

/**
 * =========================================================
 * CALLBACK
 * =========================================================
 */
function filmoly_update_user(WP_REST_Request $request) {
    if (!function_exists('filmoly_auth_validate_token')) {
        return new WP_Error('auth_not_available', 'La autenticación de Filmoly no está disponible.', ['status' => 500]);
    }

    $user_id = filmoly_auth_validate_token($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $user = get_userdata($user_id);

    if (!$user) {
        return new WP_Error('invalid_user', 'Usuario no válido.', ['status' => 404]);
    }

    $account_status = get_user_meta($user_id, 'filmoly_account_status', true) ?: 'active';
    if ($account_status !== 'active') {
        return new WP_Error('account_not_active', 'La cuenta no está activa.', ['status' => 403]);
    }

    $updated_user_data = [
        'ID' => $user_id,
    ];

    /**
     * =========================================================
     * CAMPOS WP CORE
     * =========================================================
     */

    if (isset($_POST['user_email'])) {
        $user_email = sanitize_email(wp_unslash($_POST['user_email']));

        if (!is_email($user_email)) {
            return new WP_Error('invalid_email', 'El email no es válido.', ['status' => 400]);
        }

        $existing_user = get_user_by('email', $user_email);
        if ($existing_user && (int) $existing_user->ID !== (int) $user_id) {
            return new WP_Error('email_exists', 'Ese email ya está en uso por otro usuario.', ['status' => 409]);
        }

        $updated_user_data['user_email'] = $user_email;
    }

    if (isset($_POST['display_name'])) {
        $updated_user_data['display_name'] = sanitize_text_field(wp_unslash($_POST['display_name']));
    }

    if (isset($_POST['description'])) {
        $updated_user_data['description'] = wp_kses_post(wp_unslash($_POST['description']));
    }

    if (count($updated_user_data) > 1) {
        $updated = wp_update_user($updated_user_data);

        if (is_wp_error($updated)) {
            return new WP_Error('update_failed', $updated->get_error_message(), ['status' => 500]);
        }
    }

    /**
     * =========================================================
     * USERMETA FILMOLY
     * =========================================================
     */

    if (isset($_POST['language'])) {
        update_user_meta($user_id, 'filmoly_language', sanitize_text_field(wp_unslash($_POST['language'])));
    }

    if (isset($_POST['start_day_week'])) {
        $start_day_week = sanitize_text_field(wp_unslash($_POST['start_day_week']));

        if (in_array($start_day_week, ['monday', 'sunday'], true)) {
            update_user_meta($user_id, 'filmoly_start_day_week', $start_day_week);
        }
    }

    if (isset($_POST['date_format'])) {
        update_user_meta($user_id, 'filmoly_date_format', sanitize_text_field(wp_unslash($_POST['date_format'])));
    }

    if (isset($_POST['country'])) {
        update_user_meta($user_id, 'filmoly_country', strtoupper(sanitize_text_field(wp_unslash($_POST['country']))));
    }

    if (isset($_POST['birthdate'])) {
        $normalized_birthdate = filmoly_normalize_birthdate(wp_unslash($_POST['birthdate']));

        if ($normalized_birthdate === false) {
            return new WP_Error('invalid_birthdate', 'La fecha de nacimiento no tiene un formato válido.', ['status' => 400]);
        }

        update_user_meta($user_id, 'filmoly_birthdate', $normalized_birthdate);
    }

    if (isset($_POST['marketing_consent'])) {
        $marketing_consent = filter_var(wp_unslash($_POST['marketing_consent']), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);

        if ($marketing_consent !== null) {
            update_user_meta($user_id, 'filmoly_marketing_consent', $marketing_consent ? 1 : 0);
        }
    }

    /**
     * =========================================================
     * AVATAR
     * =========================================================
     */

    $delete_avatar = false;

    if (isset($_POST['delete_avatar'])) {
        $delete_avatar = filter_var(wp_unslash($_POST['delete_avatar']), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE) === true;
    }

    if ($delete_avatar) {
        $old_avatar_id = (int) get_user_meta($user_id, 'filmoly_avatar_id', true);

        if ($old_avatar_id) {
            wp_delete_attachment($old_avatar_id, true);
        }

        delete_user_meta($user_id, 'filmoly_avatar_id');
    }

    if (!empty($_FILES['avatar']) && !empty($_FILES['avatar']['tmp_name'])) {
        $file = $_FILES['avatar'];

        if (!empty($file['error'])) {
            return new WP_Error('upload_error', 'Error al subir el avatar.', ['status' => 400]);
        }

        $allowed_mimes = [
            'jpg|jpeg|jpe' => 'image/jpeg',
            'png'          => 'image/png',
            'webp'         => 'image/webp',
        ];

        $overrides = [
            'test_form' => false,
            'mimes' => $allowed_mimes,
        ];

        $uploaded = wp_handle_upload($file, $overrides);

        if (isset($uploaded['error'])) {
            return new WP_Error('upload_failed', $uploaded['error'], ['status' => 400]);
        }

        $title = 'Filmoly Avatar - ' . $user->user_login;

        $attachment_id = wp_insert_attachment([
            'guid'           => $uploaded['url'],
            'post_mime_type' => $uploaded['type'],
            'post_title'     => $title,
            'post_content'   => '',
            'post_status'    => 'inherit',
        ], $uploaded['file']);

        if (is_wp_error($attachment_id) || !$attachment_id) {
            return new WP_Error('attachment_failed', 'No se pudo crear el adjunto del avatar.', ['status' => 500]);
        }

        $attachment_data = wp_generate_attachment_metadata($attachment_id, $uploaded['file']);
        wp_update_attachment_metadata($attachment_id, $attachment_data);

        if (function_exists('filmoly_delete_old_avatar_if_exists')) {
            filmoly_delete_old_avatar_if_exists($user_id, $attachment_id);
        }

        update_user_meta($user_id, 'filmoly_avatar_id', (int) $attachment_id);
    }

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Usuario actualizado correctamente.',
        'user' => filmoly_get_full_user_data($user_id),
    ], 200);
}