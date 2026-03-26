<?php
if ( !is_user_logged_in() ) {
    echo '<h3>Contenido para usuarios registrados</h3>';
} else {
    $user_id = get_current_user_id();
    $nivel = mycred_display_users_total_balance( $user_id, 'mycred_retroaportes' );
    $usuario = wp_get_current_user();
    $role = ( array ) $usuario->roles;


    //Si tiene rango Aficionado lo muestro
    if ( $nivel < 5 ) {
        echo '<h3>Debes llegar a Rango "Aficionado" para poder editar fichas</h3>';
    } else {
        // post id wordpress
        $post_id = '';
        //*************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/

        if ( isset( $_POST['cargar-creador'] ) || ( isset( $_POST['cargar-editor'] ) && isset( $_POST['postid'] ) ) ) {

            // SI HEMOS PULSADO EL BOTON EDITAR...
            if ( isset( $_POST['cargar-editor'] ) ) {

                $post_id = $_POST['postid'];

                // DATOS GENERALES
                $categoria = strip_tags( get_the_term_list( $post_id, 'category', '', ', ' ) );
                // CARGO LOS DATOS ACTUALES DE LA FICHA
                $old_url_imagen = get_the_post_thumbnail_url( $post_id );
                //https://image.tmdb.org/t/p/w300/k9h1Don5JWNhLMAjspwbiMMoDzS.jpg
                $old_tmdb_id = get_field( 'field_6140b6074b100', $post_id );
                $old_imdb_id = get_field( 'field_61420601ee84f', $post_id );
                $old_titulo_spanish = get_field( 'field_6140b6a355c52', $post_id );
                $old_titulo_original = get_the_title( $post_id );
                $old_titulos_alternativos = get_field( 'field_6140b8c510b0c', $post_id );
                $old_paises = strip_tags( get_the_term_list( $post_id, 'paises', '', ', ' ) );
                $old_productoras = strip_tags( get_the_term_list( $post_id, 'productoras', '', ', ' ) );
                $old_anio = get_field( 'field_6140bd33708b6', $post_id );
                $old_duracion = get_field( 'field_6140beeb04a5c', $post_id );
                $old_directores = strip_tags( get_the_term_list( $post_id, 'direccion', '', ', ' ) );
                $old_actores = strip_tags( get_the_term_list( $post_id, 'reparto', '', ', ' ) );
                $old_guion = get_field( 'field_61671faf59600', $post_id );
                $old_musica = get_field( 'field_61671f77595ff', $post_id );
                $old_fotografia = get_field( 'field_616724c5d05ac', $post_id );
                //$old_sinopsis = apply_filters( 'the_content', get_post_field( 'post_content', $post_id ) );

                //$old_sinopsis = str_replace( '<p>', '', $old_sinopsis );
                //$old_sinopsis = str_replace( '</p>', '', $old_sinopsis );
                $old_sinopsis = get_post_field( 'post_content', $post_id );
                
                $old_premios = get_field( 'field_6275041cce02e', $post_id );
                $old_curiosidades = get_field( 'field_62750f7681b92', $post_id );
                $old_frases = get_field( 'field_62750fab81b93', $post_id );

                // DATOS ACTUALES DEL APORTE
                $old_calidad = get_field( 'field_5cff8cfcad886', $post_id );
                $old_resolucion = get_field( 'field_5cff8c4a18ae8', $post_id );
                $old_tamanio = get_field( 'field_5cff8c8d18ae9', $post_id );
                $old_audio = get_field( 'field_6196a03d33ee0', $post_id );
                $old_subtitulos = get_field( 'field_61856837fc028', $post_id );
                $old_modificacion = get_field( 'field_5d00d90c1c9b0', $post_id );
                $old_rango = get_field( 'field_5d00d80aec1ab', $post_id );
                $old_informacion = get_field( 'field_5d07b0cc888a6', $post_id );

                echo '<h1>EDITAR FICHA</h1>';
                echo 'POST: ' . $post_id . '<br>';
            } else {
                echo '<h1>CREAR FICHA</h1>';
            }

// FORMULARIO PARA ACTUALIZAR LOS DATOS
            //$old_url_imagen = 'https://image.tmdb.org/t/p/w300/k9h1Don5JWNhLMAjspwbiMMoDzS.jpg';
            echo '<img src="' . $old_url_imagen . '" id="img_poster" width="100">';
            echo '<form id="formulario-edicion-fichas" name="formulario" action="" method="post" enctype="multipart/form-data">';
            //enctype para enviar un file ( input file )
            echo '<input type="hidden" id="input_postid" name="postid" value="' . $post_id . '">';
            echo '<input type="hidden" id="input_categoria" name="categoria" value="' . $categoria . '">';

            echo '<input type="hidden" id="input_poster" name="poster" placeholder="Escribe solo si vas a meter el poster a mano" value="">';
            echo 'Poster manual: <input id="my_image_upload" name="my_image_upload" type="file" accept="image/png, image/jpeg" multiple="false"/>';

echo '<div class="edicion-datos-generales">';
            echo '<h3>DATOS GENERALES</h3>';

          // CATEGORIAS
            echo '<label for="select_categorias">CATEGORIA</label><select id="select_categorias" name="select_categoria">';

            $array_categorias = get_terms( 'category' );

            // Obtengo las categorias de la ficha para seleccionarlas al cargar el select            
            $categorias_ficha = get_the_terms( $post_id, 'category' );
            foreach ( $array_categorias as $categoria ) {
                if (!empty($categorias_ficha) && in_array( $categoria, $categorias_ficha ) ) {
                    echo '<option selected>' . $categoria->name . '</option>';
                } else {
                    echo '<option>' . $categoria->name . '</option>';
                }

            }
            echo '</select>';
            // ETIQUETAS
            echo '<label for="select_etiquetas">ESTILO</label><select id="select_etiquetas" name="select_etiqueta">';

            $array_etiquetas = get_terms( 'post_tag' );
            // Obtengo las etiquetas de la ficha para seleccionarlas al cargar el select
            $etiquetas_ficha = get_the_terms( $post_id, 'post_tag' );
            foreach ( $array_etiquetas as $etiqueta ) {
                if (!empty($etiquetas_ficha) &&  in_array( $etiqueta, $etiquetas_ficha ) ) {
                    echo '<option selected>' . $etiqueta->name . '</option>';
                } else {
                    echo '<option>' . $etiqueta->name . '</option>';
                }

            }
            echo '</select>';
            // SAGAS
            echo '<label for="select_sagas">SAGAS (puedes seleccionar varias)</label><select id="select_sagas" name="select_sagas[]" multiple>';

            $array_sagas = get_terms( 'saga_grupo' );
            // Obtengo las sagas de la ficha para seleccionarlas al cargar el select
            $sagas_ficha = get_the_terms( $post_id, 'saga_grupo' );
            foreach ( $array_sagas as $saga ) {
                if (!empty($sagas_ficha) && in_array( $saga, $sagas_ficha ) ) {
                    echo '<option selected>' . $saga->name . '</option>';
                } else {
                    echo '<option>' . $saga->name . '</option>';
                }
            }
            echo '</select>';
            // Opcion para crear nueva saga
            echo '<label for="input_nueva_saga">Nueva saga (si no está en el desplegable)</label><input type="text" id="input_nueva_saga" name="nueva_saga[]" value="">';

            // GENEROS
            echo '<label for="select_generos">GENEROS (puedes seleccionar varios)</label><select id="select_generos" name="select_generos[]" multiple>';

            $array_generos = get_terms( 'genero' );
            // Obtengo los generos de la ficha para seleccionarlos al cargar el select
            $generos_ficha = get_the_terms( $post_id, 'genero' );
            foreach ( $array_generos as $genero ) {
                if (!empty($generos_ficha) && in_array( $genero, $generos_ficha ) ) {
                    echo '<option selected>' . $genero->name . '</option>';
                } else {
                    echo '<option>' . $genero->name . '</option>';
                }
            }
            echo '</select>';
            // SUBGENEROS
            echo '<label for="select_subgeneros">SUBGENEROS (puedes seleccionar varios)</label><select id="select_subgeneros" name="select_subgeneros[]" multiple>';

            $array_subgeneros = get_terms( 'subgenero' );
            // Obtengo los subgeneros de la ficha para seleccionarlos al cargar el select
            $subgeneros_ficha = get_the_terms( $post_id, 'subgenero' );
            foreach ( $array_subgeneros as $subgenero ) {
                if (!empty($subgeneros_ficha) && in_array( $subgenero, $subgeneros_ficha ) ) {
                    echo '<option selected>' . $subgenero->name . '</option>';
                } else {
                    echo '<option>' . $subgenero->name . '</option>';
                }
            }
            echo '</select>';

            echo '</div>';

echo '<div class="edicion-datos-tecnicos">';
            echo '<h3>DATOS TÉCNICOS</h3>';
            echo '<label for="input_tmdbid">ID TMDB</label><input type="text" id="input_tmdbid" name="tmdbid" value="' . $old_tmdb_id . '">
            <p id="sugerencia_tmdbid" style="color: red;"></p>';
            echo '<label for="input_imdbid">ID IMDB</label><input type="text" id="input_imdbid" name="imdbid" value="' . $old_imdb_id . '">
            <p id="sugerencia_imdbid" style="color: red;"></p>';

            echo '<label for="input_titulo_spanish">TITULO ESPAÑOL</label><input type="text" id="input_titulo_spanish" name="titulo_spanish" value="' . $old_titulo_spanish . '">
            <p id="sugerencia_titulo_spanish" style="color: red;"></p>';

            echo '<label for="input_titulo_original">TITULO ORIGINAL</label><input type="text" id="input_titulo_original" name="titulo_original" value="' . $old_titulo_original . '">
            <p id="sugerencia_titulo_original" style="color: red;"></p>';

            echo '<label for="input_titulos_alternativos">TITULOS ALTERNATIVOS (Uno por línea)</label><textarea id="input_titulos_alternativos" name="titulos_alternativos" rows="5">' . $old_titulos_alternativos . '</textarea>
            <p id="sugerencia_titulos_alternativos" style="color: red;"></p>';

                // PAISES (códigos ISO en slug). Evita errores usando un select con términos existentes.
                echo '<label for="select_paises">PAISES (códigos ISO, puedes seleccionar varios)</label>';
                echo '<select id="select_paises" name="paises_sel[]" multiple>';
                $paises_terms = get_terms( array(
                    'taxonomy' => 'paises',
                    'hide_empty' => false,
                ) );
                $paises_ficha_slugs = wp_get_post_terms( $post_id, 'paises', array( 'fields' => 'slugs' ) );
                $paises_ficha_slugs = is_array( $paises_ficha_slugs ) ? $paises_ficha_slugs : array();
                if ( ! empty( $paises_terms ) && ! is_wp_error( $paises_terms ) ) {
                    foreach ( $paises_terms as $pais_term ) {
                        if ( ! isset( $pais_term->slug, $pais_term->name ) ) {
                            continue;
                        }
                        $selected = in_array( (string) $pais_term->slug, $paises_ficha_slugs, true );
                        $label = $pais_term->name . ' (' . $pais_term->slug . ')';
                        echo '<option ' . ( $selected ? 'selected' : '' ) . ' value="' . esc_attr( (string) $pais_term->slug ) . '">'
                             . esc_html( (string) $label ) . '</option>';
                    }
                }
                echo '</select>';
                // Import TMDB (compatibilidad): se rellena un input hidden por el script existente.
                // No lo usamos para guardar automáticamente; solo lo mostramos en rojo como "sugerencia".
                echo '<input type="hidden" id="input_paises" name="paises_tmdb_raw" value="' . esc_attr( $old_paises ) . '">';
                echo '<p id="sugerencia_paises" style="color: red;"></p>';

            echo '<label for="input_productoras">PRODUCTORAS (separadas por comas)</label><input type="text" id="input_productoras" name="productoras" value="' . $old_productoras . '">
            <p id="sugerencia_productoras" style="color: red;"></p>';

            echo '<label for="input_anio">AÑO (aaaa-mm-dd)</label><input type="text" id="input_anio" name="anio" value="' . $old_anio . '">
            <p id="sugerencia_anio" style="color: red;"></p>';

            echo '<label for="input_duracion">DURACION (en minutos)</label><input type="text" id="input_duracion" name="duracion" value="' . $old_duracion . '">
            <p id="sugerencia_duracion" style="color: red;"></p>';

            echo '<label for="input_directores">DIRECCION (separados por comas)</label><input type="text" id="input_directores" name="directores" value="' . $old_directores . '">
            <p id="sugerencia_directores" style="color: red;"></p>';

            echo '<label for="input_actores">REPARTO (separados por comas)</label><textarea id="input_actores" name="actores" rows="2">' . $old_actores . '</textarea>
            <p id="sugerencia_reparto" style="color: red;"></p>';

            echo '<label for="input_guion">GUION (separados por comas)</label><input type="text" id="input_guion" name="guion" value="' . $old_guion . '">
            <p id="sugerencia_guion" style="color: red;"></p>';

            echo '<label for="input_musica">MUSICA (separados por comas)</label><input type="text" id="input_musica" name="musica" value="' . $old_musica . '">
            <p id="sugerencia_musica" style="color: red;"></p>';

            echo '<label for="input_fotografia">FOTOGRAFIA (separados por comas)</label><input type="text" id="input_fotografia" name="fotografia" value="' . $old_fotografia . '">
            <p id="sugerencia_fotografia" style="color: red;"></p>';

            echo '<label for="input_sinopsis">SINOPSIS</label><input type="text" id="input_sinopsis" name="sinopsis" value="' . $old_sinopsis . '">
            <p id="sugerencia_sinopsis" style="color: red;"></p>';

            echo '</div>';
        
            echo '<div class="edicion-curiosidades">';
            echo '<label for="input_premios">PREMIOS Y NOMINACIONES (Uno por línea)</label><textarea id="input_premios" name="premios" rows="5">' . $old_premios . '</textarea>';
            echo '<label for="input_curiosidades">CURIOSIDADES Y ERRORES (Uno por línea)</label><textarea id="input_curiosidades" name="curiosidades" rows="5">' . $old_curiosidades . '</textarea>';
            echo '<label for="input_frases">FRASES CELEBRES (Uno por línea)</label><textarea id="input_frases" name="frases" rows="5">' . $old_frases . '</textarea>';
            echo '</div>';







 // SI SE ESTA CREANDO UNA FICHA O ES ADMIN, PERMITO EDITAR APORTE
            if ( isset( $_POST['cargar-creador'] ) || ( $role[0] == 'editor' || $role[0] == 'administrator' ) ) {

                echo '<div class="edicion-datos-aporte">';
                echo '<h3>DATOS APORTE</h3>';
                echo '<label for="select_aportador">Aportador</label><select id="select_aportador" name="select_aportador">';

                $array_usuarios = get_users();
                // Obtengo el usuario de la ficha para seleccionarlo al cargar el select
                $usuario_ficha = get_post_field ( 'post_author', $post_id );
                $usuario_ficha = get_the_author_meta( 'display_name', $usuario_ficha );

                foreach ( $array_usuarios as $usuario ) {
                    if ( $usuario->display_name ==  $usuario_ficha ) {
                        echo '<option selected>' . $usuario->display_name . '</option>';
                    } else {
                        echo '<option>' . $usuario->display_name . '</option>';
                    }

                }
                echo '</select>';

                // CALIDAD
                echo '<label for="select_calidad">CALIDAD</label><select id="select_calidad" name="select_calidad">';

                $opciones_calidad = get_field_object( 'field_5cff8cfcad886' );
                foreach ( $opciones_calidad['choices'] as $opcion ) {
                    if ( $opcion == $old_calidad ) {
                        echo '<option selected>' . $opcion . '</option>';
                    } else {
                        echo '<option>' . $opcion . '</option>';
                    }

                }
                echo '</select>';

                echo '<label for="input_resolucion">RESOLUCIÓN - Ancho x Alto (1920x1080)</label><input type="text" id="input_resolucion" name="resolucion" value="' . $old_resolucion . '">';
                echo '<label for="input_tamanio">TAMAÑO (Mb)</label><input type="text" id="input_tamanio" name="tamanio" value="' . $old_tamanio . '">';
                
                echo '<label for="input_audio">AUDIO (Idiomas separados por comas)</label><input type="text" id="input_audio" name="audio" value="' . $old_audio . '">';  
                echo '<label for="input_subtitulos">SUBTITULOS (Idiomas separados por comas)</label><input type="text" id="input_subtitulos" name="subtitulos" value="' . $old_subtitulos . '"><p>Indica al final el tipo de subtitulos entre paréntesis, por ejemplo: (Elegibles), (Incrustados), (Forzados), (Rótulos)...</p>';
              
                // MODIFICACION
                echo '<label for="select_estado_aporte">ESTADO APORTE</label><select id="select_estado_aporte" name="select_estado_aporte">';

                $opciones_estado = get_field_object( 'field_5d00d90c1c9b0' );
                foreach ( $opciones_estado['choices'] as $opcion ) {
                    if ( $opcion == $old_modificacion ) {
                        echo '<option selected>' . $opcion . '</option>';
                    } else {
                        echo '<option>' . $opcion . '</option>';
                    }
                }
                echo '</select>';
                // RANGO
                echo '<label for="select_rango">RANGO NECESARIO</label><select id="select_rango" name="select_rango">';

                $opciones_rango = get_field_object( 'field_5d00d80aec1ab' );
                foreach ( $opciones_rango['choices'] as $opcion ) {
                    if ( $opcion == $old_rango ) {
                        echo '<option selected>' . $opcion . '</option>';
                    } else {
                        echo '<option>' . $opcion . '</option>';
                    }
                }
                echo '</select>';
                echo '<label for="input_informacion">INFORMACION ADICIONAL</label><textarea id="input_informacion" name="informacion" rows="5">' . $old_informacion . '</textarea>
                <p>Temporadas disponibles/totales: x/x<br>Episodios disponibles/totales: x/x<br>Montador...</p>';
                echo '</div>';
            }





 // Distinto boton segun crear o editar
            if ( isset( $_POST['cargar-creador'] ) ) {

                echo '<input type="submit" name="guardar-creador" value ="Crear Ficha">';
            } else if ( isset( $_POST['cargar-editor'] ) ) {

                echo '<input type="submit" name="guardar-editor" value ="Actualizar Ficha">';
            }

            echo '</form>';
            //***************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
 } else if ( isset( $_POST['guardar-creador'] ) || isset( $_POST['guardar-editor'] ) ) {

            $post_id = '';
			
			$cat_id = get_cat_ID( $_POST['select_categoria'] );

            // Creo una bandera para saber si es creacion
            $creacion = false;
            $ficha_existe = 0;
            if ( isset( $_POST['guardar-creador'] ) ) {
                $creacion = true;				

                // busco si existe ya la ficha en la retro por tmdb y que tenga misma categoria (tipo contenido)
                $args = array(
                    'post_type' => 'post',
                    'post_status' => 'publish',
                    'posts_per_page' => 1,
                    'meta_query' => array(
                        array(
                            'key' => 'ficha_tmdb_id',
                            'value' => $_POST['tmdbid']
                        )
                    ),
					'tax_query' => array(
						array(
							'taxonomy' => 'category',
							'field'    => 'term_id', 
							'terms'    => $cat_id
						)
					),
                    'no_found_rows' => true,
                );
                $resultado_busqueda = new WP_Query( $args );
                $ficha_existe = $resultado_busqueda->post_count;
            } else {
                $post_id = $_POST['postid'];
            }

            if ( $creacion && $ficha_existe > 0 ) {
                echo 'Vaya, ya existe esa ficha en La Retroteca';
            } else {
                // ACTUALIZAR / CREAR POST WORDPRESS
                $my_post = array();
                $titulo_original_post = isset( $_POST['titulo_original'] ) ? trim( (string) $_POST['titulo_original'] ) : '';
                $titulo_spanish_post = isset( $_POST['titulo_spanish'] ) ? trim( (string) $_POST['titulo_spanish'] ) : '';
                $titulo_post_final = $titulo_original_post !== '' ? $titulo_original_post : $titulo_spanish_post;

                $my_post['post_type'] = 'post';
                $my_post['post_title'] = $titulo_post_final;
                $my_post['post_name'] = sanitize_title( $titulo_post_final );
                //url
                $my_post['post_content'] = $_POST['sinopsis'];

                $aportador = get_users( array( 'search' => $_POST['select_aportador'] ) );

                // DIFERENCIANDO ADMINS DE USUARIOS para el estado del post
                if ( $role[0] == 'editor' || $role[0] == 'administrator' ) {
                    // El admin puede cambiar el aportador y siempre pone estado publicado
                    $my_post['post_author']  = $aportador[0]->ID;
                    $my_post['post_status']  = 'publish';

                } else {
                    // Los usuarios, si crean se pone en privado y si editan en publicado
                    if ( $creacion ) {
                        $my_post['post_status']  = 'private';
                    } else {
                        $my_post['post_status']  = 'publish';
                    }
                }

                if ( $creacion ) {
                    echo '<h4>Se ha creado la ficha correctamente</h4>';

                    // ESTE IF ES IMPORTANTISIMO. No se porque esa funcion crea los post dos veces, con eso lo evitamos
                    if ( !defined( 'DO_IT_ONCE' ) ) {
                        define( 'DO_IT_ONCE', true );
                        $post_id = wp_insert_post( $my_post );
                    }

                } else {

                    echo '<h4>Se ha actualizado la ficha correctamente</h4>';

                    // Si estaba privada, actualizo la fecha para que al publicar salga la primera
                    if ( get_post_status( $post_id ) == 'private' ) {
                        $my_post['post_date'] = current_time( 'mysql' );
                    } else {
                        // Si es mejora o exclusivo y antes no era
                        $estado_anterior = get_field( 'field_5d00d90c1c9b0', $post_id );
                        $estado_nuevo = $_POST['select_estado_aporte'];
                        if ( $estado_anterior != $estado_nuevo && ( $estado_nuevo == 'Mejorado' || $estado_nuevo == 'Exclusivo' ) ) {
                            $my_post['post_date'] = current_time( 'mysql' );
                        }
                    }

                    // Guardo el ID enviado por POST en el formulario y actualizo el post
                    $my_post['ID'] = $post_id;

                    wp_update_post( $my_post );

                }

                // ACTUALIZAR TAXONOMIAS ( ultimo parametro es para conservar las que ya hay. Si ponemos false o lo omitimos, se agrega y quita las que habia )
                wp_set_post_terms( $post_id, $cat_id, 'category', false );
                // las categorias se meten con las ids
                wp_set_post_terms( $post_id, $_POST['select_etiqueta'], 'post_tag', false );
                wp_set_post_terms( $post_id, $_POST['select_generos'], 'genero', false );
                wp_set_post_terms( $post_id, $_POST['select_subgeneros'], 'subgenero', false );
                wp_set_post_terms( $post_id, $_POST['select_sagas'], 'saga_grupo', false );
                // Si se metio nueva saga, la añado a las que ya tenia
                wp_set_post_terms( $post_id, $_POST['nueva_saga'], 'saga_grupo', true );

                wp_set_post_terms( $post_id, $_POST['directores'], 'direccion', false );
                wp_set_post_terms( $post_id, $_POST['actores'], 'reparto', false );

                wp_set_post_terms( $post_id, $_POST['productoras'], 'productoras', false );

                // PAISES:
                // Solo guardamos lo que el editor selecciona en el select (ISO slugs).
                $paises_post = isset( $_POST['paises_sel'] ) ? $_POST['paises_sel'] : array();
                if ( ! is_array( $paises_post ) ) $paises_post = array();

                $array_paises = array();
                foreach ( $paises_post as $pais ) {
                    $pais = trim( (string) $pais );
                    if ( $pais === '' ) continue;
                    $array_paises[] = $pais;
                }

                if ( empty( $array_paises ) ) {
                    echo 'Debes seleccionar al menos un país (códigos ISO) de la lista.';
                    $array_paises = array();
                }

                $paises_validos = true;
                foreach ( $array_paises as $pais ) {
                    // term_exists valida por slug (que es lo que ahora toca).
                    $existe = term_exists( $pais, 'paises' );
                    if ( $existe == 0 || $existe == null ) {
                        $paises_validos = false;
                        break;
                    }
                }
                if ( $paises_validos && ! empty( $array_paises ) ) {
                    wp_set_post_terms( $post_id, $array_paises, 'paises', false );
                } else {
                    echo 'Error al guardar los países: hay alguno no válido (usa los códigos ISO de la lista).';
                }

                // ACTUALIZAR DATOS TECNICOS
                update_field( 'field_6140b6074b100', $_POST['tmdbid'], $post_id );
                update_field( 'field_61420601ee84f', $_POST['imdbid'], $post_id );
                update_field( 'field_6140b6a355c52', $_POST['titulo_spanish'], $post_id );
                update_field( 'field_6140b8c510b0c', $_POST['titulos_alternativos'], $post_id );
                update_field( 'field_6140bd33708b6', $_POST['anio'], $post_id );
                update_field( 'field_6140beeb04a5c', $_POST['duracion'], $post_id );
                update_field( 'field_61671faf59600', $_POST['guion'], $post_id );
                update_field( 'field_61671f77595ff', $_POST['musica'], $post_id );
                update_field( 'field_616724c5d05ac', $_POST['fotografia'], $post_id );
                update_field( 'field_6275041cce02e', $_POST['premios'], $post_id );
                update_field( 'field_62750f7681b92', $_POST['curiosidades'], $post_id );
                update_field( 'field_62750fab81b93', $_POST['frases'], $post_id );

                // SI SE ESTA CREANDO UNA FICHA O ES ADMIN, PERMITO GUARDAR POSTER Y ACTUALIZAR APORTE
                if ( $creacion || ( $role[0] == 'editor' || $role[0] == 'administrator' ) ) {

                    // ACTUALIZAR DATOS APORTE
                    update_field( 'field_5cff8cfcad886', $_POST['select_calidad'], $post_id );
                    update_field( 'field_5cff8c4a18ae8', $_POST['resolucion'], $post_id );
                    update_field( 'field_5cff8c8d18ae9', $_POST['tamanio'], $post_id );
                    update_field( 'field_6196a03d33ee0', $_POST['audio'], $post_id );
                    update_field( 'field_61856837fc028', $_POST['subtitulos'], $post_id );
                    update_field( 'field_5d00d90c1c9b0', $_POST['select_estado_aporte'], $post_id );
                    update_field( 'field_5d00d80aec1ab', $_POST['select_rango'], $post_id );
                    update_field( 'field_5d07b0cc888a6', $_POST['informacion'], $post_id );

                    // ACTUALIZAR POSTER
                    $new_manual_imagen = $_FILES['my_image_upload'];
                    // poster subido a mano
                    $poster_antiguo = get_the_post_thumbnail_url( $post_id );
                    $new_url_imagen = $_POST['poster'];
                    // poster elegido de tmdb

                    if ( $new_manual_imagen['error'] == 0 ) {
                        echo 'Se ha cargado un poster manualmente';

                        require_once( ABSPATH . 'wp-admin/includes/image.php' );
                        require_once( ABSPATH . 'wp-admin/includes/file.php' );
                        require_once( ABSPATH . 'wp-admin/includes/media.php' );
                        // Uso la funcion de wordpress pasando el name del file input y el postid. Luego lo meto como featured imagen ( principal )
                        $attachment_id = media_handle_upload( 'my_image_upload', $post_id );
                        set_post_thumbnail( $post_id, $attachment_id );

                    } else if ( $new_url_imagen != '' && $new_url_imagen != $poster_antiguo ) {

                        echo 'Se ha cargado un poster de TMDB';
                        if ( !$creacion ) {
                            // Borrar poster viejo
                            $poster_viejo = get_post_thumbnail_id( $post_id );
                            wp_delete_attachment( $poster_viejo, true );
                        }

                        // Insertar nuevo poster
                        $upload_dir = wp_upload_dir();
                        $image_data = file_get_contents( $new_url_imagen );
                        $filename = basename( $new_url_imagen );

                        if ( wp_mkdir_p( $upload_dir['path'] ) )
                        $file = $upload_dir['path'] . '/' . $filename;
                        else
                        $file = $upload_dir['basedir'] . '/' . $filename;
                        file_put_contents( $file, $image_data );

                        $wp_filetype = wp_check_filetype( $filename, null );
                        // atributos de la propia imagen en un array
                        $attachment = array(
                            'post_mime_type' => $wp_filetype['type'],
                            'post_title' => sanitize_file_name( $_POST['titulo_spanish'] ),
                            'post_content' => '',
                            'post_status' => 'inherit'
                        );
                        $attach_id = wp_insert_attachment( $attachment, $file, $post_id );
                        require_once( ABSPATH . 'wp-admin/includes/image.php' );

                        $attach_data = wp_generate_attachment_metadata( $attach_id, $file );
                        $res1 = wp_update_attachment_metadata( $attach_id, $attach_data );
                        $res2 = set_post_thumbnail( $post_id, $attach_id );
                    }

                } else {
                    echo 'No tienes permisos para actualizar posters';
                }

                // Formulario para volver a la pagina de la ficha al terminar de guardar todo, tras 2 segundos
                echo '<form id="formulario-fin" action="' . get_permalink( $post_id ) . '" method="post"></form>';
                echo '<script>
                window.onload=function(){
                // Una vez cargada la página, el formulario se enviara automáticamente.
                setTimeout(function(){ document.forms["formulario-fin"].submit(); }, 2000);
                }
                </script>';
            }
            //*************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
        } else {
            echo 'No has seleccionado ninguna ficha para editar';
        }
    }
}
?>








