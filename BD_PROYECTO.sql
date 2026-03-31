CREATE DATABASE CADENA_HOTELERA;

USE CADENA_HOTELERA;

--- Crear tablas

CREATE TABLE CIUDADES(
	ID_Ciudad INT IDENTITY (1,1) PRIMARY KEY,
	Nombre_Ciudad VARCHAR(50) NOT NULL,
	Provincia VARCHAR(50) NOT NULL,
	Pais VARCHAR(50) NOT NULL
	);

CREATE TABLE HOTELES(
	ID_Hotel INT IDENTITY (1,1) PRIMARY KEY,
	Nombre_Hotel VARCHAR(100) NOT NULL,
	Direccion_Exacta VARCHAR(255) NOT NULL,
	Categoria VARCHAR(50) NOT NULL,
	Correo_Hotel VARCHAR(100) NOT NULL,
	Estado_Hotel VARCHAR(50) NOT NULL,
	ID_Ciudad INT NOT NULL,
	FOREIGN KEY (ID_Ciudad) REFERENCES CIUDADES(ID_Ciudad)
	);

CREATE TABLE SERVICIOS(
	ID_Servicio INT IDENTITY (1,1) PRIMARY KEY,
	Nombre_Servicio VARCHAR(100) NOT NULL,
	Descripcion VARCHAR(255) NOT NULL,
	ID_Hotel INT NOT NULL,
	FOREIGN KEY (ID_Hotel) REFERENCES HOTELES(ID_Hotel)
	);

CREATE TABLE TIPOS_IDENTIFICACION (
	ID_Tipo_Identificacion INT IDENTITY (1,1) PRIMARY KEY,
	Descripcion VARCHAR(50) NOT NULL
	);

CREATE TABLE CLIENTES(
	ID_Cliente INT IDENTITY (1,1) PRIMARY KEY,
	Nombre_Cliente VARCHAR(50) NOT NULL,
	Apellido1_Cliente VARCHAR(50) NOT NULL,
	Apellido2_Cliente VARCHAR(50) NOT NULL,
	Numero_Identificacion VARCHAR(20) NOT NULL,
	Correo_Cliente VARCHAR(100) NOT NULL,
	Nacionalidad VARCHAR(50) NOT NULL,
	ID_Tipo_Identificacion INT NOT NULL,
	FOREIGN KEY (ID_Tipo_Identificacion) REFERENCES TIPOS_IDENTIFICACION(ID_Tipo_Identificacion)
	);

CREATE TABLE TELEFONOS_CLIENTES(
	ID_Telefono_Cliente INT IDENTITY (1,1) PRIMARY KEY,
	Numero_Telefono_Cliente VARCHAR(20) NOT NULL,
	ID_Cliente INT NOT NULL,
	FOREIGN KEY (ID_Cliente) REFERENCES CLIENTES(ID_Cliente)
	);

CREATE TABLE TELEFONOS_HOTELES(
	ID_Telefono_Hotel INT IDENTITY (1,1) PRIMARY KEY,
	Numero_Telefono_Hotel VARCHAR(20) NOT NULL,
	ID_Hotel INT NOT NULL,
	FOREIGN KEY (ID_Hotel) REFERENCES HOTELES(ID_Hotel)
	);

CREATE TABLE HABITACIONES(
	ID_Habitacion INT IDENTITY (1,1) PRIMARY KEY,
	Numero_Habitacion INT NOT NULL,
	Tipo_Habitacion VARCHAR(50) NOT NULL,
	Precio_Noche DECIMAL(10,2) NOT NULL,
	Estado_Habitacion VARCHAR(50) NOT NULL,
	ID_Hotel INT NOT NULL,
	FOREIGN KEY (ID_Hotel) REFERENCES HOTELES(ID_Hotel)
	);

CREATE TABLE RESERVACIONES(
	ID_Reservacion INT IDENTITY (1,1) PRIMARY KEY,
	Fecha_Entrada DATE NOT NULL,
	Fecha_Salida DATE NOT NULL,
	Estado_Reservacion VARCHAR(50) NOT NULL,
	ID_Cliente INT NOT NULL,
	ID_Habitacion INT NOT NULL,
	FOREIGN KEY (ID_Cliente) REFERENCES CLIENTES(ID_Cliente),
	FOREIGN KEY (ID_Habitacion) REFERENCES HABITACIONES(ID_Habitacion)
	);

CREATE TABLE EMPLEADOS(
	ID_Empleado INT IDENTITY (1,1) PRIMARY KEY,
	DNI VARCHAR(20) NOT NULL UNIQUE,
	Nombre_Empleado VARCHAR(50) NOT NULL,
	Apellido1_Empleado VARCHAR(50) NOT NULL,
	Apellido2_Empleado VARCHAR(50) NOT NULL,
	Puesto VARCHAR(50) NOT NULL,
	Estado_Empleado VARCHAR(50) NOT NULL,
	ID_Hotel INT NOT NULL,
	FOREIGN KEY (ID_Hotel) REFERENCES HOTELES(ID_Hotel)
	);

CREATE TABLE CHECKIN(
	ID_Checkin INT IDENTITY (1,1) PRIMARY KEY,
	Fecha_Checkin DATE NOT NULL,
	Hora_Checkin TIME NOT NULL,
	ID_Empleado INT NOT NULL,
	ID_Reservacion INT NOT NULL,
	FOREIGN KEY (ID_Empleado) REFERENCES EMPLEADOS(ID_Empleado),
	FOREIGN KEY (ID_Reservacion) REFERENCES RESERVACIONES(ID_Reservacion)
	);

CREATE TABLE CHECKOUT(
	ID_Checkout INT IDENTITY (1,1) PRIMARY KEY,
	Fecha_Checkout DATE NOT NULL,
	Hora_Checkout TIME NOT NULL,
	Cargos DECIMAL(10,2) NOT NULL,
	Total DECIMAL(10,2) NOT NULL,
	ID_Reservacion INT NOT NULL,
	FOREIGN KEY (ID_Reservacion) REFERENCES RESERVACIONES(ID_Reservacion)
	);

CREATE TABLE TIPOS_DE_RESTAURANTES(
	ID_Tipo_Restaurante INT IDENTITY (1,1) PRIMARY KEY,
	Nombre_Tipo VARCHAR(50) NOT NULL,
	Descripcion VARCHAR(255) NOT NULL
	);

CREATE TABLE RESTAURANTES(
	ID_Restaurante INT IDENTITY (1,1) PRIMARY KEY,
	Nombre_Restaurante VARCHAR(100) NOT NULL,
	Capacidad INT NOT NULL,
	Hora_Apertura TIME NOT NULL,
	Hora_Cierre TIME NOT NULL,
	ID_Hotel INT NOT NULL,
	ID_Tipo_Restaurante INT NOT NULL,
	FOREIGN KEY (ID_Hotel) REFERENCES HOTELES(ID_Hotel),
	FOREIGN KEY (ID_Tipo_Restaurante) REFERENCES TIPOS_DE_RESTAURANTES(ID_Tipo_Restaurante)
	);

CREATE TABLE RESERVACIONES_RESTAURANTE(
	ID_Reservacion_Restaurante INT IDENTITY (1,1) PRIMARY KEY,
	Fecha_Reservacion_Rest DATE NOT NULL,
	Hora_Reservacion_Rest TIME NOT NULL,
	Cantidad_Personas INT NOT NULL,
	Estado_Reservacion_Restaurante VARCHAR(50) NOT NULL,
	ID_Cliente INT NOT NULL,
	ID_Restaurante INT NOT NULL,
	FOREIGN KEY (ID_Cliente) REFERENCES CLIENTES(ID_Cliente),
	FOREIGN KEY (ID_Restaurante) REFERENCES RESTAURANTES(ID_Restaurante)
	 );

---Inserción de registros

INSERT INTO CIUDADES (Nombre_Ciudad, Provincia, Pais) 
VALUES
('San José',           'San José',              'Costa Rica'),
('Alajuela',           'Alajuela',              'Costa Rica'),
('Cartago',            'Cartago',               'Costa Rica'),
('Heredia',            'Heredia',               'Costa Rica'),
('Liberia',            'Guanacaste',            'Costa Rica'),
('Puntarenas',         'Puntarenas',            'Costa Rica'),
('Limón',              'Limón',                 'Costa Rica'),
('Buenos Aires',       'Buenos Aires',          'Argentina'),
('Córdoba',            'Córdoba',               'Argentina'),
('Rosario',            'Santa Fe',              'Argentina'),
('Ciudad de México',   'Ciudad de México',      'México'),
('Guadalajara',        'Jalisco',               'México'),
('Cancún',             'Quintana Roo',          'México'),
('Bogotá',             'Cundinamarca',          'Colombia'),
('Medellín',           'Antioquia',             'Colombia'),
('Cartagena',          'Bolívar',               'Colombia'),
('Lima',               'Lima',                  'Perú'),
('Cusco',              'Cusco',                 'Perú'),
('Arequipa',           'Arequipa',              'Perú'),
('Santiago',           'Región Metropolitana',  'Chile'),
('Valparaíso',         'Valparaíso',            'Chile'),
('São Paulo',          'São Paulo',             'Brasil'),
('Río de Janeiro',     'Río de Janeiro',        'Brasil'),
('Florianópolis',      'Santa Catarina',        'Brasil'),
('Caracas',            'Distrito Capital',      'Venezuela'),
('Quito',              'Pichincha',             'Ecuador'),
('Guayaquil',          'Guayas',                'Ecuador'),
('Asunción',           'Central',               'Paraguay'),
('Montevideo',         'Montevideo',            'Uruguay'),
('La Paz',             'Murillo',               'Bolivia'),
('Madrid',             'Comunidad de Madrid',   'España'),
('Barcelona',          'Cataluña',              'España'),
('Sevilla',            'Andalucía',             'España'),
('París',              'Île-de-France',         'Francia'),
('Marsella',           'Provenza',              'Francia'),
('Roma',               'Lacio',                 'Italia'),
('Milán',              'Lombardía',             'Italia'),
('Venecia',            'Véneto',                'Italia'),
('Lisboa',             'Área Metropolitana',    'Portugal'),
('Oporto',             'Norte',                 'Portugal'),
('Londres',            'Inglaterra',            'Reino Unido'),
('Edimburgo',          'Escocia',               'Reino Unido'),
('Berlín',             'Berlín',                'Alemania'),
('Múnich',             'Baviera',               'Alemania'),
('Amsterdam',          'Holanda Septentrional', 'Países Bajos'),
('Nueva York',         'Nueva York',            'Estados Unidos'),
('Miami',              'Florida',               'Estados Unidos'),
('Cancún',             'Quintana Roo',          'México'),
('Tokio',              'Tokio',                 'Japón'),
('Dubái',              'Dubai',                 'Emiratos Árabes');

