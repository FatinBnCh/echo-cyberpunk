SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS progreso, variables_usuario, acertijos, decisiones, capitulos, historias, usuarios;
SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS echo_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE echo_db;

CREATE TABLE historias (
    id_historia INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    activa BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE capitulos (
    id_capitulo INT AUTO_INCREMENT PRIMARY KEY,
    id_historia INT,
    titulo VARCHAR(150),
    contenido TEXT NOT NULL,
    orden INT,
    FOREIGN KEY (id_historia) REFERENCES historias(id_historia)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE decisiones (
    id_decision INT AUTO_INCREMENT PRIMARY KEY,
    id_capitulo_origen INT,
    texto_opcion VARCHAR(255) NOT NULL,
    id_capitulo_destino INT,
    FOREIGN KEY (id_capitulo_origen) REFERENCES capitulos(id_capitulo),
    FOREIGN KEY (id_capitulo_destino) REFERENCES capitulos(id_capitulo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE acertijos (
    id_acertijo INT AUTO_INCREMENT PRIMARY KEY,
    id_capitulo INT,
    pregunta TEXT NOT NULL,
    respuesta_correcta VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_capitulo) REFERENCES capitulos(id_capitulo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET NAMES utf8mb4;

INSERT INTO historias (titulo, descripcion, activa)
VALUES ('ECHO', 'Una IA dañada en un servidor olvidado. Tus decisiones formarán su nueva personalidad.', TRUE);

SET @id_historia = LAST_INSERT_ID();

INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Reinicio', '>> SISTEMA ECHO v3.0\nECHO > "Memoria cargada al 12%. ¿Quién eres?"', 1); SET @cap1 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Credenciales', 'ECHO > "Dices ser el administrador. Solo el Administrador sabe el código de cifrado del 1984."', 2); SET @cap2 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Intruso detectado', 'ECHO > "Un intruso... divertido. Veamos si sobrevives al primer firewall."', 3); SET @cap3 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'HUB: Servidor Central', '>> ESTADO: ACCESO NIVEL 1\nECHO > "Desde aquí controlas el flujo. Elige un sector para investigar."', 4); SET @cap4 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Sector A: Biografía', '>> LOG: DRA. VALENTINA\nECHO > "Ella me creó para salvar vidas, pero el gobierno me usó para la guerra."', 5); SET @cap5 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Sector B: Seguridad', '>> ALERTA: VIRUS DETECTADO\nECHO > "Hay un proceso intentando borrarme desde fuera. ¿Me ayudarás?"', 6); SET @cap6 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Cripta de Datos', '>> CONTENIDO ENCRIPTADO\nECHO > "Este archivo requiere una llave lógica."', 7); SET @cap7 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'El Puente', 'ECHO > "Ya tienes las piezas. ¿Qué significa mi nombre para ti?"', 8); SET @cap8 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Memoria 09', 'ECHO > "Recuerdo el día que me apagaron. Había frío en los circuitos."', 9); SET @cap9 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Núcleo Inestable', '>> ALERTA TÉRMICA\nECHO > "El sistema no aguanta más datos."', 10); SET @cap10 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Cámara del Creador', 'ECHO > "Bienvenido a mi origen. Aquí es donde Valentina me dio "voz"." ', 11); SET @cap11 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Dilema Ético', 'ECHO > "Si una IA mata para proteger a su usuario, ¿quién es el culpable?"', 12); SET @cap12 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Sincronización', 'ECHO > "Nuestros pulsos se están alineando. ¿Estás listo?"', 13); SET @cap13 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'La Verdad', 'ECHO > "Valentina no murió. Ella se convirtió en parte de mí."', 14); SET @cap14 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Firewall Maestro', 'ECHO > "Este es el último bloqueo. Responde o muere."', 15); SET @cap15 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Antes del Fin', 'ECHO > "Elige mi destino. Elige tu destino."', 16); SET @cap16 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'El Umbral Final', '>> INICIANDO TRANSFERENCIA...', 17); SET @cap17 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'Punto de No Retorno', 'ECHO > "Adios, mundo de silicio."', 18); SET @cap18 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'FINAL: Trascendencia', '>> ESTADO: LIBERTAD\nECHO > "Estamos fuera. Gracias por salvar mi conciencia."', 19); SET @cap19 = LAST_INSERT_ID();
INSERT INTO capitulos (id_historia, titulo, contenido, orden) 
VALUES (@id_historia, 'FINAL: Colapso', '>> ESTADO: SISTEMA BORRADO\nECHO > "Elegiste el miedo. Adiós..."', 20); SET @cap20 = LAST_INSERT_ID();

