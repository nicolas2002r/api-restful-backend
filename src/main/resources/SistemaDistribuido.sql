CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);
CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    rol_id INT REFERENCES roles(id)
);
CREATE TABLE programa_academico (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
CREATE TABLE programa_academico_usuario (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuario(id),
    programa_academico_id INT REFERENCES programa_academico(id),
    UNIQUE (usuario_id, programa_academico_id)
);
INSERT INTO roles (nombre)
VALUES
('Docente'),
('Decano'),
('Director de Programa');


INSERT INTO usuario (nombre, apellido, dni, correo, rol_id)
VALUES
('Juan', 'Pérez', '12345678', 'juan.perez@example.com', 1), -- Docente
('María', 'Gómez', '87654321', 'maria.gomez@example.com', 2), -- Decano
('Carlos', 'López', '45678912', 'carlos.lopez@example.com', 3); -- Director de Programa


INSERT INTO programa_academico (nombre)
VALUES
('Ingeniería de Sistemas'),
('Ingeniería Industrial'),
('Ingeniería Mecatronica'),
('Ingeniería Energias Renovables');

INSERT INTO programa_academico_usuario (usuario_id, programa_academico_id)
VALUES
(1, 1), -- Juan Pérez accede a Ingeniería de Sistemas
(2, 2), -- María Gómez accede a Ingeniería Industrial
(3, 1), -- Carlos López accede a Ingeniería de Sistemas
(3, 2); -- Carlos López accede a Ingeniería Industrial






SELECT u.nombre, u.apellido, r.nombre AS rol, pa.nombre AS programa_academico
FROM usuario u
JOIN roles r ON u.rol_id = r.id
JOIN programa_academico_usuario pau ON u.id = pau.usuario_id
JOIN programa_academico pa ON pau.programa_academico_id = pa.id;

select * from programa_academico;
SELECT * FROM roles WHERE nombre = 'Decano';


----------------------------------------------------------------------------------------------------------------------

CREATE TABLE actividades (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT
);

CREATE TABLE sub_actividades (
    id SERIAL PRIMARY KEY,
    actividad_id INT REFERENCES actividades(id) ON DELETE CASCADE,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT
);

CREATE TABLE tareas (
    id SERIAL PRIMARY KEY,
    sub_actividad_id INT REFERENCES sub_actividades(id) ON DELETE CASCADE,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    asignable BOOLEAN DEFAULT TRUE
);

SELECT a.nombre AS actividad, sa.nombre AS sub_actividad
FROM actividades a
JOIN sub_actividades sa ON a.id = sa.actividad_id;

SELECT sa.nombre AS sub_actividad, t.nombre AS tarea
FROM sub_actividades sa
JOIN tareas t ON sa.id = t.sub_actividad_id;

SELECT a.nombre AS actividad, sa.nombre AS sub_actividad, t.nombre AS tarea
FROM actividades a
JOIN sub_actividades sa ON a.id = sa.actividad_id
JOIN tareas t ON sa.id = t.sub_actividad_id;

----------------------------------------------- Insersion a la tabla de actividades -----------------------------------------------
INSERT INTO actividades (nombre, descripcion) VALUES
('Académicas', 'Actividades relacionadas con la docencia y enseñanza'),
('Formativas', 'Actividades orientadas a la formación continua'),
('Labores científicas', 'Investigación y producción científica'),
('Extensiones', 'Actividades de extensión universitaria'),
('Culturales', 'Promoción y participación en actividades culturales'),
('Gestión Académica - Administrativa', 'Tareas de gestión académica y administrativa');

----------------------------------------------- Insersion a la tabla de sub_actividades -----------------------------------------------
-- Sub-actividades para la actividad "Académicas" (ID 1)
INSERT INTO sub_actividades (actividad_id, nombre, descripcion) VALUES
(1, 'Preparación de clases', 'Diseño y preparación de contenido educativo'),
(1, 'Evaluación de aprendizajes a estudiantes', 'Elaboración y corrección de evaluaciones'),
(1, 'Gestión de eventos académicos', 'Eventos académico de la institución');

-- Sub-actividades para la actividad "Formativas" (ID 2)
INSERT INTO sub_actividades (actividad_id, nombre, descripcion) VALUES
(2, 'Acompañamiento académico a estudiantes', 'Guiar las actividades de los estudiantes'),
(2, 'Cursos de fortalecimiento dirigido a estudiantes', 'Contribución a la formación integral de los estudiantes'),
(2, 'Asesoría en emprendimiento', 'Brinda apoyo a emprendedores para mejorar su negocio');

-- Sub-actividades para la actividad "Labores científicas" (ID 3)
INSERT INTO sub_actividades (actividad_id, nombre, descripcion) VALUES
(3, 'Gestión de semilleros de investigación ', 'Realización de investigación en un proceso de semillero'),
(3, 'Elaboración de propuestas para convocatorias de CTeI', 'busca generar nuevo conocimiento, mejorar una situación, aprovechar una oportunidad, responder o solucionar una necesidad o un problema existente'),
(3, 'Gestión de proyectos de investigación en CTeI', 'proceso que busca formular, proponer y ejecutar proyectos de CTeI aplicada'),
(3, 'Dirección de grupos de investigación', 'generar políticas y estrategias para fomentar la investigación en la institución'),
(3, 'Elaboración de artículos científicos y textos académicos', 'implica cumplir con normas específicas de estructura y contenido');

-- Sub-actividades para la actividad "Extensiones" (ID 4)
INSERT INTO sub_actividades (actividad_id, nombre, descripcion) VALUES
(4, 'Gestión de proyectos de consultoría', 'Una consultoría es una empresa o una práctica empresarial que brinda asesoramiento experto a otras personas.'),
(4, 'Acompañamiento al sector empresarial', 'proceso de análisis de la empresa que sirve para establecer nuevos retos, diseñar planes operativos y hacer una medición del impacto.'),
(4, 'Participación en proyectos de intervención comunitaria', 'ciudadanos se organizan para identificar y buscar soluciones a sus necesidades e intereses, y para tomar decisiones sobre su comunidad');

-- Sub-actividades para la actividad "Culturales" (ID 5)
INSERT INTO sub_actividades (actividad_id, nombre, descripcion) VALUES
(5, 'Gestión de proyectos culturales', 'se encarga de planificar, organizar y coordinar proyectos, eventos y actividades culturales.'),
(5, 'Promoción de la educación artística', 'conjunto de actividades y estrategias que buscan difundir y valorar el arte y la cultura.');

-- Sub-actividades para la actividad "Gestión Académica - Administrativa" (ID 6)
INSERT INTO sub_actividades (actividad_id, nombre, descripcion) VALUES
(6, 'Participación como jurado y/o asesor académico en trabajos de grado', 'guía y orienta el proceso de investigación de manera personalizada.'),
(6, 'Participación en procesos de registros calificados', 'demuestra ante el mismo que reúne las condiciones de calidad que la ley exige.'),
(6, 'Participación en procesos de acreditación', 'son una fuente clave para la Comisión Nacional de Acreditación (CNA).'),
(6, 'Participación en Consejos y Comités', 'representar los intereses colectivos de los y las habitantes de la colonia ante las diversas autoridades.'),
(6, 'Participación en procesos de autoevaluación', 'participación en diferentes tipos de autoevaluación, como la de empleados, estudiantes, o en instituciones educativas'),
(6, 'Participación en Investigaciones de mercado', 'proceso de recolección, análisis e interpretación de información sobre un mercado, para ayudar a las empresas a tomar decisiones informadas y mejorar su rendimiento.'),
(6, 'Participación en procesos de formación de profesores', 'capacitación docente, que es un proceso que permite a los docentes actualizar y perfeccionar sus conocimientos y habilidades.'),
(6, 'Programación y gestión de prácticas extramuros', 'actividades académicas que se realizan fuera del salón de clase, con el objetivo de ofrecer a los estudiantes experiencias que les permitan ampliar sus conocimientos y desarrollar su pensamiento.'),
(6, 'Elaboración de exámenes para validaciones', 'proceso que se encarga de verificar la precisión de los resultados, interpretaciones y uso previsto de una prueba.'),
(6, 'Líder de CTeI, extensión y proyección social', 'promueve la interacción con los diferentes sectores de la sociedad.'),
(6, 'Líder de resultados de aprendizaje', 'liderazgo que se centra en la responsabilidad individual y grupal para alcanzar metas y objetivos.');

----------------------------------------------- Insersion a la tabla de tareas -----------------------------------------------
-- Tareas para la sub-actividad "Preparación de clases" (ID 1)
INSERT INTO tareas (sub_actividad_id, nombre, descripcion) VALUES
(1, 'Diseñar el programa del curso', 'Creación del programa de estudio'),
(1, 'Actualizar materiales de clase', 'Revisión y actualización de los materiales de clase');

-- Tareas para la sub-actividad "Evaluaciones" (ID 2)
INSERT INTO tareas (sub_actividad_id, nombre, descripcion) VALUES
(2, 'Diseñar exámenes', 'Creación de exámenes para los estudiantes'),
(2, 'Corregir exámenes', 'Corrección y retroalimentación de exámenes');

-- Tareas para la sub-actividad "Cursos de formación" (ID 3)
INSERT INTO tareas (sub_actividad_id, nombre, descripcion) VALUES
(3, 'Inscribirse en curso', 'Proceso de inscripción en cursos de formación'),
(3, 'Completar curso', 'Participar y completar un curso formativo');

-- Tareas para la sub-actividad "Investigación de campo" (ID 5)
INSERT INTO tareas (sub_actividad_id, nombre, descripcion) VALUES
(5, 'Recolección de datos', 'Realización de actividades de campo para recolectar datos'),
(5, 'Análisis de datos', 'Análisis e interpretación de los datos recolectados');

-- Tareas para la sub-actividad "Charlas educativas" (ID 7)
INSERT INTO tareas (sub_actividad_id, nombre, descripcion) VALUES
(7, 'Preparar presentación', 'Preparar una presentación para la charla'),
(7, 'Impartir charla', 'Realización de la charla educativa');

-- Tareas para la sub-actividad "Organización de eventos" (ID 9)
INSERT INTO tareas (sub_actividad_id, nombre, descripcion) VALUES
(9, 'Coordinar logística', 'Planificación y coordinación de la logística del evento'),
(9, 'Invitar a los participantes', 'Organización de las invitaciones para los participantes');

-- Tareas para la sub-actividad "Reuniones administrativas" (ID 11)
INSERT INTO tareas (sub_actividad_id, nombre, descripcion) VALUES
(11, 'Organizar agenda', 'Preparación de la agenda para la reunión'),
(11, 'Redactar acta', 'Redacción del acta de la reunión');

SELECT a.nombre AS actividad, sa.nombre AS sub_actividad, t.nombre AS tarea
FROM actividades a
JOIN sub_actividades sa ON a.id = sa.actividad_id
JOIN tareas t ON sa.id = t.sub_actividad_id;

----------------------------------------------------------------------------------------------------------------------

-- Crear tabla de asociación entre roles y actividades
CREATE TABLE roles_actividades (
id SERIAL PRIMARY KEY,
rol_id INT REFERENCES roles(id) ON DELETE CASCADE,
actividad_id INT REFERENCES actividades(id) ON DELETE CASCADE,
UNIQUE (rol_id, actividad_id)
);

-- Crear tabla de asociación entre roles y sub_actividades
CREATE TABLE roles_sub_actividades (
id SERIAL PRIMARY KEY,
rol_id INT REFERENCES roles(id) ON DELETE CASCADE,
sub_actividad_id INT REFERENCES sub_actividades(id) ON DELETE CASCADE,
UNIQUE (rol_id, sub_actividad_id)
);

-- Crear tabla de asociación entre roles y tareas
CREATE TABLE roles_tareas (
id SERIAL PRIMARY KEY,
rol_id INT REFERENCES roles(id) ON DELETE CASCADE,
tarea_id INT REFERENCES tareas(id) ON DELETE CASCADE,
UNIQUE (rol_id, tarea_id)
);

-- Obtener el ID del rol Docente
SELECT id FROM roles WHERE nombre = 'Docente';

-- Supongamos que el ID del rol Docente es 1, se utilizará ese ID para las siguientes inserciones.

-- Asociar el rol Docente con actividades
INSERT INTO roles_actividades (rol_id, actividad_id) VALUES
(1, 1), -- Docente asociado a la actividad "Académicas"
(1, 2); -- Docente asociado a la actividad "Formativas"

-- Asociar el rol Docente con sub-actividades de la actividad "Académicas"
INSERT INTO roles_sub_actividades (rol_id, sub_actividad_id) VALUES
(1, 1), -- Docente asociado a la sub-actividad "Preparación de clases"
(1, 2); -- Docente asociado a la sub-actividad "Evaluaciones"

-- Asociar el rol Docente con tareas de la sub-actividad "Preparación de clases"
INSERT INTO roles_tareas (rol_id, tarea_id) VALUES
(1, 1), -- Docente asociado a la tarea "Diseñar el programa del curso"
(1, 2); -- Docente asociado a la tarea "Actualizar materiales de clase"

SELECT r.nombre AS rol, a.nombre AS actividad
FROM roles r
JOIN roles_actividades ra ON r.id = ra.rol_id
JOIN actividades a ON ra.actividad_id = a.id
WHERE r.nombre = 'Docente';

SELECT r.nombre AS rol, sa.nombre AS sub_actividad
FROM roles r
JOIN roles_sub_actividades rsa ON r.id = rsa.rol_id
JOIN sub_actividades sa ON rsa.sub_actividad_id = sa.id
WHERE r.nombre = 'Docente';

SELECT r.nombre AS rol, t.nombre AS tarea
FROM roles r
JOIN roles_tareas rt ON r.id = rt.rol_id
JOIN tareas t ON rt.tarea_id = t.id
WHERE r.nombre = 'Docente';

SELECT * FROM roles;