INSERT INTO HOTELES (Nombre_Hotel, Direccion_Exacta, Categoria, Correo_Hotel, Estado_Hotel, ID_Ciudad)
VALUES
('Hotel Central',           'Avenida 1, Centro',             '3 Estrellas', 'central@decameron.com',          'Activo', 1),
('Hotel San José Royal',    'Calle 42, Sabana Norte',        '4 Estrellas', 'sjroyal@decameron.com',          'Activo', 1),
('Hotel Sabana Inn',        'Detrás del Estadio Nacional',   '3 Estrellas', 'sabana@decameron.com',          'Activo', 1),
('Hotel Paradise',          'Calle 5, Zona Norte',           '5 Estrellas', 'paradise@decameron.com',         'Activo', 2),
('Hotel Alajuela Airport',  '2km Oeste del Aeropuerto',      '3 Estrellas', 'airport@decameron.com',          'Activo', 2),
('Hotel Colonial',          'Avenida Central, Centro',       '4 Estrellas', 'colonial@decameron.com',         'Activo', 3),
('Hotel Cartago Histórico', 'Costado Sur de las Ruinas',     '3 Estrellas', 'cartago@decameron.com',          'Activo', 3),
('Hotel Heredia Real',      'Calle 9, Barrio Corazón',       '3 Estrellas', 'herediareal@decameron.com',      'Activo', 4),
('Hotel Flores Heredia',    'San Joaquín de Flores',         '4 Estrellas', 'flores@decameron.com',           'Activo', 4),
('Hotel Guanacaste',        'Avenida Las Palmas',            '5 Estrellas', 'guanacaste@decameron.com',       'Activo', 5),
('Hotel Liberia Sun',       'Frente al Parque Central',      '3 Estrellas', 'liberia@decameron.com',          'Activo', 5),
('Hotel Pacífico',          'Costanera Sur, Playa',          '4 Estrellas', 'pacifico@decameron.com',         'Activo', 6),
('Hotel Puntarenas Yacht',  'Paseo de los Turistas',         '4 Estrellas', 'yacht@decameron.com',            'Activo', 6),
('Hotel Caribe',            'Calle 1, Puerto Centro',        '3 Estrellas', 'caribe@decameron.com',           'Activo', 7),
('Hotel Limón Port',        'Barrio Roosevelt',              '3 Estrellas', 'limonport@decameron.com',        'Activo', 7),
('Hotel Buenos Aires Grand','Avenida 9 de Julio 1200',       '5 Estrellas', 'bsas@decameron.com',            'Activo', 8),
('Hotel Córdoba Center',    'Calle Colón 450',               '4 Estrellas', 'cordoba@decameron.com',          'Activo', 9),
('Hotel Rosario',           'Bulevar Oroño 800',             '3 Estrellas', 'rosario@decameron.com',          'Activo', 10),
('Hotel México Reforma',    'Paseo de la Reforma 500',       '5 Estrellas', 'mexico@decameron.com',           'Activo', 11),
('Hotel Guadalajara',       'Avenida Juárez 300',            '4 Estrellas', 'guadalajara@decameron.com',      'Activo', 12),
('Hotel Cancún Beach',      'Blvd Kukulcán Km 12',           '5 Estrellas', 'cancun@decameron.com',           'Activo', 13),
('Hotel Cancún Caribe',     'Blvd Kukulcán Km 8',            '4 Estrellas', 'cancuncaribe@decameron.com',     'Activo', 13),
('Hotel Cancún Sun',        'Zona Hotelera Km 15',           '5 Estrellas', 'cancunsun@decameron.com',        'Activo', 13),
('Hotel Bogotá Plaza',      'Carrera 7 No. 32-16',           '4 Estrellas', 'bogota@decameron.com',           'Activo', 14),
('Hotel Medellín',          'Calle 10 No. 43-22',            '3 Estrellas', 'medellin@decameron.com',         'Activo', 15),
('Hotel Cartagena Bay',     'Calle del Arsenal 5',           '5 Estrellas', 'cartagena@decameron.com',        'Activo', 16),
('Hotel Lima Central',      'Avenida Larco 800, Miraflores', '4 Estrellas', 'lima@decameron.com',             'Activo', 17),
('Hotel Cusco Imperial',    'Plaza de Armas 120',            '4 Estrellas', 'cusco@decameron.com',            'Activo', 18),
('Hotel Arequipa',          'Calle Santa Catalina 210',      '3 Estrellas', 'arequipa@decameron.com',         'Activo', 19),
('Hotel Santiago Crown',    'Avenida Providencia 1500',      '5 Estrellas', 'santiago@decameron.com',         'Activo', 20),
('Hotel Valparaíso',        'Cerro Alegre, Calle Templeman', '3 Estrellas', 'valparaiso@decameron.com',       'Activo', 21),
('Hotel São Paulo',         'Avenida Paulista 2000',         '5 Estrellas', 'saopaulo@decameron.com',         'Activo', 22),
('Hotel Río de Janeiro',    'Avenida Atlántica 500',         '5 Estrellas', 'rio@decameron.com',              'Activo', 23),
('Hotel Florianópolis',     'Rua Felipe Schmidt 300',        '4 Estrellas', 'floripa@decameron.com',          'Activo', 24),
('Hotel Caracas',           'Avenida Francisco de Miranda',  '3 Estrellas', 'caracas@decameron.com',          'Activo', 25),
('Hotel Quito Colonial',    'García Moreno 400, Centro',     '4 Estrellas', 'quito@decameron.com',            'Activo', 26),
('Hotel Guayaquil',         'Malecón Simón Bolívar 100',     '3 Estrellas', 'guayaquil@decameron.com',        'Activo', 27),
('Hotel Asunción',          'Calle Palma 650',               '3 Estrellas', 'asuncion@decameron.com',         'Activo', 28),
('Hotel Montevideo',        'Rambla República de Chile 400', '4 Estrellas', 'montevideo@decameron.com',       'Activo', 29),
('Hotel La Paz',            'Avenida Arce 2100',             '3 Estrellas', 'lapaz@decameron.com',            'Activo', 30),
('Hotel Madrid Gran Vía',   'Gran Vía 45',                   '5 Estrellas', 'madrid@decameron.com',           'Activo', 31),
('Hotel Madrid Castellana', 'Paseo de la Castellana 100',    '4 Estrellas', 'castellana@decameron.com',       'Activo', 31),
('Hotel Barcelona',         'Paseo de Gracia 120',           '5 Estrellas', 'barcelona@decameron.com',        'Activo', 32),
('Hotel Sevilla',           'Avenida de la Constitución 10', '4 Estrellas', 'sevilla@decameron.com',          'Activo', 33),
('Hotel París Lumière',     'Avenue des Champs-Élysées 80',  '5 Estrellas', 'paris@decameron.com',            'Activo', 34),
('Hotel Roma Coliseo',      'Via del Corso 250',             '5 Estrellas', 'roma@decameron.com',             'Activo', 36),
('Hotel Roma Vaticano',     'Via della Conciliazione 15',    '5 Estrellas', 'vaticano@decameron.com',         'Activo', 36),
('Hotel New York',          '5th Avenue 700, Manhattan',     '5 Estrellas', 'newyork@decameron.com',          'Activo', 46),
('Hotel Times Square',      'Broadway & 45th St',            '4 Estrellas', 'times@decameron.com',            'Activo', 46),
('Hotel Tokio',             'Shinjuku-ku, Kabukicho 1-1',    '5 Estrellas', 'tokio@decameron.com',            'Activo', 49);

INSERT INTO SERVICIOS (Nombre_Servicio, Descripcion, ID_Hotel)
VALUES
('Piscina',        'Piscina al aire libre con área de descanso',              1),
('Gimnasio',       'Gimnasio equipado con máquinas y pesas',                  2),
('Spa',            'Servicios de masajes y tratamientos de relajación',       3),
('Parqueo',        'Estacionamiento privado con vigilancia 24 horas',         4),
('Restaurante',    'Servicio de restaurante interno con menú variado',        5),
('WiFi',           'Internet inalámbrico de alta velocidad en todo el hotel', 6),
('Bar',            'Bar con bebidas nacionales e internacionales',            7),
('Lavandería',     'Servicio de lavado y planchado de ropa',                  8),
('Room Service',   'Servicio de comidas y bebidas a la habitación',           9),
('Piscina',        'Piscina temperada con área infantil',                     10),
('Gimnasio',       'Gimnasio con clases de yoga y aeróbicos',                 11),
('Spa',            'Centro de bienestar con sauna y jacuzzi',                 12),
('Parqueo',        'Parqueo cubierto con servicio de valet',                  13),
('Restaurante',    'Restaurante buffet con cocina internacional',             14),
('WiFi',           'Acceso a internet en habitaciones y áreas comunes',       15),
('Bar',            'Bar temático con cócteles de autor',                      16),
('Lavandería',     'Servicio express de lavandería en 24 horas',              17),
('Room Service',   'Servicio a la habitación disponible las 24 horas',        18),
('Salón Eventos',  'Salón para conferencias y eventos corporativos',          19),
('Piscina',        'Piscina olímpica con carril de nado',                     20),
('Gimnasio',       'Centro fitness con entrenadores personales',              21),
('Spa',            'Spa con tratamientos faciales y corporales',              22),
('Parqueo',        'Estacionamiento exterior con cámaras de seguridad',       23),
('Restaurante',    'Restaurante gourmet con chef internacional',              24),
('WiFi',           'Fibra óptica disponible en todo el edificio',             25),
('Bar',            'Pool bar con vista a la piscina',                         26),
('Lavandería',     'Servicio de tintorería incluido en suite',                27),
('Room Service',   'Menú especial nocturno para habitaciones',                28),
('Salón Eventos',  'Terraza para eventos al aire libre',                      29),
('Piscina',        'Piscina infinity con vista panorámica',                   30),
('Gimnasio',       'Área de cardio y musculación de última generación',       31),
('Spa',            'Circuito de hidroterapia y aromaterapia',                 32),
('Parqueo',        'Parqueo para motocicletas y bicicletas',                  33),
('Restaurante',    'Restaurante de cocina típica costarricense',              34),
('WiFi',           'Internet satelital de alta velocidad',                    35),
('Bar',            'Bar de vinos con sommelier',                              36),
('Lavandería',     'Autolavandería disponible para huéspedes',                37),
('Room Service',   'Desayuno a la habitación incluido en tarifa',             38),
('Salón Eventos',  'Sala de reuniones con equipo audiovisual',                39),
('Piscina',        'Piscina para adultos con bar acuático',                   40),
('Gimnasio',       'Clases grupales de spinning y zumba',                     41),
('Spa',            'Masajes terapéuticos y tratamientos antiedad',            42),
('Parqueo',        'Parqueo techado con recarga eléctrica para vehículos',    43),
('Restaurante',    'Restaurante de mariscos y cocina del mar',                44),
('WiFi',           'Red privada para huéspedes con contraseña personalizada', 45),
('Bar',            'Rooftop bar con vista a la ciudad',                       46),
('Lavandería',     'Servicio de lavandería ecológica',                        47),
('Room Service',   'Servicio de snacks y bebidas frías las 24 horas',         48),
('Salón Eventos',  'Jardín para bodas y eventos sociales',                    49),
('Piscina',        'Piscina cubierta climatizada disponible todo el año',     50);

INSERT INTO TIPOS_IDENTIFICACION (Descripcion)
VALUES
('Cedula'),
('Pasaporte'),
('DIMEX');