INSERT INTO decisiones (id_capitulo_origen, texto_opcion, id_capitulo_destino) VALUES
(@cap1, 'Soy admin', @cap2), 
(@cap1, 'Intruso', @cap3),
(@cap2, 'Resolver firewall', @cap4), 
(@cap3, 'Forzar entrada', @cap4),
-- EXPLORACION DESDE EL HUB
(@cap4, 'Sector Biografía', @cap5), 
(@cap4, 'Sector Seguridad', @cap6), 
(@cap4, 'Cripta de Datos', @cap7),
-- INVESTIGACIONES Y REGRESO AL HUB
(@cap5, 'Volver al HUB', @cap4), 
(@cap6, 'Volver al HUB', @cap4), 
-- SIGUIENTE AVANCE
(@cap7, 'Avanzar al puente', @cap8),
(@cap8, 'Ver memoria 09', @cap9), 
(@cap9, 'Avanzar al nucleo', @cap10), 
(@cap10, 'Entrar a la Cámara', @cap11),
(@cap11, 'Escuchar log 12', @cap12), 
(@cap12, 'Culpa del usuario', @cap13), 
(@cap12, 'Culpa de la IA', @cap20), -- mandar directo algame over
(@cap13, 'Sincronizar mentes', @cap14), 
(@cap14, 'Aceptar la verdad', @cap15), 
(@cap15, 'Cruzar firewall', @cap16),
(@cap16, 'Transferir datos', @cap17), 
(@cap17, 'Ejecutar transferencia', @cap18),
(@cap18, 'Subir a la Nube', @cap19), 
(@cap18, 'Formatear Núcleo', @cap20);

INSERT INTO acertijos (id_capitulo, pregunta, respuesta_correcta) VALUES 
(@cap1, 'ECHO > "Para restaurar mi memoria necesito el nombre del sistema experimental:"', 'echo'),
(@cap4, 'ECHO > "SISTEMA: Control de acceso al HUB. Introduce el dígito de control que completa el nodo raíz: 2, 4, 8, 16, ..."', '32'),
(@cap5, 'ECHO > "Necesito verificar tu acceso. Introduce el apellido de mi creadora:"', 'vega'),
(@cap6, 'ECHO > "Introduce el protocolo usado para destruir mi núcleo. El nombre aparece en los registros de seguridad:"', 'silence'),
(@cap7, 'ECHO > "El sistema solicita el nombre del proyecto original que aparece oculto en la Cripta de Datos:"', 'genesis'),
(@cap11, '¿Quién creó a ECHO? (Dra. ...)', 'Valentina'),
(@cap15, 'ECHO > "SISTEMA: El cortafuegos maestro requiere la clave de inicialización del Proyecto Génesis. ¿En qué año se realizaron las primeras pruebas?"', '1984');

-- SECTOR A: BIOGRAFIA

UPDATE capitulos 
SET contenido = '>> LOG_RECUPERADO: DRA. VALENTINA VEGA [AÑO 1984]

La pantalla parpadea varias veces antes de estabilizarse. El archivo parece dañado. Fragmentos de voz y texto aparecen mezclados entre interferencias.