<script>
    const BASE_URL = 'https://api.themoviedb.org/3';
    const API_KEY = '?api_key=0a4c95640c82ac277a326487c84eb3e0';
    const IDIOMA_ES = '&language=es-ES';
    /*****************************************************************************************/
    // La uso en la funcion RellenarDatosTecnicos para saber a que url de la API llamar
    var tipo_ficha = '';
    var contador_pag_resultados = 1;
    var url_busqueda = '';

    // RECOGIDA DE ELEMENTOS HTML
    var input_titulo_buscador = document.getElementById('input_titulo_buscador');
    var contenedor_busqueda_tmdb = document.getElementById('contenedor_busqueda');
    var contenedor_resultados_tmdb = document.getElementById('contenedor_resultados_tmdb');
    var contenedor_posters = document.getElementById('contenedor_posters');
    var boton_paginacion = document.getElementById('boton_paginacion'); 

    // Inputs formulario edicion
    var input_categoria = document.getElementById('input_categoria');
    var acf_poster = document.getElementById('input_poster');
    var acf_id_tmdb = document.getElementById('input_tmdbid');
    var acf_id_imdb = document.getElementById('input_imdbid');
    var acf_titulo_spanish = document.getElementById('input_titulo_spanish');
    var acf_titulo_original = document.getElementById('input_titulo_original');
    var acf_titulos_alternativos = document.getElementById('input_titulos_alternativos');
    var acf_paises = document.getElementById('input_paises');
    var select_paises = document.getElementById('select_paises');
    var acf_productoras = document.getElementById('input_productoras');
    var acf_fecha = document.getElementById('input_anio');
    var acf_duracion = document.getElementById('input_duracion');
    var acf_directores = document.getElementById('input_directores');
    var acf_reparto = document.getElementById('input_actores');
    var acf_guion = document.getElementById('input_guion');
    var acf_musica = document.getElementById('input_musica');
    var acf_fotografia = document.getElementById('input_fotografia');
    var acf_sinopsis = document.getElementById('input_sinopsis');
    
    // Parrafos para sugerir si ya hay campos en la ficha pero en TMDB son distintos
    var sugerencia_id_tmdb = document.getElementById('sugerencia_tmdbid');
    var sugerencia_id_imdb = document.getElementById('sugerencia_imdbid');
    var sugerencia_titulo_spanish = document.getElementById('sugerencia_titulo_spanish');
    var sugerencia_titulo_original = document.getElementById('sugerencia_titulo_original');
    var sugerencia_titulos_alternativos = document.getElementById('sugerencia_titulos_alternativos');
    var sugerencia_paises = document.getElementById('sugerencia_paises');
    var sugerencia_productoras = document.getElementById('sugerencia_productoras');
    var sugerencia_fecha = document.getElementById('sugerencia_anio');
    var sugerencia_duracion = document.getElementById('sugerencia_duracion');
    var sugerencia_directores = document.getElementById('sugerencia_directores');
    var sugerencia_reparto = document.getElementById('sugerencia_reparto');
    var sugerencia_guion = document.getElementById('sugerencia_guion');
    var sugerencia_musica = document.getElementById('sugerencia_musica');
    var sugerencia_fotografia = document.getElementById('sugerencia_fotografia');
    var sugerencia_sinopsis = document.getElementById('sugerencia_sinopsis');

    /***************************************** ACCIONES AL CARGAR LA PAGINA ************************************************/
    CargaPagina();
	function CargaPagina() {
	// Si esta a la vista el input tmdb es que esta el formulario de edicion, si no oculto la busqueda en tmdb	
		if (acf_id_tmdb != null) {
			acf_id_tmdb.readOnly = true;
			//acf_id_imdb.readOnly = true;
			boton_paginacion.style.visibility = "hidden";

			//acf_poster.readOnly = true;
			// Si la ficha ya tiene ID TMDB, bloqueo el campo y busco por id en TMDB
			if (acf_id_tmdb.value != '' && acf_id_tmdb.value != 0) { 
				//contenedor_busqueda_tmdb.innerHTML = "";
				if (input_categoria.value == 'Película' || input_categoria.value == 'Cortometraje') {
					tipo_ficha = 'peli';
					RellenarDatosTecnicos(acf_id_tmdb.value);
				} else if (input_categoria.value == 'Serie' || input_categoria.value == 'Programa TV') {
					tipo_ficha = 'serie';
					RellenarDatosTecnicos(acf_id_tmdb.value);
				}
			}    
		} else {
			contenedor_busqueda_tmdb.innerHTML = "";
		}    
	}

    /***************************************** ONCLICK en botones Buscar ************************************************/
    function ListenerBotonBuscar(name_boton) {
        contenedor_resultados_tmdb.innerHTML = "Buscando fichas...";
        boton_paginacion.style.visibility = "visible";
        
        // Segun el boton pulsado, busco en la base de datos de pelis o series en TMDB
        if (name_boton == "boton_pelis") {
            url_busqueda = '/search/movie';
            contador_pag_resultados = 1;
        } else if (name_boton == "boton_series") {
            url_busqueda = '/search/tv';
            contador_pag_resultados = 1;
        } else if (name_boton == "boton_paginacion") {
            contador_pag_resultados++;
        }
        let pagina = '&page=' + contador_pag_resultados;
        BuscarEnTMDB(BASE_URL + url_busqueda + API_KEY + '&query=' + input_titulo_buscador.value + pagina + IDIOMA_ES);        
    }

    /********************************* ***********************************************************************************/
    // FUNCION BUSCAR PELICULAS (OBTIENE 20)
    function BuscarEnTMDB(url) {
        // Si estoy mostrando posters restauro el contenedor
        contenedor_posters.innerHTML = '';        

        // Recojo el json con los resultados encontrados en TMDB
        fetch(url).then(res => res.json()).then(data => {
            let tabla_resultados = '';
            //console.log(data);

            // Si no hay resultados, lo pongo. Si hay, muentro la tabla
            if (data.results == null || data.results.length == 0) {
                tabla_resultados = "No hay resultados";
            } else {
                tabla_resultados = '<h4>Resultados encontrados:</h4><table><tr>';
                for (let i = 0; i < data.results.length; i++) {
                    let id = data.results[i].id;
                    let poster = data.results[i].poster_path;
                    let anio = '';
                    let titulo_es = '';
                    let titulo_ori = '';
                    // Si es peli o serie tiene distinta variable de titulo y de fecha // 4 primeros digitos (si hay fecha)
                    if (url.includes("/movie?")) {
                        if (data.results[i].release_date != null && data.results[i].release_date != '') {
                            anio = data.results[i].release_date.substr(0, 4);
                        } else {
                            anio = '----';
                        }
                        titulo_es = data.results[i].title;
                        titulo_ori = data.results[i].original_title;
                        tipo_ficha = 'peli';
                    } else if (url.includes("/tv?")) {
                        if (data.results[i].first_air_date != null && data.results[i].first_air_date != '') {
                            anio = data.results[i].first_air_date.substr(0, 4);
                        } else {
                            anio = '----';
                        }
                        titulo_es = data.results[i].name;
                        titulo_ori = data.results[i].original_name;
                        tipo_ficha = 'serie';
                    }

                    // Asigno el Onclick a cada celda de la tabla y le paso la id y la url de busqueda a la funcion
                    tabla_resultados += '<td id="' + id + '" onclick="RellenarDatosTecnicos(this.id)">';
                    if (poster == null) {
                        tabla_resultados += '*****<br>';
                    } else {
                        poster = 'https://image.tmdb.org/t/p/w400' + poster;
                        tabla_resultados += '<img src="' + poster + '"><br>';
                    }
                    tabla_resultados += '-' + anio + '-<br>' + titulo_es + '<br>(' + titulo_ori + ')</td>';
                }
                tabla_resultados += '</tr></table>';
            }
            // Escribo los resultados en el DIV del html
            contenedor_resultados_tmdb.innerHTML = tabla_resultados;
        });
    }

    // FUNCION QUE RELLENA LOS CAMPOS HTML
    function RellenarDatosTecnicos(id_ficha) {        
        // Oculto la busqueda cuando se ha seleccionado una pelicula
        contenedor_busqueda_tmdb.innerHTML = "";
        
        // Muestro los posters para que guarde el que quiera y lo suba a mano
        MostrarImagenes(id_ficha);
        contenedor_resultados_tmdb.innerHTML = '<h3 style="color: red;">Datos Técnicos insertados</h3>';

        // Recojo la nueva URL para buscar los datos de la peli o serie en profundidad, dependiendo de la url de busqueda (peli o serie)
        let url_ficha = '';
        if (tipo_ficha == 'peli') {
            url_ficha = BASE_URL + '/movie/' + id_ficha + API_KEY + IDIOMA_ES;
        } else if (tipo_ficha == 'serie') {
            url_ficha = BASE_URL + '/tv/' + id_ficha + API_KEY + IDIOMA_ES;
        }

        // Recupero el JSON (data) pasando la url de la ficha y lo meto en la variable "ficha"
        fetch(url_ficha).then(res => res.json()).then(ficha => {
            //console.log(ficha);

            let v_id_tmdb = ficha.id;
            let v_id_imdb = '';
            let v_titulo_e = '';
            let v_titulo_o = '';
            let v_fecha = '';
            let v_duracion = '';
            //let v_lista_paises = [];
            let v_lista_paises = '';
            let v_lista_paises_iso = '';
            //let v_lista_productoras = [];
            let v_lista_productoras = '';
            let v_sinopsis = ficha.overview;
            let v_lista_directores = '';

            let v_poster = '';
            if (ficha.backdrop_path != null) {
                v_poster = ficha.poster_path;
            }

            // Depende de si es peli o serie, el los datos del json se llaman distinto
            if (tipo_ficha == 'peli') {
                v_id_imdb = ficha.imdb_id;
                v_titulo_e = ficha.title;
                v_titulo_o = ficha.original_title;
                v_fecha = ficha.release_date;
                /*if (ficha.release_date != null && ficha.release_date != '') {
                    v_fecha = ficha.release_date.substr(0,4); // solo año
                }*/
                v_duracion = ficha.runtime;

            } else if (tipo_ficha == 'serie') {
                v_id_imdb = 'Serie';
                v_titulo_e = ficha.name;
                v_titulo_o = ficha.original_name;
                v_fecha = ficha.first_air_date;
                /*if (ficha.first_air_date != null && ficha.release_date != '') {
                    v_fecha = ficha.first_air_date.substr(0,4); // solo año
                }*/
                v_duracion = ficha.episode_run_time[0];
                if (v_duracion === undefined) {
                    v_duracion = '';
                }

                // Director solo para series (porque la api lo da en esta misma url)
                ficha.created_by.forEach(creador => {
                    v_lista_directores += creador.name + ', ';
                });
            }

            ficha.production_countries.forEach(pais => {
                v_lista_paises += pais.name + ', ';
                if (pais.iso_3166_1) {
                    v_lista_paises_iso += String(pais.iso_3166_1).toLowerCase() + ', ';
                }
            });

            ficha.production_companies.forEach(productora => {
                //v_lista_productoras.push(productora.name);
                v_lista_productoras += productora.name + ', ';
            });

            // COMPRUEBO SI LOS INPUT ESTAN VACIOS. SI NO LO ESTABAN, MUESTRO LOS DATOS DE TMDB COMO SUGERENCIA EN UN PARRAFO
            if ((acf_id_tmdb.value == '' || acf_id_tmdb.value == '0') && v_id_tmdb != '') {
                acf_id_tmdb.readOnly = false;
                acf_id_tmdb.value = v_id_tmdb;
                acf_id_tmdb.readOnly = true;
                sugerencia_id_tmdb.innerHTML = 'Actualizado';
            } else if (acf_id_tmdb.value != v_id_tmdb) {
                sugerencia_id_tmdb.innerHTML = v_id_tmdb;
            }

            if (acf_id_imdb.value == '' && v_id_imdb != '') {
                //acf_id_imdb.readOnly = false;
                acf_id_imdb.value = v_id_imdb;
                //acf_id_imdb.readOnly = true;
                sugerencia_id_imdb.innerHTML = 'Actualizado';
            } else if (acf_id_imdb.value != v_id_imdb) {
                sugerencia_id_imdb.innerHTML = v_id_imdb;
            }

            if (acf_titulo_spanish.value == '' && v_titulo_e != '') {
                acf_titulo_spanish.value = v_titulo_e;
                acf_titulo_spanish.innerHTML = 'Actualizado';
            } else if (acf_titulo_spanish.value != v_titulo_e) {
                sugerencia_titulo_spanish.innerHTML = v_titulo_e;
            }
            if (acf_titulo_original.value == '' && v_titulo_o != '') {
                acf_titulo_original.value = v_titulo_o;
                acf_titulo_original.innerHTML = 'Actualizado';
            } else if (acf_titulo_original.value != v_titulo_o) {
                sugerencia_titulo_original.innerHTML = v_titulo_o;
            }
            
            RellenarTitulosAlternativos(id_ficha);
            
            if (acf_fecha.value == '' && v_fecha != '') {
                acf_fecha.value = v_fecha;
                sugerencia_fecha.innerHTML = 'Actualizado';
            } else if (acf_fecha.value != v_fecha) {
                sugerencia_fecha.innerHTML = v_fecha;
            }
            if (acf_duracion.value == '' && v_duracion != '') {
                acf_duracion.value = v_duracion;
                sugerencia_duracion.innerHTML = 'Actualizado';
            } else if (acf_duracion.value != v_duracion) {
                sugerencia_duracion.innerHTML = v_duracion;
            }

            if (acf_sinopsis.value == '' && v_sinopsis != '') {
                acf_sinopsis.value = v_sinopsis;
                sugerencia_sinopsis.innerHTML = 'Actualizado';
            } else if (acf_sinopsis.value != v_sinopsis) {
                sugerencia_sinopsis.innerHTML = v_sinopsis;
            }
                    
            RellenarPaises(v_lista_paises_iso, v_lista_paises);
            
            if (acf_productoras.value == '' && v_lista_productoras != '') {
                acf_productoras.value = v_lista_productoras.slice(0, -2);
                sugerencia_productoras.innerHTML = 'Actualizado';
            } else if (acf_productoras.value != v_lista_productoras.slice(0, -2)) {
                sugerencia_productoras.innerHTML = v_lista_productoras.slice(0, -2);
            }
            if (acf_directores.value == '' && v_lista_directores != '') {
                acf_directores.value = v_lista_directores.slice(0, -2); // (solo series aqui, peliculas en siguiente funcion)
                sugerencia_directores.innerHTML = 'Actualizado';
            } else if (acf_directores.value != v_lista_directores.slice(0, -2)) {
                sugerencia_directores.innerHTML = v_lista_directores.slice(0, -2);;
            }
            
            RellenarPersonas(id_ficha);
        });
    }

    // FUNCION OBTENER OTROS TITULOS (otros idiomas)
    function RellenarTitulosAlternativos(id_ficha) {
        let url_akas = '';
        if (tipo_ficha == 'peli') {
            url_akas = BASE_URL + '/movie/' + id_ficha + '/alternative_titles' + API_KEY;
        } else if (tipo_ficha == 'serie') {
            url_akas = BASE_URL + '/tv/' + id_ficha + '/alternative_titles' + API_KEY;
        }

        // Recupero el JSON (data) pasando la url de los titulos alternativos y lo meto en la variable "akas"
        fetch(url_akas).then(res => res.json()).then(akas => {
            //console.log(akas);
            let lista_titulos = '';

            // Si tiene datos de titulos, recorro todos los que tenga y los guardo en una variable
            if (akas) {
                // Si es peli, el array del json se llama titles, pero si es serie se llama results
                if (tipo_ficha == 'peli') {
                    if (akas.titles.length > 0) {
                        akas.titles.forEach(titulo => {
                            lista_titulos += titulo.title + ' (' + titulo.iso_3166_1 + ')\n';
                        });
                    }
                } else if (tipo_ficha == 'serie') {
                    if (akas.results.length > 0) {
                        akas.results.forEach(titulo => {
                            lista_titulos += titulo.title + ' (' + titulo.iso_3166_1 + ')\n';
                        });
                    }
                }
            }

            // Actualizo el campo de titulos alternativos
            if (acf_titulos_alternativos.textContent == '' && lista_titulos != '') {
                acf_titulos_alternativos.innerHTML = lista_titulos;
                sugerencia_titulos_alternativos.innerHTML = 'Actualizado';
            } else if (acf_titulos_alternativos.textContent != lista_titulos) {
                sugerencia_titulos_alternativos.innerHTML = lista_titulos;
            }
        });
    }

    // FUNCION RELLENAR DATOS PERSONAS
    function RellenarPersonas(id_ficha) {
        var url_creditos = '';
        if (tipo_ficha == 'peli') {
            var url_creditos = BASE_URL + '/movie/' + id_ficha + '/credits' + API_KEY;
        } else if (tipo_ficha == 'serie') {
            var url_creditos = BASE_URL + '/tv/' + id_ficha + '/credits' + API_KEY;
        }

        // Obtenemos los creditos de la ficha
        fetch(url_creditos).then(res => res.json()).then(creditos => {
            console.log(creditos);

            // Si tiene datos de personas...
            if (creditos) {
                let reparto = '';
                let contador_actores = 0; // para guardar solo 10 actores
                creditos.cast.forEach(actor => {
                    if (contador_actores < 10) {
                        reparto += actor.name + ', ';
                    }
                    contador_actores++;
                });

                var direccion = '';
                var guion = '';
                var montaje = '';
                var musica = '';
                var fotografia = '';
                var productor = '';

                creditos.crew.forEach(persona => {
                    if (persona.job == 'Director') {
                        direccion += persona.original_name + ', ';
                    } else if (persona.job == 'Screenplay' || persona.job == 'Writer') {
                        guion += persona.original_name + ', ';
                    } else if (persona.job == 'Editor') {
                        montaje += persona.original_name + ', ';
                    } else if (persona.job == 'Original Music Composer') {
                        musica += persona.original_name + ', ';
                    } else if (persona.job == 'Director of Photography') {
                        fotografia += persona.original_name + ', ';
                    } else if (persona.job == 'Producer' || persona.job == 'Executive Producer') {
                        if (tipo_ficha == 'serie') {
                            if (persona.known_for_department == 'Directing') {
                                direccion += persona.original_name + ', ';
                            } else if (persona.known_for_department == 'Writing') {
                                guion += persona.original_name + ', ';
                            } else if (persona.known_for_department == 'Production') {
                                productor += persona.original_name + ', ';
                            }
                        } else {
                            productor += persona.original_name + ', ';
                        }
                    }
                });

                if (tipo_ficha == 'peli') {
                    if (acf_directores.value == '' && direccion != '') {
                        acf_directores.value = direccion.slice(0, -2); // quito ultima ,
                        sugerencia_directores.innerHTML = 'Actualizado';
                    } else if (acf_directores.value != direccion.slice(0, -2)) {
                        sugerencia_directores.innerHTML = direccion.slice(0, -2);
                    }
                }
                if (acf_reparto.value == '' && reparto != '') {
                    acf_reparto.value = reparto.slice(0, -2);
                    sugerencia_reparto.innerHTML = 'Actualizado';
                } else if (acf_reparto.value != reparto.slice(0, -2)) {
                    sugerencia_reparto.innerHTML = reparto.slice(0, -2);
                }
                if (acf_guion.value == '' && guion != '') {
                    acf_guion.value = guion.slice(0, -2);
                    sugerencia_guion.innerHTML = 'Actualizado';
                } else if (acf_guion.value != guion.slice(0, -2)) {
                   sugerencia_guion.innerHTML = guion.slice(0, -2);
                }
                if (acf_musica.value == '' && musica != '') {
                    acf_musica.value = musica.slice(0, -2);
                    sugerencia_musica.innerHTML = 'Actualizado';
                } else if (acf_musica.value != musica.slice(0, -2)) {
                    sugerencia_musica.innerHTML = musica.slice(0, -2);
                }
                if (acf_fotografia.value == '' && fotografia != '') {
                    acf_fotografia.value = fotografia.slice(0, -2);
                    sugerencia_fotografia.innerHTML = 'Actualizado';
                } else if (acf_fotografia.value != fotografia.slice(0, -2)) {
                    sugerencia_fotografia.innerHTML = fotografia.slice(0, -2);
                }
            }
        });
    }

    // FUNCION OBTENER POSTERS DE LA PELICULA ELEGIDA
    function MostrarImagenes(id_ficha) {
        var url_imagenes = '';
        if (tipo_ficha == 'peli') {
            url_imagenes = BASE_URL + '/movie/' + id_ficha + '/images' + API_KEY;
        } else if (tipo_ficha == 'serie') {
            url_imagenes = BASE_URL + '/tv/' + id_ficha + '/images' + API_KEY;
        }

        fetch(url_imagenes).then(res => res.json()).then(imageData => {
            //console.log(imageData);

            // Si tiene datos de posters, recorro todas los que tenga
            if (imageData) {
                if (imageData.posters.length > 0) {
                    let contenido = '';

                    imageData.posters.forEach(poster => {
                        contenido += '<td><img src="https://image.tmdb.org/t/p/w500' + poster.file_path + '" onclick="ListenerClickPoster(this.src)"></td>';
                    });
                    
                    contenedor_posters.innerHTML = '<h3>Pósters Disponibles</h3>(Sólo si quieres cambiarlo)' + '<div class="table-responsive"><table><tr>' + contenido + '</tr></table></div>';
                }
            }
        });
    }

    function ListenerClickPoster(url_nuevo_poster) {
        contenedor_posters.innerHTML = 'Has cambiado el poster de la ficha. Si te has equivocado, recarga la página.';
        //acf_poster.readOnly = false;
        acf_poster.value = url_nuevo_poster; // es type hide
        //acf_poster.readOnly = true;
        document.getElementById('img_poster').src = url_nuevo_poster;
    }
    
    function RellenarPaises(v_lista_paises_iso, v_lista_paises) {
        // Con ISO podemos pre-seleccionar en el <select> y para el texto rojo
        // usamos los nombres ya existentes en la taxonomy (consistencia total).
        if (v_lista_paises_iso != '') {
            let lista_iso = v_lista_paises_iso.slice(0, -2).split(', ');
            let lista_mostrada = [];

            var tieneSeleccionActual = false;
            if (select_paises != null && select_paises.selectedOptions && select_paises.selectedOptions.length > 0) {
                tieneSeleccionActual = true;
            }

            if (select_paises != null) {
                lista_iso.forEach(function(code){
                    code = String(code || '').trim().toLowerCase();
                    if (!code) return;

                    var opt = select_paises.querySelector('option[value="' + code + '"]');
                    if (opt) {
                        // Si la ficha ya tenía países seleccionados, no tocamos el select:
                        // solo mostramos la sugerencia en rojo (igual que en actores).
                        if (!tieneSeleccionActual) opt.selected = true;
                        var label = (opt.textContent || '').trim(); // "Afganistán (af)"
                        label = label.replace(/\s*\([^)]+\)\s*$/, ''); // "Afganistán"
                        lista_mostrada.push(label);
                    } else {
                        // Si TMDB devuelve un ISO que no tenemos, mostramos el ISO crudo como guía.
                        lista_mostrada.push(code.toUpperCase());
                    }
                });
            } else {
                lista_mostrada = lista_iso
                    .map(function(code){ return String(code || '').trim().toUpperCase(); })
                    .filter(function(x){ return x !== ''; });
            }

            // Si no hemos resuelto nada, fallback.
            if (lista_mostrada.length === 0) {
                lista_mostrada = lista_iso
                    .map(function(code){ return String(code || '').trim().toUpperCase(); })
                    .filter(function(x){ return x !== ''; });
            }

            let texto = lista_mostrada.join(', ');
            if (acf_paises != null) {
                if (acf_paises.value == '') {
                    acf_paises.value = texto;
                    if (sugerencia_paises != null) sugerencia_paises.innerHTML = 'Actualizado';
                } else if (acf_paises.value != texto) {
                    if (sugerencia_paises != null) sugerencia_paises.innerHTML = texto;
                }
            } else if (sugerencia_paises != null) {
                sugerencia_paises.innerHTML = texto;
            }
        }
    }
</script>