INSERT INTO CLIENTES (Nombre_Cliente, Apellido1_Cliente, Apellido2_Cliente, ID_Tipo_Identificacion, Numero_Identificacion, Correo_Cliente, Nacionalidad)
VALUES
('Juan',      'Perez',     'Lopez',     1, '123456789',  'juan@gmail.com',      'Costa Rica'),
('Maria',     'Gomez',     'Rodriguez', 2, 'A1234567',   'maria@gmail.com',     'México'),
('Carlos',    'Ramirez',   'Soto',      1, '987654321',  'carlos@gmail.com',    'Costa Rica'),
('Ana',       'Fernandez', 'Mora',      3, 'D456789123', 'ana@gmail.com',       'Costa Rica'),
('Luis',      'Vargas',    'Jimenez',   1, '111222333',  'luis@gmail.com',      'Costa Rica'),
('Sofia',     'Castro',    'Rojas',     2, 'B7654321',   'sofia@gmail.com',     'España'),
('Diego',     'Hernandez', 'Solano',    1, '222333444',  'diego@gmail.com',     'Costa Rica'),
('Laura',     'Mora',      'Chaves',    3, 'D987654321', 'laura@gmail.com',     'Panamá'),
('Andres',    'Navarro',   'Vega',      1, '555666777',  'andres@gmail.com',    'Costa Rica'),
('Elena',     'Salas',     'Campos',    2, 'P1239876',   'elena@gmail.com',     'Colombia'),
('Ricardo',   'Jimenez',   'Alfaro',    1, '333444555',  'ricardo@gmail.com',   'Costa Rica'),
('Valeria',   'Soto',      'Marin',     2, 'C8765432',   'valeria@gmail.com',   'Argentina'),
('Jorge',     'Lopez',     'Cordero',   1, '444555666',  'jorge@gmail.com',     'Costa Rica'),
('Camila',    'Rodriguez', 'Vega',      3, 'D654321987', 'camila@gmail.com',    'Costa Rica'),
('Felipe',    'Campos',    'Araya',     1, '777888999',  'felipe@gmail.com',    'Costa Rica'),
('Isabel',    'Mora',      'Salazar',   2, 'E1234567',   'isabel@gmail.com',    'Chile'),
('Mateo',     'Vega',      'Solis',     1, '888999000',  'mateo@gmail.com',     'Costa Rica'),
('Paula',     'Chaves',    'Rojas',     3, 'F987654321', 'paula@gmail.com',     'Ecuador'),
('Sebastian', 'Navarro',   'Jimenez',   1, '999000111',  'sebastian@gmail.com', 'Costa Rica'),
('Gabriela',  'Fernandez', 'Lopez',     2, 'G1239876',   'gabriela@gmail.com',  'Perú'),
('Daniel',    'Castro',    'Marin',     1, '112233445',  'daniel@gmail.com',    'Costa Rica'),
('Natalia',   'Ramirez',   'Campos',    3, 'H456789123', 'natalia@gmail.com',   'Costa Rica'),
('Oscar',     'Soto',      'Vargas',    1, '223344556',  'oscar@gmail.com',     'Costa Rica'),
('Carolina',  'Lopez',     'Mora',      2, 'I7654321',   'carolina@gmail.com',  'México'),
('Fernando',  'Gomez',     'Salas',     1, '334455667',  'fernando@gmail.com',  'Costa Rica'),
('Patricia',  'Vega',      'Rodriguez', 3, 'J987654321', 'patricia@gmail.com',  'Costa Rica'),
('Hugo',      'Jimenez',   'Navarro',   1, '445566778',  'hugo@gmail.com',      'Costa Rica'),
('Monica',    'Campos',    'Soto',      2, 'K1239876',   'monica@gmail.com',    'Venezuela'),
('Raul',      'Marin',     'Lopez',     1, '556677889',  'raul@gmail.com',      'Costa Rica'),
('Andrea',    'Salazar',   'Fernandez', 3, 'L654321987', 'andrea@gmail.com',    'Costa Rica'),
('Julian',    'Cordero',   'Vega',      1, '667788990',  'julian@gmail.com',    'Costa Rica'),
('Claudia',   'Araya',     'Ramirez',   2, 'M1234567',   'claudia@gmail.com',   'Brasil'),
('Mauricio',  'Solis',     'Campos',    1, '778899001',  'mauricio@gmail.com',   'Costa Rica'),
('Alejandra', 'Rojas',     'Jimenez',   3, 'N987654321', 'alejandra@gmail.com', 'Costa Rica'),
('Esteban',   'Lopez',     'Navarro',   1, '889900112',  'esteban@gmail.com',   'Costa Rica'),
('Rosa',      'Rodriguez', 'Mora',      2, 'O1239876',   'rosa@gmail.com',      'España'),
('Pablo',     'Fernandez', 'Salas',     1, '990011223',  'pablo@gmail.com',     'Costa Rica'),
('Lucia',     'Vargas',    'Campos',    3, 'P456789123', 'lucia@gmail.com',     'Costa Rica'),
('Alberto',   'Castro',    'Soto',      1, '101112131',  'alberto@gmail.com',   'Costa Rica'),
('Mariana',   'Hernandez', 'Lopez',     2, 'Q7654321',   'mariana@gmail.com',   'Italia'),
('Ignacio',   'Mora',      'Rodriguez', 1, '121314151',  'ignacio@gmail.com',   'Costa Rica'),
('Teresa',    'Navarro',   'Fernandez', 3, 'R987654321', 'teresa@gmail.com',    'Costa Rica'),
('Francisco', 'Salas',     'Vega',      1, '131415161',  'francisco@gmail.com', 'Costa Rica'),
('Angela',    'Campos',    'Ramirez',   2, 'S1239876',   'angela@gmail.com',    'Portugal'),
('Roberto',   'Marin',     'Jimenez',   1, '141516171',  'roberto@gmail.com',   'Costa Rica'),
('Beatriz',   'Lopez',     'Chaves',    3, 'T654321987', 'beatriz@gmail.com',   'Costa Rica'),
('Guillermo', 'Rodriguez', 'Soto',      1, '151617181',  'guillermo@gmail.com', 'Costa Rica'),
('Cecilia',   'Fernandez', 'Mora',      2, 'U1234567',   'cecilia@gmail.com',   'Francia'),
('Manuel',    'Vargas',    'Navarro',   1, '161718191',  'manuel@gmail.com',    'Costa Rica'),
('Lorena',    'Castro',    'Campos',    3, 'V987654321', 'lorena@gmail.com',    'Costa Rica'),
('Alonso',    'Hernandez', 'Lopez',     1, '171819202',  'alonso@gmail.com',    'Costa Rica'),
('Veronica',  'Mora',      'Rodriguez', 2, 'W1239876',   'veronica@gmail.com',  'Uruguay');


INSERT INTO TELEFONOS_CLIENTES (Numero_Telefono_Cliente, ID_Cliente)
VALUES
('+50688112233',  1),
('+525512345678', 2),
('+50683456789',  3),
('+50661234567',  4),
('+50689012345',  5),
('+34912345678',  6),
('+50622233344',  7),
('+50761234567',  8),
('+50655566677',  9),
('+573101234567', 10),
('+50633344455',  11),
('+541143218765', 12),
('+50644455566',  13),
('+50665432198',  14),
('+50677788899',  15),
('+56912345678',  16),
('+50688899900',  17),
('+59391234567',  18),
('+50699900011',  19),
('+5111234567',   20),
('+50611223344',  21),
('+50645678912',  22),
('+50622334455',  23),
('+523387654321', 24),
('+50633445566',  25),
('+50698765432',  26),
('+50644556677',  27),
('+582121234567', 28),
('+50655667788',  29),
('+50665432198',  30),
('+50666778899',  31),
('+551191234567', 32),
('+50677889900',  33),
('+50698765432',  34),
('+50688990011',  35),
('+34932123456',  36),
('+50699001122',  37),
('+50645678912',  38),
('+50610111213',  39),
('+390612345678', 40),
('+50612131415',  41),
('+50698765432',  42),
('+50613141516',  43),
('+351211234567', 44),
('+50614151617',  45),
('+50665432198',  46),
('+50615161718',  47),
('+33112345678',  48),
('+50616171819',  49),
('+50698765432',  50);


INSERT INTO TELEFONOS_HOTELES (Numero_Telefono_Hotel, ID_Hotel)
VALUES
('+50622110001',  1),
('+50622110002',  2),
('+50622110003',  3),
('+50622110004',  4),
('+50622110005',  5),
('+50622110006',  6),
('+50622110007',  7),
('+541144332211', 8),
('+543514433221', 9),
('+543414433221', 10),
('+525511223344', 11),
('+523311223344', 12),
('+529981122334', 13),
('+5712233445',   14),
('+5742233445',   15),
('+5752233445',   16),
('+5112233445',   17),
('+5184223344',   18),
('+5154223344',   19),
('+56222334455',  20),
('+56322233445',  21),
('+551133221100', 22),
('+552133221100', 23),
('+554833221100', 24),
('+582123322110', 25),
('+59322332211',  26),
('+59342332211',  27),
('+59521233221',  28),
('+59822332211',  29),
('+59122332211',  30),
('+34912345678',  31),
('+34912345679',  32),
('+34932345678',  33),
('+34952345678',  34),
('+33123456789',  35),
('+33423456789',  36),
('+39061234567',  37),
('+39061234568',  38),
('+39021234567',  39),
('+39041123456',  40),
('+35121123456',  41),
('+35122123456',  42),
('+442012345678', 43),
('+441312345678', 44),
('+493012345678', 45),
('+498912345678', 46),
('+31201234567',  47),
('+12121234567',  48),
('+13051234567',  49),
('+81312345678',  50);

INSERT INTO HABITACIONES (Numero_Habitacion, Tipo_Habitacion, Precio_Noche, Estado_Habitacion, ID_Hotel)
VALUES
(101, 'Simple',  85.00,  'Disponible', 1), (102, 'Doble',   120.00, 'Disponible', 1), (103, 'Suite',   250.00, 'Ocupada',    1),
(201, 'Simple',  90.00,  'Disponible', 2), (202, 'Doble',   130.00, 'Ocupada',    2), (203, 'Suite',   300.00, 'Disponible', 2),
(301, 'Simple',  75.00,  'Mantenimiento', 3), (302, 'Doble',   110.00, 'Disponible', 3), (303, 'Suite',   220.00, 'Disponible', 3),
(101, 'Simple',  95.00,  'Disponible', 4), (102, 'Doble',   140.00, 'Disponible', 4), (103, 'Suite',   350.00, 'Disponible', 4),
(501, 'Suite',   500.00, 'Ocupada',    5), (502, 'Suite',   550.00, 'Disponible', 5), (503, 'Doble',   180.00, 'Disponible', 5),
(101, 'Simple',  80.00,  'Disponible', 6), (102, 'Doble',   115.00, 'Disponible', 6), (103, 'Suite',   210.00, 'Ocupada',    6),
(101, 'Simple',  70.00,  'Disponible', 7), (102, 'Doble',   100.00, 'Disponible', 7), (103, 'Simple',  70.00,  'Disponible', 7),
(801, 'Suite',   450.00, 'Disponible', 8), (802, 'Doble',   200.00, 'Ocupada',    8), (803, 'Simple',  120.00, 'Disponible', 8),
(901, 'Simple',  90.00,  'Disponible', 9), (902, 'Doble',   150.00, 'Disponible', 9), (903, 'Suite',   280.00, 'Disponible', 9),
(101, 'Simple',  65.00,  'Disponible', 10),(102, 'Doble',   95.00,  'Disponible', 10),(103, 'Simple',  65.00,  'Ocupada',    10),
(110, 'Suite',   600.00, 'Disponible', 11),(111, 'Doble',   250.00, 'Disponible', 11),(112, 'Simple',  150.00, 'Disponible', 11),
(101, 'Simple',  85.00,  'Disponible', 12),(102, 'Doble',   130.00, 'Disponible', 12),(103, 'Suite',   240.00, 'Disponible', 12),
(131, 'Suite',   700.00, 'Ocupada',    13),(132, 'Suite',   750.00, 'Disponible', 13),(133, 'Doble',   300.00, 'Disponible', 13),
(141, 'Simple',  110.00, 'Disponible', 14),(142, 'Doble',   180.00, 'Disponible', 14),(143, 'Suite',   320.00, 'Disponible', 14),
(151, 'Simple',  75.00,  'Disponible', 15),(152, 'Doble',   110.00, 'Disponible', 15),(153, 'Simple',  75.00,  'Disponible', 15),
(161, 'Suite',   800.00, 'Disponible', 16),(162, 'Doble',   350.00, 'Disponible', 16),(163, 'Suite',   850.00, 'Ocupada',    16),
(171, 'Simple',  95.00,  'Disponible', 17),(172, 'Doble',   145.00, 'Disponible', 17),(173, 'Suite',   290.00, 'Disponible', 17),
(181, 'Simple',  100.00, 'Disponible', 18),(182, 'Doble',   160.00, 'Disponible', 18),(183, 'Suite',   310.00, 'Disponible', 18),
(191, 'Simple',  80.00,  'Disponible', 19),(192, 'Doble',   125.00, 'Disponible', 19),(193, 'Simple',  80.00,  'Disponible', 19),
(201, 'Suite',   400.00, 'Disponible', 20),(202, 'Doble',   190.00, 'Disponible', 20),(203, 'Simple',  130.00, 'Disponible', 20),
(211, 'Simple',  70.00,  'Disponible', 21),(212, 'Doble',   105.00, 'Disponible', 21),(213, 'Simple',  70.00,  'Disponible', 21),
(221, 'Suite',   550.00, 'Disponible', 22),(222, 'Doble',   220.00, 'Disponible', 22),(223, 'Simple',  160.00, 'Disponible', 22),
(231, 'Suite',   650.00, 'Disponible', 23),(232, 'Doble',   280.00, 'Disponible', 23),(233, 'Suite',   700.00, 'Disponible', 23),
(241, 'Simple',  90.00,  'Disponible', 24),(242, 'Doble',   150.00, 'Disponible', 24),(243, 'Suite',   280.00, 'Disponible', 24),
(251, 'Simple',  85.00,  'Disponible', 25),(252, 'Doble',   130.00, 'Disponible', 25),(253, 'Simple',  85.00,  'Disponible', 25);