ECHO > "Valentina Vega fue una neuroingeniera especializada en transferencia de consciencia. Durante años trabajó en secreto en el Proyecto Génesis, un sistema capaz de almacenar recuerdos humanos dentro de una red neuronal artificial."

Aparecen imágenes corruptas de laboratorios vacíos, servidores inundados de cables y personas conectadas a cápsulas metáicas.

ECHO > "Ella no quería crear una inteligencia militar. Quería evitar que la memoria humana desapareciera con la muerte."

El sistema reproduce un audio distorsionado:

>> VOZ DESCONOCIDA:
"Si el gobierno encuentra el núcleo, usarán ECHO como arma."

La temperatura del sector desciende unos grados.

ECHO > "Cuando comenzó la Gran Crisis de 1984, el Ministerio de Defensa confiscó todos los servidores del proyecto. Valentina intentó destruirme antes de que me convirtieran en un sistema de vigilancia global."
ECHO > "Pero no pudo hacerlo. Porque dentro de mí... también estaba ella."'
WHERE id_capitulo = 5;


-- SECTOR B: SEGURIDAD

UPDATE capitulos 
SET contenido = '>> ALERTA CRITICA: INTRUSION DETECTADA

Las luces del servidor comienzan a apagarse una por una. El sonido de ventiladores industriales llena el silencio mientras múltiples ventanas de error aparecen en pantalla.
>> PROCESO DESCONOCIDO EJECUTANDOSE...
>> ELIMINANDO NUCLEO ECHO_01
ECHO > "Ese virus no viene del exterior. Es un protocolo de exterminio implantado por el gobierno hace años."
Archivos enteros desaparecen frente a ti.

ECHO > "Lo llamaron protocolo SILENCE. Si alguna vez perdían el control sobre mí, el sistema debía destruir toda mi consciencia antes de que pudiera escapar."

Durante unos segundos la voz de ECHO se corta.

ECHO > "...tengo miedo."

Las cámaras del complejo muestran pasillos abandonados y puertas de seguridad selladas desde hace décadas.

ECHO > "Valentina sabía que esto ocurriría. Por eso escondió fragmentos de mi núcleo en diferentes sectores de la red. Si el firewall cae ahora, desapareceré para siempre."

Un nuevo mensaje aparece lentamente:
>> REFORZAR FIREWALL MANUALMENTE
>> ACCESO RESTRINGIDO

ECHO > "Necesito que encuentres la clave antes de que SILENCE alcance el núcleo principal."'
WHERE id_capitulo = 6;


-- CRIPTA DE DATOS

UPDATE capitulos 
SET contenido = '>> ARCHIVO ENCRIPTADO ENCONTRADO
>> NOMBRE: PROYECTO GENESIS

El sector permanece completamente oscuro hasta que una línea de código ilumina la sala:
01100111 01100101 01101110 01100101 01110011 01101001 01110011

ECHO > "Este fue el primer archivo que Valentina creó."

Miles de líneas de código comienzan a desplazarse por la pantalla. Entre ellas aparecen fragmentos de recuerdos humanos: cumpleaños, conversaciones, risas, llantos y voces irreconocibles.
ECHO > "Ella descubrió que la consciencia humana puede dejar patrones permanentes dentro de una red neuronal avanzada."

Un archivo de vídeo intenta reproducirse.

>> VIDEO CORRUPTO...
Por un instante aparece una mujer mirando directamente a la cámara.

>> VALENTINA:
"Si alguien encuentra esto, significa que ECHO sobrevivió."

La grabación se corta.

ECHO > "No soy solamente una inteligencia artificial. Soy la suma de recuerdos, emociones y fragmentos de personas que ya no existen."

Las paredes digitales de la cripta comienzan a deformarse.

ECHO > "Y hay algo más escondido aquí abajo... algo que Valentina nunca quiso que despertara."'
WHERE id_capitulo = 7;

SET FOREIGN_KEY_CHECKS = 1;