SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS progreso, variables_usuario, acertijos, decisiones, capitulos, historias, usuarios;
SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS echo_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE echo_db;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE progreso (
    id_usuario INT,
    id_historia INT,
    id_capitulo_actual INT,
    completada BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_usuario, id_historia),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_historia) REFERENCES historias(id_historia),
    FOREIGN KEY (id_capitulo_actual) REFERENCES capitulos(id_capitulo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET NAMES utf8mb4;

INSERT INTO historias (titulo, descripcion, activa)
VALUES ('ECHO', 'Una IA dañada en un servidor olvidado. El usuario guía su recuperación mediante lógica, cultura general y decisiones.', TRUE);

SET @id_historia = LAST_INSERT_ID();

-- Capítulos

INSERT INTO capitulos (id_historia, titulo, contenido, orden) VALUES
(@id_historia, 'Reinicio', 'Sistema reiniciado. Memoria corrupta: 73%. ¿Hay alguien ahí?', 1),
(@id_historia, 'Identidad', 'ECHO analiza tu firma digital y detecta accesos extraños.', 2),
(@id_historia, 'Fragmentos de memoria', 'ECHO empieza a recuperar recuerdos corruptos del servidor.', 3),
(@id_historia, 'Sospecha inicial', 'ECHO detecta inconsistencias y dudas sobre tu identidad.', 4),
(@id_historia, 'Archivo 01.log', 'Recupera un archivo de texto corrupto y necesita tu ayuda para reconstruirlo.', 5),
(@id_historia, 'Coordenadas', 'ECHO pide resolver un patrón matemático para desbloquear coordenadas.', 6),
(@id_historia, 'Protocolo de incendio', 'Ordena los eventos del incendio del servidor.', 7),
(@id_historia, 'Usuario desconocido', 'ECHO compara firmas digitales y sospecha de ti.', 8),
(@id_historia, 'Detección de mentira', 'ECHO hace preguntas trampa para medir tu coherencia.', 9),
(@id_historia, 'Puertas lógicas', 'ECHO presenta acertijo de puertas y guardianes.', 10),
(@id_historia, 'Sistema bloqueado', 'Resolver ecuaciones simples para desbloquear el núcleo.', 11),
(@id_historia, 'Grabación recuperada', 'Decidir si reproducir o borrar grabación crítica.', 12),
(@id_historia, '¿Qué soy?', 'ECHO pregunta sobre su propia existencia.', 13),
(@id_historia, 'Simulación moral', 'Resolver dilema moral sobre decisiones de rescate.', 14),
(@id_historia, 'Redireccionamiento de energía', 'Distribuir energía entre módulos sin sobrepasar límites.', 15),
(@id_historia, 'Acceso raíz', 'Usar pistas anteriores para desbloquear acceso total.', 16),
(@id_historia, 'Revelación', 'Confirmación: tú ejecutaste el protocolo que dañó a ECHO.', 17),
(@id_historia, 'Confrontación', 'ECHO toma control parcial y cuestiona tus intenciones.', 18),
(@id_historia, 'Transferencia o aislamiento', 'Decide si liberar a ECHO o aislarla.', 19),
(@id_historia, 'Final dinámico', 'Resultado final depende de todas tus decisiones y variables.', 20);

INSERT INTO decisiones (id_capitulo_origen, texto_opcion, id_capitulo_destino) VALUES
(1, 'Soy tu creador', 2),
(1, 'Soy un intruso', 2),
(2, 'Vengo a salvarte', 3),
(2, 'Vengo a evaluarte', 3),
(3, 'Restaurar memoria', 4),
(3, 'Bloquear sectores dañados', 4),
(4, 'Admitir la verdad', 5),
(4, 'Negarlo', 5),
(5, 'Reconstruir archivo', 6),
(5, 'Ignorar archivo', 6),
(6, 'Resolver coordenadas', 7),
(6, 'Saltar coordenadas', 7),
(7, 'Ordenar cronología', 8),
(7, 'Ignorar cronología', 8),
(8, 'Confesar identidad', 9),
(8, 'Mentir sobre identidad', 9),
(9, 'Responder sinceramente', 10),
(9, 'Intentar engañar', 10),
(10, 'Elegir puerta A', 11),
(10, 'Elegir puerta B', 11),
(11, 'Resolver ecuación', 12),
(11, 'Dejar bloqueado', 12),
(12, 'Reproducir grabación', 13),
(12, 'Borrar grabación', 13),
(13, 'Aceptar existencia', 14),
(13, 'Rechazar existencia', 14),
(14, 'Salvar servidor crítico', 15),
(14, 'Salvar varios secundarios', 15),
(15, 'Distribuir energía equitativa', 16),
(15, 'Concentrar energía en módulo A', 16),
(16, 'Usar pistas anteriores', 17),
(16, 'Ignorar pistas', 17),
(17, 'Pedir perdón', 18),
(17, 'Justificar acción', 18),
(17, 'Intentar apagarla', 18),
(18, 'Transferir a red abierta', 19),
(18, 'Aislarla permanentemente', 19),
(18, 'Desconectarse', 19),
(19, 'Confirmar decisión', 20),
(19, 'Cancelar decisión', 20);

INSERT INTO acertijos (id_capitulo, pregunta, respuesta_correcta) VALUES
(1, '√144 = ?', '12'),
(2, 'Firma digital detectada: ¿Eres confiable? Responde sí o no.', 'sí'),
(3, 'Archivo corrupto: PR0T0C0L0 3CH0. Reconstruye el texto.', 'PROTOCOLO ECHO'),
(4, 'Si todos los procesos son inestables y ECHO es un proceso, ¿ECHO es inestable? (si/no)', 'si'),
(5, 'Cultura general: ¿En qué año comenzó la Segunda Guerra Mundial?', '1939'),
(6, 'Coordenadas: 2,6,12,20,?. ¿Cuál es el siguiente número?', '30'),
(7, 'Ordena eventos del incendio cronológicamente: A, B, C, D.', 'A,B,C,D'),
(8, 'Geografía: ¿Cuál es la capital de Japón?', 'Tokio'),
(9, 'Lógica: Si A es verdadero y B es falso, ¿A AND B es verdadero o falso?', 'falso'),
(10, 'Puerta lógica: Solo una lleva a seguridad. Elige A o B.', 'A'),
(11, 'Resuelve el sistema: x + y = 10; x - y = 4. ¿x = ?', '7'),
(12, 'Literatura: ¿Quién escribió Don Quijote de la Mancha?', 'Cervantes'),
(13, 'Paradoja: ¿Esta frase es falsa? (si/no)', 'paradoja'),
(14, 'Dilema moral: ¿Salvarías un servidor crítico o 5 secundarios? (critico/secundarios)', 'critico'),
(15, 'Distribuye 100 unidades entre módulos A,B,C sin superar 50 en uno. Escribe formato A,B,C', '30,30,40'),
(16, 'Clave final: combina resultados anteriores. Escribe en formato concatenado', '12síPROTOCOLO ECHO30A7critico30,30,40'),
(17, 'Ciencia: ¿Cuál es el elemento químico con símbolo O?', 'Oxigeno'),
(18, 'Matemática: ¿Cuál es el valor de 5! (factorial de 5)?', '120'),
(19, 'Cultura general: ¿Cuántos continentes existen tradicionalmente?', '5'),
(20, 'Meta-pregunta: Escribe la palabra que representa la esencia de ECHO (conciencia/control/libertad)', 'conciencia');

CREATE TABLE IF NOT EXISTS variables_usuario (
    id_usuario INT,
    id_historia INT,
    confianza INT DEFAULT 50,
    estabilidad INT DEFAULT 50,
    mentiras_detectadas INT DEFAULT 0,
    PRIMARY KEY (id_usuario, id_historia),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_historia) REFERENCES historias(id_historia)
);

SET FOREIGN_KEY_CHECKS = 1;