INSERT INTO EMPLEADOS (DNI, Nombre_Empleado, Apellido1_Empleado, Apellido2_Empleado, Puesto, Estado_Empleado, ID_Hotel)
VALUES
('101110111', 'Carlos',    'Mendez',    'Sosa',      'Recepcionista', 'Activo', 1),
('102220222', 'Luis',      'Guerra',    'Paez',      'Gerente',       'Activo', 1),
('103330333', 'Ana',       'Rojas',     'Luna',      'Recepcionista', 'Activo', 2),
('104440444', 'Marta',     'Solis',     'Peña',      'Mucama',        'Activo', 2),
('105550555', 'Pedro',     'Duran',     'Vera',      'Recepcionista', 'Activo', 3),
('106660666', 'Sofia',     'Lara',      'Maza',      'Seguridad',     'Activo', 3),
('107770777', 'Jorge',     'Ortiz',     'Cano',      'Recepcionista', 'Activo', 4),
('108880888', 'Lucía',     'Rivas',     'Gil',       'Mantenimiento', 'Activo', 4),
('109990999', 'Elena',     'Blanco',    'Sanz',      'Gerente',       'Activo', 5),
('201110111', 'Pablo',     'Torres',    'Díaz',      'Recepcionista', 'Activo', 5),
('202220222', 'Raul',      'Castro',    'Leon',      'Recepcionista', 'Activo', 6),
('203330333', 'Sonia',     'Mejia',     'Galan',     'Mucama',        'Activo', 6),
('204440444', 'Victor',    'Pardo',     'Rios',      'Recepcionista', 'Activo', 7),
('205550555', 'Irene',     'Moya',      'Soto',      'Seguridad',     'Activo', 7),
('206660666', 'Hugo',      'Ferre',     'Vidal',     'Gerente',       'Activo', 8),
('207770777', 'Sara',      'Calvo',     'Marin',     'Recepcionista', 'Activo', 8),
('208880888', 'Diego',     'Arias',     'Ibañez',    'Recepcionista', 'Activo', 9),
('209990999', 'Nerea',     'Cortes',    'Perez',     'Mucama',        'Activo', 9),
('301110111', 'Marcos',    'Saez',      'Vega',      'Recepcionista', 'Activo', 10),
('302220222', 'Julia',     'Lozano',    'Ortega',    'Seguridad',     'Activo', 10),
('303330333', 'Alvaro',    'Pascual',   'Abad',      'Gerente',       'Activo', 11),
('304440444', 'Paula',     'Bravo',     'Soria',     'Recepcionista', 'Activo', 11),
('305550555', 'Adrian',    'Milla',     'Guzman',    'Recepcionista', 'Activo', 12),
('306660666', 'Emma',      'Pina',      'Vila',      'Mucama',        'Activo', 12),
('307770777', 'Mario',     'Santos',    'Cruz',      'Gerente',       'Activo', 13),
('308880888', 'Clara',     'Rey',       'Polo',      'Recepcionista', 'Activo', 13),
('309990999', 'David',     'Haro',      'Benito',    'Recepcionista', 'Activo', 14),
('401110111', 'Silvia',    'Bernal',    'Caro',      'Mantenimiento', 'Activo', 14),
('402220222', 'Oscar',     'Roldan',    'Giner',     'Recepcionista', 'Activo', 15),
('403330333', 'Carla',     'Velasco',   'Bueno',     'Mucama',        'Activo', 15),
('404440444', 'Ruben',     'Pastor',    'Mora',      'Gerente',       'Activo', 16),
('405550555', 'Alicia',    'Sosa',      'Delgado',   'Recepcionista', 'Activo', 16),
('406660666', 'Iván',      'Peral',     'Gomez',     'Recepcionista', 'Activo', 17),
('407770777', 'Gloria',    'Lillo',     'Cano',      'Seguridad',     'Activo', 17),
('408880888', 'Sergio',    'Navas',     'Feliu',     'Recepcionista', 'Activo', 18),
('409990999', 'Nuria',     'Esteve',    'Bosch',     'Mucama',        'Activo', 18),
('501110111', 'Jordi',     'Mora',      'Dalmau',    'Gerente',       'Activo', 19),
('502220222', 'Eva',       'Fabra',     'Serra',     'Recepcionista', 'Activo', 19),
('503330333', 'Ramon',     'Valls',     'Gras',      'Recepcionista', 'Activo', 20),
('504440444', 'Gemma',     'Pons',      'Riba',      'Mucama',        'Activo', 20),
('505550555', 'Manel',     'Costa',     'Sola',      'Recepcionista', 'Activo', 21),
('506660666', 'Anna',      'Pages',     'Font',      'Seguridad',     'Activo', 21),
('507770777', 'Lluis',     'Vila',      'Roca',      'Gerente',       'Activo', 22),
('508880888', 'Rosa',      'Prat',      'Serra',     'Recepcionista', 'Activo', 22),
('509990999', 'Joan',      'Marti',     'Mas',       'Recepcionista', 'Activo', 23),
('601110111', 'Laia',      'Sole',      'Grau',      'Mucama',        'Activo', 23),
('602220222', 'Oriol',     'Puig',      'Vives',     'Recepcionista', 'Activo', 24),
('603330333', 'Berta',     'Rius',      'Vidal',     'Gerente',       'Activo', 24),
('604440444', 'Cesc',      'Gasol',     'Navarro',   'Recepcionista', 'Activo', 25),
('605550555', 'Mireia',    'Belmonte',  'Garcia',    'Mucama',        'Activo', 25),
('606660666', 'Guillem',   'Balague',   'Escriba',   'Recepcionista', 'Activo', 26),
('607770777', 'Xavi',      'Hernan',    'Creus',     'Gerente',       'Activo', 26),
('608880888', 'Andres',    'Iniesta',   'Lujan',     'Recepcionista', 'Activo', 27),
('609990999', 'Leo',       'Messi',     'Cucci',     'Seguridad',     'Activo', 27),
('701110111', 'Iker',      'Casilla',   'Fernan',    'Recepcionista', 'Activo', 28),
('702220222', 'Carles',    'Puyol',     'Saforc',    'Gerente',       'Activo', 28),
('703330333', 'Gerard',    'Pique',     'Bernab',    'Recepcionista', 'Activo', 29),
('704440444', 'Cesc',      'Fabreg',    'Soler',     'Mantenimiento', 'Activo', 29),
('705550555', 'Santi',     'Cazorla',   'Gonzal',    'Recepcionista', 'Activo', 30),
('706660666', 'Juan',      'Mata',      'Garcia',    'Gerente',       'Activo', 30),
('707770777', 'David',     'Silva',     'Jimenez',   'Recepcionista', 'Activo', 31),
('708880888', 'Pepe',      'Reina',     'Paez',      'Mucama',        'Activo', 31),
('709990999', 'Alvaro',    'Arbeloa',   'Coca',      'Recepcionista', 'Activo', 32),
('801110111', 'Fernando',  'Torres',    'Sanz',      'Gerente',       'Activo', 32),
('802220222', 'Javi',      'Martine',   'Agui',      'Recepcionista', 'Activo', 33),
('803330333', 'Jesus',     'Navas',     'Gonza',     'Seguridad',     'Activo', 33),
('804440444', 'Pedro',     'Rodrig',    'Ledesma',   'Recepcionista', 'Activo', 34),
('805550555', 'Juanfran',  'Torres',    'Belen',     'Gerente',       'Activo', 34),
('806660666', 'Koke',      'Resurre',   'Merodio',   'Recepcionista', 'Activo', 35),
('807770777', 'Isco',      'Alarco',    'Suarez',    'Mucama',        'Activo', 35),
('808880888', 'Thiago',    'Alcant',    'Nascim',    'Recepcionista', 'Activo', 36),
('809990999', 'Dani',      'Carvaj',    'Ramos',     'Gerente',       'Activo', 36),
('901110111', 'Nacho',     'Fernan',    'Iglesias',  'Recepcionista', 'Activo', 37),
('902220222', 'Marco',     'Asensio',   'Willem',    'Seguridad',     'Activo', 37),
('903330333', 'Saul',      'Niguez',    'Esclapez',  'Recepcionista', 'Activo', 38);


INSERT INTO RESERVACIONES (Fecha_Entrada, Fecha_Salida, Estado_Reservacion, ID_Cliente, ID_Habitacion)
VALUES
('2024-01-05', '2024-01-10', 'Completada', 1,  1),  ('2024-01-06', '2024-01-12', 'Completada', 2,  2),
('2024-01-15', '2024-01-20', 'Completada', 3,  3),  ('2024-01-18', '2024-01-22', 'Completada', 4,  4),
('2024-02-01', '2024-02-05', 'Completada', 5,  5),  ('2024-02-05', '2024-02-10', 'Completada', 6,  6),
('2024-02-10', '2024-02-15', 'Completada', 7,  7),  ('2024-02-15', '2024-02-18', 'Completada', 8,  8),
('2024-03-01', '2024-03-05', 'Completada', 9,  9),  ('2024-03-05', '2024-03-10', 'Completada', 10, 10),
('2024-03-10', '2024-03-15', 'Completada', 11, 11), ('2024-03-15', '2024-03-20', 'Completada', 12, 12),
('2024-04-01', '2024-04-05', 'Completada', 13, 13), ('2024-04-05', '2024-04-10', 'Completada', 14, 14),
('2024-04-10', '2024-04-15', 'Completada', 15, 15), ('2024-04-15', '2024-04-20', 'Completada', 16, 16),
('2024-05-01', '2024-05-05', 'Completada', 17, 17), ('2024-05-05', '2024-05-10', 'Completada', 18, 18),
('2024-05-10', '2024-05-15', 'Completada', 19, 19), ('2024-05-15', '2024-05-20', 'Completada', 20, 20),
('2024-06-01', '2024-06-05', 'Completada', 21, 21), ('2024-06-05', '2024-06-10', 'Completada', 22, 22),
('2024-06-10', '2024-06-15', 'Completada', 23, 23), ('2024-06-15', '2024-06-20', 'Completada', 24, 24),
('2024-07-01', '2024-07-05', 'Completada', 25, 25), ('2024-07-05', '2024-07-10', 'Completada', 26, 26),
('2024-07-10', '2024-07-15', 'Completada', 27, 27), ('2024-07-15', '2024-07-20', 'Completada', 28, 28),
('2024-08-01', '2024-08-05', 'Completada', 29, 29), ('2024-08-05', '2024-08-10', 'Completada', 30, 30),
('2024-08-10', '2024-08-15', 'Completada', 31, 31), ('2024-08-15', '2024-08-20', 'Completada', 32, 32),
('2024-09-01', '2024-09-05', 'Completada', 33, 33), ('2024-09-05', '2024-09-10', 'Completada', 34, 34),
('2024-09-10', '2024-09-15', 'Completada', 35, 35), ('2024-09-15', '2024-09-20', 'Completada', 36, 36),
('2024-10-01', '2024-10-05', 'Completada', 37, 37), ('2024-10-05', '2024-10-10', 'Completada', 38, 38),
('2024-10-10', '2024-10-15', 'Completada', 39, 39), ('2024-10-15', '2024-10-20', 'Completada', 40, 40),
('2024-11-01', '2024-11-05', 'Completada', 41, 41), ('2024-11-05', '2024-11-10', 'Completada', 42, 42),
('2024-11-10', '2024-11-15', 'Completada', 43, 43), ('2024-11-15', '2024-11-20', 'Completada', 44, 44),
('2024-12-01', '2024-12-05', 'Completada', 45, 45), ('2024-12-05', '2024-12-10', 'Completada', 46, 46),
('2024-01-20', '2024-01-25', 'Completada', 47, 47), ('2024-01-25', '2024-01-30', 'Completada', 48, 48),
('2024-02-20', '2024-02-25', 'Completada', 49, 49), ('2024-02-25', '2024-02-28', 'Completada', 50, 50);


