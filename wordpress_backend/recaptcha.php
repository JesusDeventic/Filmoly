if (!defined('ABSPATH')) {
    exit;
}

add_action('rest_api_init', function () {
    register_rest_route('filmoly/v1', '/verify-recaptcha', array(
        'methods'             => 'POST',
        'callback'            => 'filmoly_verify_recaptcha',
        'permission_callback' => '__return_true',
    ));
});

function filmoly_verify_recaptcha(WP_REST_Request $request) {
    $token = $request->get_param('token');

    if (empty($token)) {
        return new WP_Error(
            'missing_token',
            'Token is required',
            array('status' => 400)
        );
    }

    $secret_key = '6Lck98IfAAAAAE7w_rxLlr58eHUjYi1vXWSjFZmo'; // Clave secreta de reCAPTCHA
    $verify_url = 'https://www.google.com/recaptcha/api/siteverify';

    $response = wp_remote_post($verify_url, array(
        'body' => array(
            'secret'   => $secret_key,
            'response' => $token,
        ),
    ));

    if (is_wp_error($response)) {
        return new WP_Error(
            'verification_failed',
            'Failed to verify reCAPTCHA',
            array('status' => 500)
        );
    }

    $body = json_decode(wp_remote_retrieve_body($response), true);

    return rest_ensure_response($body);
}