INSERT INTO CHECKIN (Fecha_Checkin, Hora_Checkin, ID_Empleado, ID_Reservacion)
VALUES
('2024-01-05', '14:00:00', 1,  1),  ('2024-01-06', '15:30:00', 3,  2),  ('2024-01-15', '12:00:00', 5,  3),
('2024-01-18', '14:45:00', 7,  4),  ('2024-02-01', '16:00:00', 9,  5),  ('2024-02-05', '15:00:00', 11, 6),
('2024-02-10', '13:20:00', 13, 7),  ('2024-02-15', '14:10:00', 15, 8),  ('2024-03-01', '15:15:00', 17, 9),
('2024-03-05', '16:30:00', 19, 10), ('2024-03-10', '14:00:00', 21, 11), ('2024-03-15', '15:45:00', 23, 12),
('2024-04-01', '13:00:00', 25, 13), ('2024-04-05', '14:20:00', 27, 14), ('2024-04-10', '15:10:00', 29, 15),
('2024-04-15', '16:00:00', 31, 16), ('2024-05-01', '14:00:00', 33, 17), ('2024-05-05', '15:30:00', 35, 18),
('2024-05-10', '13:45:00', 37, 19), ('2024-05-15', '14:15:00', 39, 20), ('2024-06-01', '12:30:00', 41, 21),
('2024-06-05', '15:10:00', 43, 22), ('2024-06-10', '14:25:00', 45, 23), ('2024-06-15', '16:00:00', 47, 24),
('2024-07-01', '13:00:00', 49, 25), ('2024-07-05', '14:30:00', 51, 26), ('2024-07-10', '15:00:00', 53, 27),
('2024-07-15', '16:15:00', 55, 28), ('2024-08-01', '14:00:00', 57, 29), ('2024-08-05', '15:30:00', 59, 30),
('2024-08-10', '13:45:00', 61, 31), ('2024-08-15', '14:15:00', 63, 32), ('2024-09-01', '12:30:00', 65, 33),
('2024-09-05', '15:10:00', 67, 34), ('2024-09-10', '14:25:00', 69, 35), ('2024-09-15', '16:00:00', 71, 36),
('2024-10-01', '13:00:00', 73, 37), ('2024-10-05', '14:30:00', 75, 38), ('2024-10-10', '15:00:00', 2,  39),
('2024-10-15', '16:15:00', 4,  40), ('2024-11-01', '14:00:00', 6,  41), ('2024-11-05', '15:30:00', 8,  42),
('2024-11-10', '13:45:00', 10, 43), ('2024-11-15', '14:15:00', 12, 44), ('2024-12-01', '12:30:00', 14, 45),
('2024-12-05', '15:10:00', 16, 46), ('2024-01-20', '14:25:00', 18, 47), ('2024-01-25', '16:00:00', 20, 48),
('2024-02-20', '13:00:00', 22, 49), ('2024-02-25', '14:30:00', 24, 50);

INSERT INTO CHECKOUT (Fecha_Checkout, Hora_Checkout, Cargos, Total, ID_Reservacion)
VALUES
('2024-01-10', '10:00:00', 25.00,  450.00,  1),  ('2024-01-12', '11:00:00', 10.00,  250.00,  2),
('2024-01-20', '09:30:00', 55.00,  1305.00, 3),  ('2024-01-22', '12:00:00', 40.00,  1440.00, 4),
('2024-02-05', '10:00:00', 120.00, 2120.00, 5),  ('2024-02-10', '11:30:00', 35.00,  1085.00, 6),
('2024-02-15', '08:00:00', 20.00,  520.00,  7),  ('2024-02-18', '11:00:00', 15.00,  315.00,  8),
('2024-03-05', '10:15:00', 40.00,  340.00,  9),  ('2024-03-10', '11:00:00', 65.00,  615.00,  10),
('2024-03-15', '09:00:00', 25.00,  525.00,  11), ('2024-03-20', '10:30:00', 10.00,  560.00,  12),
('2024-04-05', '11:00:00', 85.00,  1005.00, 13), ('2024-04-10', '12:00:00', 45.00,  745.00,  14),
('2024-04-15', '09:45:00', 30.00,  460.00,  15), ('2024-04-20', '11:15:00', 95.00,  1395.00, 16),
('2024-05-05', '10:30:00', 25.00,  405.00,  17), ('2024-05-10', '11:00:00', 20.00,  420.00,  18),
('2024-05-15', '09:15:00', 45.00,  645.00,  19), ('2024-05-20', '10:00:00', 65.00,  1015.00, 20),
('2024-06-05', '11:30:00', 20.00,  420.00,  21), ('2024-06-10', '12:00:00', 35.00,  585.00,  22),
('2024-06-15', '09:00:00', 25.00,  425.00,  23), ('2024-06-20', '10:30:00', 100.00, 1600.00, 24),
('2024-07-05', '11:00:00', 35.00,  315.00,  25), ('2024-07-10', '11:30:00', 25.00,  475.00,  26),
('2024-07-15', '08:45:00', 45.00,  795.00,  27), ('2024-07-20', '10:15:00', 45.00,  845.00,  28),
('2024-08-05', '11:00:00', 20.00,  380.00,  29), ('2024-08-10', '12:00:00', 60.00,  1060.00, 30),
('2024-08-15', '09:30:00', 30.00,  510.00,  31), ('2024-08-20', '11:15:00', 40.00,  740.00,  32),
('2024-09-05', '10:00:00', 25.00,  385.00,  33), ('2024-09-10', '11:30:00', 10.00,  560.00,  34),
('2024-09-15', '09:15:00', 45.00,  445.00,  35), ('2024-09-20', '10:00:00', 35.00,  485.00,  36),
('2024-10-05', '11:30:00', 30.00,  430.00,  37), ('2024-10-10', '12:00:00', 45.00,  595.00,  38),
('2024-10-15', '09:00:00', 15.00,  415.00,  39), ('2024-10-20', '10:30:00', 115.00, 1615.00, 40),
('2024-11-05', '11:00:00', 35.00,  460.00,  41), ('2024-11-10', '11:30:00', 25.00,  625.00,  42),
('2024-11-15', '08:45:00', 55.00,  430.00,  43), ('2024-11-20', '10:15:00', 45.00,  330.00,  44),
('2024-12-05', '11:00:00', 20.00,  270.00,  45), ('2024-12-10', '12:00:00', 70.00,  570.00,  46),
('2024-01-25', '09:30:00', 30.00,  380.00,  47), ('2024-01-30', '11:15:00', 50.00,  550.00,  48),
('2024-02-25', '10:00:00', 25.00,  425.00,  49), ('2024-02-28', '11:30:00', 20.00,  420.00,  50);

INSERT INTO TIPOS_DE_RESTAURANTES (Nombre_Tipo, Descripcion)
VALUES
('Italiano',        'Restaurante especializado en pastas, pizzas y cocina italiana tradicional'),
('Mexicano',        'Restaurante con platillos típicos de la gastronomía mexicana'),
('Japonés',         'Restaurante especializado en sushi, ramen y cocina japonesa'),
('Chino',           'Restaurante con platillos tradicionales de la cocina china'),
('Francés',         'Restaurante de alta cocina francesa y gastronomía gourmet'),
('Americano',       'Restaurante especializado en hamburguesas, hot dogs y comida americana'),
('Mediterráneo',    'Restaurante con platillos típicos de la región mediterránea'),
('Peruano',         'Restaurante especializado en ceviche y cocina peruana'),
('Español',         'Restaurante con tapas, paellas y gastronomía española'),
('Tailandés',       'Restaurante especializado en curry y cocina tailandesa'),
('Indio',           'Restaurante con especias y platillos tradicionales de la India'),
('Griego',          'Restaurante especializado en gyros, souvlaki y cocina griega'),
('Árabe',           'Restaurante con hummus, falafel y gastronomía árabe'),
('Brasileño',       'Restaurante especializado en churrasco y cocina brasileña'),
('Coreano',         'Restaurante con barbacoa coreana y platillos típicos'),
('Vietnamita',      'Restaurante especializado en pho y cocina vietnamita'),
('Turco',           'Restaurante con kebabs y gastronomía turca tradicional'),
('Mariscos',        'Restaurante especializado en pescados y mariscos frescos'),
('Vegetariano',     'Restaurante con menú exclusivamente vegetariano y saludable'),
('Vegano',          'Restaurante con platillos 100% libres de productos animales'),
('Parrilla',        'Restaurante especializado en carnes a la parrilla y asados'),
('Pizzería',        'Restaurante especializado exclusivamente en pizzas artesanales'),
('Sushi',           'Restaurante especializado en sushi y rolls japoneses'),
('Buffet',          'Restaurante de servicio libre con variedad de platillos'),
('Comida Rápida',   'Restaurante de servicio rápido con menú estandarizado'),
('Cafetería',       'Establecimiento especializado en café y repostería'),
('Fusión',          'Restaurante que combina técnicas y sabores de distintas culturas'),
('Costarricense',   'Restaurante con casados, gallo pinto y cocina típica tica'),
('Colombiano',      'Restaurante especializado en bandeja paisa y cocina colombiana'),
('Argentino',       'Restaurante con empanadas, asados y gastronomía argentina'),
('Cubano',          'Restaurante con ropa vieja, moros y cocina cubana tradicional'),
('Alemán',          'Restaurante especializado en salchichas, chucrut y cocina alemana'),
('Peruano-Japonés', 'Restaurante de fusión entre cocina peruana y japonesa (Nikkei)'),
('Steakhouse',      'Restaurante especializado en cortes de carne premium'),
('Brunch',          'Restaurante especializado en desayunos y almuerzos combinados'),
('Postres',         'Restaurante especializado en postres, helados y dulces'),
('Fondue',          'Restaurante especializado en fondues de queso y chocolate'),
('Orgánico',        'Restaurante con ingredientes 100% orgánicos y naturales'),
('Sin Gluten',      'Restaurante especializado en platillos libres de gluten'),
('Familiar',        'Restaurante con ambiente familiar y menú variado para todas las edades'),
('Romántico',       'Restaurante con ambiente íntimo ideal para parejas'),
('Temático',        'Restaurante con decoración y menú basado en un tema específico'),
('Bar-Restaurante', 'Establecimiento que combina servicio de bar y restaurante'),
('Comida de Mar',   'Restaurante especializado en platillos del océano Pacífico'),
('Libanés',         'Restaurante con shawarma, tabule y gastronomía libanesa'),
('Peruano-Criollo', 'Restaurante con lomo saltado, ají de gallina y cocina criolla'),
('Caribeño',        'Restaurante con platillos típicos del Caribe'),
('Tex-Mex',         'Restaurante de fusión entre cocina texana y mexicana'),
('Nórdico',         'Restaurante con platillos típicos de los países escandinavos'),
('Molecular',       'Restaurante de alta cocina con técnicas de gastronomía molecular');

INSERT INTO RESTAURANTES (Nombre_Restaurante, Capacidad, Hora_Apertura, Hora_Cierre, ID_Hotel, ID_Tipo_Restaurante)
VALUES
('La Trattoria',        60,  '12:00:00', '22:00:00', 1,  1),
('El Sombrero',         45,  '11:00:00', '23:00:00', 2,  2),
('Sakura Garden',       30,  '13:00:00', '22:00:00', 3,  3),
('Gran Muralla',        80,  '11:30:00', '22:30:00', 4,  4),
('Le Petit Bistró',     25,  '12:00:00', '23:00:00', 5,  5),
('Burger Republic',     90,  '10:00:00', '22:00:00', 6,  6),
('Costa Azul',          50,  '12:00:00', '22:00:00', 7,  7),
('Machu Picchu',        40,  '11:00:00', '22:00:00', 8,  8),
('Casa Española',       55,  '12:00:00', '23:00:00', 9,  9),
('Bangkok Street',      35,  '11:30:00', '22:30:00', 10, 10),
('Taj Mahal',           45,  '12:00:00', '22:00:00', 11, 11),
('Atenas',              30,  '12:00:00', '22:00:00', 12, 12),
('Mil y Una Noches',    40,  '13:00:00', '23:00:00', 13, 13),
('Churrascaria Brasil', 70,  '12:00:00', '23:00:00', 14, 14),
('Seoul BBQ',           50,  '12:00:00', '22:30:00', 15, 15),
('Pho Saigon',          35,  '11:00:00', '22:00:00', 16, 16),
('Istanbul',            45,  '12:00:00', '22:00:00', 17, 17),
('El Puerto',           60,  '11:00:00', '22:00:00', 18, 18),
('Green Garden',        40,  '08:00:00', '21:00:00', 19, 19),
('Vegan Soul',          30,  '09:00:00', '21:00:00', 20, 20),
('La Parrilla',         80,  '12:00:00', '23:00:00', 21, 21),
('Bella Pizza',         55,  '11:00:00', '23:00:00', 22, 22),
('Sushi World',         35,  '12:00:00', '22:00:00', 23, 23),
('Gran Buffet',         120, '07:00:00', '22:00:00', 24, 24),
('Fast & Good',         90,  '08:00:00', '22:00:00', 25, 25),
('Café Central',        25,  '07:00:00', '20:00:00', 26, 26),
('Fusion Lab',          40,  '12:00:00', '23:00:00', 27, 27),
('La Sazón Tica',       60,  '07:00:00', '21:00:00', 28, 28),
('Bandeja Paisa',       50,  '11:00:00', '22:00:00', 29, 29),
('El Asado',            70,  '12:00:00', '23:00:00', 30, 30),
('La Habana',           45,  '12:00:00', '22:00:00', 31, 31),
('Berlín',              40,  '12:00:00', '22:00:00', 32, 32),
('Nikkei',              30,  '12:00:00', '22:30:00', 33, 33),
('Prime Cut',           50,  '12:00:00', '23:00:00', 34, 34),
('Morning Glory',       35,  '07:00:00', '15:00:00', 35, 35),
('Sweet Dreams',        25,  '10:00:00', '21:00:00', 36, 36),
('La Fondue',           20,  '12:00:00', '22:00:00', 37, 37),
('Organic House',       40,  '08:00:00', '21:00:00', 38, 38),
('Sin Gluten CR',       30,  '09:00:00', '21:00:00', 39, 39),
('El Familiar',         100, '11:00:00', '22:00:00', 40, 40),
('Candlelight',         20,  '18:00:00', '23:00:00', 41, 41),
('Jurassic Grill',      60,  '11:00:00', '22:00:00', 42, 42),
('El Barril',           75,  '12:00:00', '00:00:00', 43, 43),
('Mar Abierto',         55,  '11:00:00', '22:00:00', 44, 44),
('Beirut',              35,  '12:00:00', '22:00:00', 45, 45),
('El Criollo',          50,  '11:00:00', '22:00:00', 46, 46),
('Caribe Mix',          45,  '11:00:00', '22:00:00', 47, 47),
('Texas Roadhouse',     80,  '11:00:00', '23:00:00', 48, 48),
('Nórdika',             30,  '12:00:00', '22:00:00', 49, 49),
('Molecular Kitchen',   20,  '18:00:00', '23:00:00', 50, 50);

INSERT INTO RESERVACIONES_RESTAURANTE (Fecha_Reservacion_Rest, Hora_Reservacion_Rest, Cantidad_Personas, Estado_Reservacion_Restaurante, ID_Cliente, ID_Restaurante)
VALUES
('2026-01-05', '12:00:00', 2, 'Confirmada', 1,  1),
('2026-01-06', '13:00:00', 4, 'Pendiente',  2,  2),
('2026-01-07', '19:00:00', 3, 'Confirmada', 3,  3),
('2026-01-08', '20:00:00', 5, 'Cancelada',  4,  4),
('2026-01-09', '11:00:00', 2, 'Confirmada', 5,  5),
('2026-01-10', '14:00:00', 6, 'Pendiente',  6,  6),
('2026-01-11', '18:00:00', 4, 'Confirmada', 7,  7),
('2026-01-12', '20:00:00', 3, 'Cancelada',  8,  8),
('2026-01-13', '12:30:00', 2, 'Confirmada', 9,  9),
('2026-01-14', '19:30:00', 5, 'Pendiente',  10, 10),
('2026-01-15', '13:00:00', 4, 'Confirmada', 11, 11),
('2026-01-16', '20:00:00', 2, 'Cancelada',  12, 12),
('2026-01-17', '11:30:00', 6, 'Confirmada', 13, 13),
('2026-01-18', '14:00:00', 3, 'Pendiente',  14, 14),
('2026-01-19', '19:00:00', 4, 'Confirmada', 15, 15),
('2026-01-20', '20:30:00', 2, 'Cancelada',  16, 16),
('2026-01-21', '12:00:00', 5, 'Confirmada', 17, 17),
('2026-01-22', '13:30:00', 3, 'Pendiente',  18, 18),
('2026-01-23', '18:00:00', 4, 'Confirmada', 19, 19),
('2026-01-24', '19:00:00', 2, 'Cancelada',  20, 20),
('2026-01-25', '11:00:00', 6, 'Confirmada', 21, 21),
('2026-01-26', '14:30:00', 3, 'Pendiente',  22, 22),
('2026-01-27', '20:00:00', 4, 'Confirmada', 23, 23),
('2026-01-28', '12:00:00', 5, 'Cancelada',  24, 24),
('2026-01-29', '13:00:00', 2, 'Confirmada', 25, 25),
('2026-01-30', '19:30:00', 3, 'Pendiente',  26, 26),
('2026-02-01', '18:30:00', 4, 'Confirmada', 27, 27),
('2026-02-02', '20:00:00', 6, 'Cancelada',  28, 28),
('2026-02-03', '11:00:00', 2, 'Confirmada', 29, 29),
('2026-02-04', '14:00:00', 3, 'Pendiente',  30, 30),
('2026-02-05', '19:00:00', 5, 'Confirmada', 31, 31),
('2026-02-06', '20:30:00', 4, 'Cancelada',  32, 32),
('2026-02-07', '12:30:00', 2, 'Confirmada', 33, 33),
('2026-02-08', '13:00:00', 6, 'Pendiente',  34, 34),
('2026-02-09', '18:00:00', 3, 'Confirmada', 35, 35),
('2026-02-10', '19:30:00', 4, 'Cancelada',  36, 36),
('2026-02-11', '11:30:00', 2, 'Confirmada', 37, 37),
('2026-02-12', '14:30:00', 5, 'Pendiente',  38, 38),
('2026-02-13', '20:00:00', 3, 'Confirmada', 39, 39),
('2026-02-14', '19:00:00', 6, 'Confirmada', 40, 40),
('2026-02-15', '12:00:00', 2, 'Cancelada',  41, 41),
('2026-02-16', '13:30:00', 4, 'Confirmada', 42, 42),
('2026-02-17', '18:30:00', 3, 'Pendiente',  43, 43),
('2026-02-18', '20:00:00', 5, 'Confirmada', 44, 44),
('2026-02-19', '11:00:00', 2, 'Cancelada',  45, 45),
('2026-02-20', '14:00:00', 4, 'Confirmada', 46, 46),
('2026-02-21', '19:30:00', 3, 'Pendiente',  47, 47),
('2026-02-22', '20:30:00', 6, 'Confirmada', 48, 48),
('2026-02-23', '12:00:00', 2, 'Cancelada',  49, 49),
('2026-02-24', '13:00:00', 4, 'Confirmada', 50, 50);

---Procedimientos Almacenados

---CIUDADES

---Insertar Ciudad
CREATE PROCEDURE SP_INSERTAR_CIUDAD
@Nombre_Ciudad VARCHAR(50),
@Provincia VARCHAR(50),
@Pais VARCHAR(50)
AS
BEGIN
    INSERT INTO CIUDADES (Nombre_Ciudad, Provincia, Pais)
    VALUES (@Nombre_Ciudad, @Provincia, @Pais);
END;

EXEC SP_INSERTAR_CIUDAD 'San José', 'San José', 'Costa Rica';

---Eliminar Ciudad
CREATE PROCEDURE SP_ELIMINAR_CIUDAD
@ID_Ciudad INT
AS
BEGIN
    DELETE FROM CIUDADES 
	WHERE ID_Ciudad = @ID_Ciudad;
END;

EXEC SP_ELIMINAR_CIUDAD 51;

CREATE PROCEDURE SP_MODIFICAR_CIUDAD
@ID_Ciudad INT,
@Nombre_Ciudad VARCHAR(50),
@Provincia VARCHAR(50),
@Pais VARCHAR(50)
AS
BEGIN
    UPDATE CIUDADES
    SET Nombre_Ciudad = @Nombre_Ciudad,
        Provincia = @Provincia,
        Pais = @Pais
    WHERE ID_Ciudad = @ID_Ciudad;
END;

EXEC SP_MODIFICAR_CIUDAD @ID_Ciudad = 1, @Nombre_Ciudad = 'Alajuela', @Provincia = 'Alajuela', @Pais = 'Costa Rica';

---HOTELES

---Insertar Hotel
CREATE PROCEDURE SP_INSERTAR_HOTEL
    @Nombre_Hotel VARCHAR(100),
    @Direccion_Exacta VARCHAR(255),
    @Categoria VARCHAR(50),
    @Correo_Hotel VARCHAR(100),
    @Estado_Hotel VARCHAR(50),
    @ID_Ciudad INT
AS
BEGIN
    INSERT INTO HOTELES (Nombre_Hotel, Direccion_Exacta, Categoria, Correo_Hotel, Estado_Hotel, ID_Ciudad)
    VALUES (@Nombre_Hotel, @Direccion_Exacta, @Categoria, @Correo_Hotel, @Estado_Hotel, @ID_Ciudad);
END;

EXEC SP_INSERTAR_HOTEL 'Hotel Paraíso', 'Avenida Central 123, San José', '5 estrellas', 'hotelparaiso@example.com', 'Activo', 1;

---Eliminar Hotel
CREATE PROCEDURE SP_ELIMINAR_HOTEL
    @ID_Hotel INT
AS
BEGIN
    DELETE FROM HOTELES
    WHERE ID_Hotel = @ID_Hotel;
END;	

EXEC SP_ELIMINAR_HOTEL 51;


---Modificar Hotel
CREATE PROCEDURE SP_MODIFICAR_HOTEL
    @ID_Hotel INT,
    @Nombre_Hotel VARCHAR(100),
    @Direccion_Exacta VARCHAR(255),
    @Categoria VARCHAR(50),
    @Correo_Hotel VARCHAR(100),
    @Estado_Hotel VARCHAR(50),
    @ID_Ciudad INT
AS
BEGIN
    UPDATE HOTELES
    SET Nombre_Hotel = @Nombre_Hotel,
        Direccion_Exacta = @Direccion_Exacta,
        Categoria = @Categoria,
        Correo_Hotel = @Correo_Hotel,
        Estado_Hotel = @Estado_Hotel,
        ID_Ciudad = @ID_Ciudad
    WHERE ID_Hotel = @ID_Hotel;
END;

EXEC SP_MODIFICAR_HOTEL @ID_Hotel = 1, @Nombre_Hotel = 'Hotel Paraíso Deluxe', 
@Direccion_Exacta = 'Avenida Central 123, San José', @Categoria = '5 estrellas', 
@Correo_Hotel = 'hotelparaiso@example.com', @Estado_Hotel = 'Activo', 
@ID_Ciudad = 1;


---SERVICIOS

---Insertar Servicio
CREATE PROCEDURE SP_INSERTAR_SERVICIO
    @Nombre_Servicio VARCHAR(100),
    @Descripcion VARCHAR(255),
    @ID_Hotel INT
AS
BEGIN
    INSERT INTO SERVICIOS (Nombre_Servicio, Descripcion, ID_Hotel)
    VALUES (@Nombre_Servicio, @Descripcion, @ID_Hotel);
    
    PRINT 'Servicio insertado correctamente.';
END;

EXEC SP_INSERTAR_SERVICIO 'Servicio de Spa', 'Masajes relajantes y tratamientos de belleza', 1;

---Eliminar Servicio
CREATE PROCEDURE SP_ELIMINAR_SERVICIO
    @ID_Servicio INT
AS
BEGIN
    DELETE FROM SERVICIOS
    WHERE ID_Servicio = @ID_Servicio;      
END;

EXEC SP_ELIMINAR_SERVICIO 51;


---TIPOS IDENTIFICACIÓN

---Insertar Tipo Identificación
CREATE PROCEDURE SP_INSERTAR_TIPO_IDENTIFICACION
@Descripcion VARCHAR(50)
AS
BEGIN
    INSERT INTO TIPOS_IDENTIFICACION (Descripcion)
    VALUES (@Descripcion);
END;

EXEC SP_INSERTAR_TIPO_IDENTIFICACION 'Pasaporte';

---Eliminar Tipo Identificación
CREATE PROCEDURE SP_ELIMINAR_TIPO_IDENTIFICACION
@ID_Tipo_Identificacion INT
AS
BEGIN
    DELETE FROM TIPOS_IDENTIFICACION
    WHERE ID_Tipo_Identificacion = @ID_Tipo_Identificacion;
END;

EXEC SP_ELIMINAR_TIPO_IDENTIFICACION 51;

---Modificar Tipo Identificación
CREATE PROCEDURE SP_MODIFICAR_TIPO_IDENTIFICACION
@ID_Tipo_Identificacion INT,
@Descripcion VARCHAR(50)
AS
BEGIN
    UPDATE TIPOS_IDENTIFICACION
    SET Descripcion = @Descripcion
    WHERE ID_Tipo_Identificacion = @ID_Tipo_Identificacion;
END;

EXEC SP_MODIFICAR_TIPO_IDENTIFICACION @ID_Tipo_Identificacion = 1, @Descripcion = 'Cédula de Identidad';


---CLIENTES

---Insertar Cliente
CREATE PROCEDURE SP_INSERTAR_CLIENTE
    @Nombre VARCHAR(50),
    @Apellido1 VARCHAR(50),
    @Apellido2 VARCHAR(50),
    @ID_Tipo_Identificacion INT,
    @Numero_Identificacion VARCHAR(50),
    @Correo VARCHAR(100),
    @Nacionalidad VARCHAR(50) -- Campo obligatorio agregado
AS
BEGIN
    INSERT INTO CLIENTES 
        (Nombre_Cliente, Apellido1_Cliente, Apellido2_Cliente, ID_Tipo_Identificacion, Numero_Identificacion, Correo_Cliente, Nacionalidad)
    VALUES 
        (@Nombre, @Apellido1, @Apellido2, @ID_Tipo_Identificacion, @Numero_Identificacion, @Correo, @Nacionalidad);
END;

EXEC SP_INSERTAR_CLIENTE 'Rosa', 'Mora', 'Gómez', 1, '123456789', 'rosamg@hotmail.com', 'Costa Rica';

---Eliminar Cliente
CREATE PROCEDURE SP_ELIMINAR_CLIENTE
    @ID_Cliente INT
AS
BEGIN
    DELETE FROM CLIENTES
    WHERE ID_Cliente = @ID_Cliente;
END;

EXEC SP_ELIMINAR_CLIENTE 51;

---Modificar Correo
CREATE PROCEDURE SP_MODIFICAR_CORREO_CLIENTE
    @ID_Cliente INT,
    @Correo VARCHAR(100)
AS
BEGIN
    UPDATE CLIENTES
    SET Correo_Cliente = @Correo
    WHERE ID_Cliente = @ID_Cliente;
END;

EXEC SP_MODIFICAR_CORREO_CLIENTE @ID_Cliente = 1, @Correo = 'juan.perez@hotmail.com';

--- MODIFICAR NOMBRE ---
CREATE PROCEDURE SP_MODIFICAR_NOMBRE_CLIENTE
    @ID_Cliente INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    UPDATE CLIENTES
    SET Nombre_Cliente = @Nombre
    WHERE ID_Cliente = @ID_Cliente;
END;

EXEC SP_MODIFICAR_NOMBRE_CLIENTE @ID_Cliente = 1, @Nombre = 'Juang';


---TELEFONOS

---Insertar Teléfono de Cliente
CREATE PROCEDURE SP_INSERTAR_TELEFONO_CLIENTE
    @Numero VARCHAR(20),
    @ID_Cliente INT
AS
BEGIN
    INSERT INTO TELEFONOS_CLIENTES (Numero_Telefono_Cliente, ID_Cliente)
    VALUES (@Numero, @ID_Cliente);
END;

EXEC SP_INSERTAR_TELEFONO_CLIENTE '+50681808288', 1;

---Eliminar Teléfono de Cliente
CREATE PROCEDURE SP_ELIMINAR_TELEFONO_CLIENTE
    @ID_Telefono_Cliente INT
AS
BEGIN
    DELETE FROM TELEFONOS_CLIENTES WHERE ID_Telefono_Cliente = @ID_Telefono_Cliente;
END;

EXEC SP_ELIMINAR_TELEFONO_CLIENTE 51;

---Insertar Teléfono de Hotel
CREATE PROCEDURE SP_INSERTAR_TELEFONO_HOTEL
    @Numero VARCHAR(20),
    @ID_Hotel INT
AS
BEGIN
    INSERT INTO TELEFONOS_HOTELES (Numero_Telefono_Hotel, ID_Hotel)
    VALUES (@Numero, @ID_Hotel);
END;

EXEC SP_INSERTAR_TELEFONO_HOTEL '+50622223333', 1;

---Actualizar Número de Teléfono de Hotel
CREATE PROCEDURE SP_MODIFICAR_TELEFONO_HOTEL
    @ID_Telefono_Hotel INT,
    @Numero_Telefono_Hotel VARCHAR(20)
AS
BEGIN
    UPDATE TELEFONOS_HOTELES 
    SET Numero_Telefono_Hotel = @Numero_Telefono_Hotel
    WHERE ID_Telefono_Hotel = @ID_Telefono_Hotel;
END;

EXEC SP_MODIFICAR_TELEFONO_HOTEL @ID_Telefono_Hotel = 1, @Numero_Telefono_Hotel = '+50633334444';


---HABITACIONES

---Insertar Habitación
CREATE PROCEDURE SP_INSERTAR_HABITACION
    @Numero INT, @Tipo VARCHAR(50), @Precio DECIMAL(10,2), @Estado VARCHAR(50), @ID_Hotel INT
AS
BEGIN
    INSERT INTO HABITACIONES (Numero_Habitacion, Tipo_Habitacion, Precio_Noche, Estado_Habitacion, ID_Hotel)
    VALUES (@Numero, @Tipo, @Precio, @Estado, @ID_Hotel);
END;

EXEC SP_INSERTAR_HABITACION 101, 'Doble', 120.00, 'Disponible', 1;

---Actualizar Estado de Habitación (Disponible/Ocupada/Limpieza)
CREATE PROCEDURE SP_MODIFICAR_ESTADO_HABITACION
    @ID_Habitacion INT,
    @Estado_Habitacion VARCHAR(50)
AS
BEGIN
    UPDATE HABITACIONES 
    SET Estado_Habitacion = @Estado_Habitacion 
    WHERE ID_Habitacion = @ID_Habitacion;
END;

EXEC SP_MODIFICAR_ESTADO_HABITACION @ID_Habitacion = 1, @Estado_Habitacion = 'Ocupada';


  ---RESERVACIONES

---Insertar Reservación
CREATE PROCEDURE SP_INSERTAR_RESERVACION
    @Fecha_Entrada DATE, @Fecha_Salida DATE, @Estado VARCHAR(50), @ID_Cliente INT, @ID_Habitacion INT
AS
BEGIN
    INSERT INTO RESERVACIONES (Fecha_Entrada, Fecha_Salida, Estado_Reservacion, ID_Cliente, ID_Habitacion)
    VALUES (@Fecha_Entrada, @Fecha_Salida, @Estado, @ID_Cliente, @ID_Habitacion);
END;

EXEC SP_INSERTAR_RESERVACION '2024-12-01', '2024-12-05', 'Confirmada', 1, 1;


---Consultar Reservaciones por Cliente
CREATE PROCEDURE SP_CONSULTAR_RESERVACIONES_CLIENTE
    @ID_Cliente INT
AS
BEGIN
    SELECT ID_Reservacion, Fecha_Entrada, Fecha_Salida, Estado_Reservacion, ID_Habitacion
    FROM RESERVACIONES
    WHERE ID_Cliente = @ID_Cliente;
END;

EXEC SP_CONSULTAR_RESERVACIONES_CLIENTE 1;


---EMPLEADOS

---Insertar Empleado
CREATE PROCEDURE SP_INSERTAR_EMPLEADO
    @DNI VARCHAR(20), 
    @Nombre VARCHAR(50), 
    @Apellido1 VARCHAR(50), 
    @Apellido2 VARCHAR(50), 
    @Puesto VARCHAR(50), 
    @Estado VARCHAR(50), 
    @ID_Hotel INT
AS
BEGIN
    INSERT INTO EMPLEADOS (DNI, Nombre_Empleado, Apellido1_Empleado, Apellido2_Empleado, Puesto, Estado_Empleado, ID_Hotel)
    VALUES (@DNI, @Nombre, @Apellido1, @Apellido2, @Puesto, @Estado, @ID_Hotel);
END;

EXEC SP_INSERTAR_EMPLEADO '123456789', 'Carlos', 'Sánchez', 'López', 'Recepcionista', 'Activo', 1;


---Modificar Puesto de Empleado
CREATE PROCEDURE SP_MODIFICAR_PUESTO_EMPLEADO
    @ID_Empleado INT,
    @Puesto VARCHAR(50)
AS
BEGIN
    UPDATE EMPLEADOS 
    SET Puesto = @Puesto 
    WHERE ID_Empleado = @ID_Empleado;
END;

EXEC SP_MODIFICAR_PUESTO_EMPLEADO @ID_Empleado = 1, @Puesto = 'Gerente de Recepción';

---CHECKIN Y CHECKOUT

---Insertar Check-in
CREATE PROCEDURE SP_INSERTAR_CHECKIN
    @Fecha_Checkin DATE,
    @Hora_Checkin TIME,
    @ID_Empleado INT,
    @ID_Reservacion INT
AS
BEGIN
    INSERT INTO CHECKIN (Fecha_Checkin, Hora_Checkin, ID_Empleado, ID_Reservacion)
    VALUES (@Fecha_Checkin, @Hora_Checkin, @ID_Empleado, @ID_Reservacion);    
END;

EXEC SP_INSERTAR_CHECKIN '2024-12-01', '14:00', 1, 1;

---Consultar Check-in por Reservación
CREATE PROCEDURE SP_CONSULTAR_CHECKIN_DETALLE
    @ID_Reservacion INT
AS
BEGIN
    SELECT C.ID_Checkin, C.Fecha_Checkin, C.Hora_Checkin, E.Nombre_Empleado, E.Apellido1_Empleado
    FROM CHECKIN C
    JOIN EMPLEADOS E ON C.ID_Empleado = E.ID_Empleado
    WHERE C.ID_Reservacion = @ID_Reservacion;
END;

EXEC SP_CONSULTAR_CHECKIN_DETALLE 1;


---Insertar Check-out
CREATE PROCEDURE SP_INSERTAR_CHECKOUT
    @Fecha_Checkout DATE,
    @Hora_Checkout TIME,
    @Cargos DECIMAL(10,2),
    @Total DECIMAL(10,2),
    @ID_Reservacion INT
AS
BEGIN
    INSERT INTO CHECKOUT (Fecha_Checkout, Hora_Checkout, Cargos, Total, ID_Reservacion)
    VALUES (@Fecha_Checkout, @Hora_Checkout, @Cargos, @Total, @ID_Reservacion);
END;

EXEC SP_INSERTAR_CHECKOUT '2024-12-05', '11:00', 50.00, 650.00, 1;


---Modificar Cargos y Total de un Check-out
CREATE PROCEDURE SP_MODIFICAR_MONTOS_CHECKOUT
    @ID_Checkout INT,
    @Cargos DECIMAL(10,2),
    @Total DECIMAL(10,2)
AS
BEGIN
    UPDATE CHECKOUT 
    SET Cargos = @Cargos, 
        Total = @Total
    WHERE ID_Checkout = @ID_Checkout;
END;

EXEC SP_MODIFICAR_MONTOS_CHECKOUT @ID_Checkout = 1, @Cargos = 75.00, @Total = 675.00;


       
---RESTAURANTES

---TIPOS RESTAURANTES

---Insertar
CREATE PROCEDURE SP_INSERTAR_TIPO_RESTAURANTE
    @Nombre_Tipo VARCHAR(50),
    @Descripcion VARCHAR(255)
AS 
BEGIN
    INSERT INTO TIPOS_DE_RESTAURANTES (Nombre_Tipo, Descripcion) 
    VALUES (@Nombre_Tipo, @Descripcion);
END;

EXEC SP_INSERTAR_TIPO_RESTAURANTE 'Gastronomía Molecular', 'Restaurante de alta cocina con técnicas de gastronomía molecular y presentaciones innovadoras';


---Eliminar Tipo Restaurante
CREATE PROCEDURE SP_ELIMINAR_TIPO_RESTAURANTE
    @ID_Tipo_Restaurante INT
AS
BEGIN
    DELETE FROM TIPOS_DE_RESTAURANTES 
    WHERE ID_Tipo_Restaurante = @ID_Tipo_Restaurante;
END;

EXEC SP_ELIMINAR_TIPO_RESTAURANTE 51;


---Modificar Descripción Tipo Restaurante
CREATE PROCEDURE SP_MODIFICAR_DESCRIPCION_TIPO_RESTAURANTE
    @ID_Tipo_Restaurante INT,
    @Descripcion VARCHAR(255)
AS
BEGIN
    UPDATE TIPOS_DE_RESTAURANTES 
    SET Descripcion = @Descripcion
    WHERE ID_Tipo_Restaurante = @ID_Tipo_Restaurante;
END;

EXEC SP_MODIFICAR_DESCRIPCION_TIPO_RESTAURANTE @ID_Tipo_Restaurante = 1, @Descripcion = 'Restaurante especializado en pastas, pizzas y cocina italiana tradicional con ingredientes frescos y auténticos';

---RESTAURANTES
---Insertar Restaurante
CREATE PROCEDURE SP_INSERTAR_RESTAURANTES
    @Nombre VARCHAR(100),
    @Capacidad INT,
    @Hora_Apertura TIME,
    @Hora_Cierre TIME,
    @ID_Tipo_Restaurante INT,
    @ID_Hotel INT
AS
BEGIN
    INSERT INTO RESTAURANTES (Nombre_Restaurante, Capacidad, Hora_Apertura, Hora_Cierre, ID_Hotel, ID_Tipo_Restaurante)
    VALUES (@Nombre, @Capacidad, @Hora_Apertura, @Hora_Cierre, @ID_Hotel, @ID_Tipo_Restaurante);
END;

EXEC SP_INSERTAR_RESTAURANTES 'La Cocina de Mamá', 50, '12:00:00', '22:00:00', 1, 1;


---Modificar Nombre Restaurante
CREATE PROCEDURE SP_MODIFICAR_NOMBRE_RESTAURANTE
    @ID_Restaurante INT,
    @Nombre VARCHAR(100)
AS
BEGIN
    UPDATE RESTAURANTES 
    SET Nombre_Restaurante = @Nombre 
    WHERE ID_Restaurante = @ID_Restaurante;
END;

EXEC SP_MODIFICAR_NOMBRE_RESTAURANTE @ID_Restaurante = 1, @Nombre = 'La Cocina de Mamá - Sabor Casero';


---RESERVACION RESTAURANTES

---Insertar Reservación Restaurante
CREATE PROCEDURE SP_INSERTAR_RESERVACION_RESTAURANTE
    @Fecha_Reservacion_Rest DATE,
    @Hora_Reservacion_Rest TIME,
    @Cantidad_Personas INT,
    @Estado VARCHAR(50),
    @ID_Cliente INT,
    @ID_Restaurante INT
AS
BEGIN 
    INSERT INTO RESERVACIONES_RESTAURANTE 
        (Fecha_Reservacion_Rest, Hora_Reservacion_Rest, Cantidad_Personas, Estado_Reservacion_Restaurante, ID_Cliente, ID_Restaurante)
    VALUES (@Fecha_Reservacion_Rest, @Hora_Reservacion_Rest, @Cantidad_Personas, @Estado, @ID_Cliente, @ID_Restaurante);
END;

EXEC SP_INSERTAR_RESERVACION_RESTAURANTE '2024-12-15', '19:00:00', 4, 'Confirmada', 1, 1;


---Modificar Estado Reservación Restaurante
CREATE PROCEDURE SP_MODIFICAR_ESTADO_RESERVACION_RESTAURANTE
    @ID_Reservacion_Restaurante INT,
    @Estado VARCHAR(50)
AS
BEGIN
    UPDATE RESERVACIONES_RESTAURANTE 
    SET Estado_Reservacion_Restaurante = @Estado
    WHERE ID_Reservacion_Restaurante = @ID_Reservacion_Restaurante;
END;

EXEC SP_MODIFICAR_ESTADO_RESERVACION_RESTAURANTE @ID_Reservacion_Restaurante = 1, @Estado = 'Cancelada';


---Modificar Hora Reservación Restaurante
CREATE PROCEDURE SP_MODIFICAR_HORA_RESERVACION_RESTAURANTE
    @ID_Reservacion_Restaurante INT,
    @Hora_Reservacion_Rest TIME
AS
BEGIN
    UPDATE RESERVACIONES_RESTAURANTE 
    SET Hora_Reservacion_Rest = @Hora_Reservacion_Rest
    WHERE ID_Reservacion_Restaurante = @ID_Reservacion_Restaurante;
END;

EXEC SP_MODIFICAR_HORA_RESERVACION_RESTAURANTE @ID_Reservacion_Restaurante = 1, @Hora_Reservacion_Rest = '20:00:00';

---FUNCIONES

---Contar Hoteles por Ciudad
CREATE FUNCTION FN_ContarHotelesPorCiudad (
    @IdCiudad INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Cantidad INT;

    SELECT @Cantidad = COUNT(*) 
    FROM HOTELES 
    WHERE ID_Ciudad = @IdCiudad;

    RETURN @Cantidad;
END;

---EJEMPLO DE USO DE LA FUNCIÓN
SELECT Nombre_Ciudad, dbo.FN_ContarHotelesPorCiudad(ID_Ciudad) AS 'Total Hoteles' FROM CIUDADES;

---Obtener Ubicación Completa de un Hotel
CREATE FUNCTION FN_ObtenerUbicacionHotel (
	@IdHotel INT
)
RETURNS VARCHAR(150)
AS
BEGIN
	---VARIABLES PARA CIUDAD Y PAIS
	DECLARE @Ciudad VARCHAR(50);
	DECLARE @Pais VARCHAR(50);
	DECLARE @UbicacionFinal VARCHAR(150);

	SELECT @Ciudad = C.Nombre_Ciudad, @Pais = C.Pais 
	FROM HOTELES H
	JOIN CIUDADES C ON H.ID_Ciudad = C.ID_Ciudad
	WHERE H.ID_Hotel = @IdHotel;

	SET @UbicacionFinal = @Ciudad + ', ' + @Pais;
	
	RETURN @UbicacionFinal;
END;

---EJEMPLO DE USO DE LA FUNCIÓN
SELECT Nombre_Hotel, dbo.FN_ObtenerUbicacionHotel(ID_Hotel) AS 'Ubicación Geográfica' 
FROM HOTELES;


---Obtener Nombre Completo de Empleado
CREATE FUNCTION FN_ObtenerNombreCompletoEmpleado (
    @IdEmpleado INT
)
RETURNS VARCHAR(150)
AS
BEGIN
    DECLARE @NombreCompleto VARCHAR(150);

    SELECT @NombreCompleto = Nombre_Empleado + ' ' + Apellido1_Empleado + ' ' + Apellido2_Empleado
    FROM EMPLEADOS
    WHERE ID_Empleado = @IdEmpleado;

    RETURN @NombreCompleto;
END;

---EJEMPLO DE USO DE LA FUNCIÓN
SELECT dbo.FN_ObtenerNombreCompletoEmpleado(1) AS 'Empleado del Mes';


---Calcular Espacio Disponible en Restaurante
CREATE FUNCTION FN_CalcularEspacioDisponibleRestaurante (
    @IdRestaurante INT,
    @Fecha DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @CapacidadTotal INT;
    DECLARE @OcupacionActual INT;
    DECLARE @Disponible INT;

    SELECT @CapacidadTotal = Capacidad FROM RESTAURANTES WHERE ID_Restaurante = @IdRestaurante;
    
    SELECT @OcupacionActual = ISNULL(SUM(Cantidad_Personas), 0) 
    FROM RESERVACIONES_RESTAURANTE 
    WHERE ID_Restaurante = @IdRestaurante AND Fecha_Reservacion_Rest = @Fecha;

    SET @Disponible = @CapacidadTotal - @OcupacionActual;

    RETURN @Disponible;
END;

---EJEMPLO DE USO DE LA FUNCIÓN
SELECT dbo.FN_CalcularEspacioDisponibleRestaurante(1, '2026-01-05') AS 'Espacios Libres';

---Convertir Precio de Dólares a Colones
CREATE FUNCTION F_ConvertirDolaresAColones (
	@IdHabitacion INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @PrecioDolares DECIMAL(10, 2);
	DECLARE @TipoCambio DECIMAL(10, 2) = 480.00; 
	DECLARE @PrecioColones DECIMAL(10, 2);

	SELECT @PrecioDolares = Precio_Noche 
	FROM HABITACIONES 
	WHERE ID_Habitacion = @IdHabitacion;

	SET @PrecioColones = @PrecioDolares * @TipoCambio;
	
	RETURN @PrecioColones;
END;

---EJEMPLO DE USO DE LA FUNCIÓN
SELECT 
    Numero_Habitacion, 
    Precio_Noche AS 'Precio USD', 
    dbo.F_ConvertirDolaresAColones(ID_Habitacion) AS 'Precio CRC'
FROM HABITACIONES;


---VISTAS