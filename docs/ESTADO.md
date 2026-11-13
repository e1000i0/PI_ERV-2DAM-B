# Estado del proyecto

Archivo de traspaso entre sesiones de trabajo. Quien termine una sesión lo actualiza antes de cerrar: sustituye «Ahora mismo» y «Siguiente paso» y añade una línea al registro (lo más reciente arriba).

## Ahora mismo

- Fase de diseño terminada: requisitos, MVP, arquitectura, modelo de datos (9 tablas), wireframes y licencia MIT.
- Plan del Sprint S1 aprobado por Emilio. Todavía no hay código.
- Rama activa: `docs/plan-s1` (planificación).

## Siguiente paso

Revisar e integrar el PR del plan. Al comenzar el sprint, Emilio creará las issues en GitHub Projects y empezará por S1-01. Las tareas se ejecutarán en secuencia, con Emilio participando en la primera ejecución y revisión de cada bloque.

## Sprint S1 · 16–29 de noviembre de 2026

El sprint abarca el repositorio, Docker, CI y el esqueleto de la API. Desde un clon limpio, `docker compose up` debe levantar la API, MySQL y MinIO. GitHub Actions debe compilar y probar la API en los PR a `main`.

### Estructura acordada

| Ruta | Contenido |
| --- | --- |
| `backend/` | Proyecto Spring Boot, configuración de Maven, Maven Wrapper y Dockerfile de la API. |
| `backend/src/main/java/io/github/e1000i0/hanger/` | Punto de entrada y código Java de la API. |
| `backend/src/main/java/io/github/e1000i0/hanger/controller/` | Controladores REST. |
| `backend/src/main/java/io/github/e1000i0/hanger/service/` | Lógica de negocio. |
| `backend/src/main/java/io/github/e1000i0/hanger/repository/` | Acceso a datos. |
| `backend/src/main/java/io/github/e1000i0/hanger/entity/` | Entidades persistentes. |
| `backend/src/main/java/io/github/e1000i0/hanger/dto/` | Objetos de entrada y salida de la API. |
| `backend/src/main/resources/` | Configuración y recursos de Spring Boot. |
| `backend/src/test/java/` | Pruebas con la misma jerarquía de paquetes que el código de producción. |
| `app/` | Proyecto Ionic + Angular + Capacitor, que se inicializará en S5. |
| `app/src/app/` | Rutas, pantallas y componentes Angular. |
| `app/src/assets/` | Recursos estáticos de la app. |
| `app/src/theme/` | Variables y estilos del tema Ionic. |
| `database/` | Esquema SQL existente para inicializar la base de datos. |
| `docs/` | Estado del proyecto, documentación y diagramas. |
| `.github/workflows/` | Flujo de CI de GitHub Actions. |

El archivo de Compose, `.env.example` y `.gitignore` quedarán en la raíz. Los directorios de cada capa y de la app se crearán al incorporar sus primeros archivos.

### Decisiones técnicas

- Java 21 LTS en local, Docker y CI. Spring Boot 4.1.x con un parche estable fijado al inicializar el proyecto. Maven con Maven Wrapper.
- MySQL 8.4 LTS. Compose aplicará `database/schema.sql` a un volumen nuevo. La conexión de Spring Boot con MySQL se incorporará en S2.
- MinIO se construirá localmente desde el código fuente de la etiqueta oficial `RELEASE.2025-10-15T17-29-55Z`.
- Spring Boot Actuator ofrecerá `GET /actuator/health`. La comprobación espera HTTP 200 y el estado `UP`, con independencia de MySQL y MinIO.

### Issues en orden de ejecución

Estimación total: **14 h**. Usar el proyecto de GitHub Projects existente si ya lo hay. Si se crea uno, llamarlo **HANGER** y añadir el campo de iteración **Sprint** con **S1** (16–29 de noviembre de 2026) y el campo numérico **Estimación (h)**. Incluir la rama y los criterios de aceptación en el cuerpo de cada issue.

| Issue | Est. | Rama | Objetivo | Criterios de aceptación |
| --- | --- | --- | --- | --- |
| S1-01 · Preparar exclusiones del repositorio | 1 h | `feat/exclusiones-repositorio` | Evitar que se versionen archivos locales y salidas de compilación. | El `.gitignore` de la raíz excluye `.env` y los artefactos de Maven. `.env.example` se puede versionar. |
| S1-02 · Inicializar el proyecto Spring Boot | 2 h | `feat/base-api-spring-boot` | Crear la aplicación base en `backend/`. | El proyecto fija la versión de Spring Boot, incluye el Maven Wrapper y usa el paquete `io.github.e1000i0.hanger`. Compila y arranca con Java 21. |
| S1-03 · Añadir la comprobación HTTP de la API | 2 h | `feat/comprobacion-http-api` | Verificar por HTTP que la API responde. | Una prueba automatizada verifica que `GET /actuator/health` devuelve HTTP 200 y estado `UP` sin requerir contenedores de MySQL ni MinIO. |
| S1-04 · Construir la imagen Docker de la API | 2 h | `feat/imagen-docker-api` | Empaquetar la API para ejecutarla en un contenedor. | El Dockerfile de `backend/` construye la imagen con Java 21 desde el repositorio. El contenedor arranca con la configuración documentada y responde en la ruta de salud. |
| S1-08 · Construir la imagen local de MinIO | 2 h | `feat/imagen-docker-minio` | Obtener una imagen reproducible del servicio de almacenamiento. | La imagen se construye desde la etiqueta acordada, el contenedor arranca y el servicio responde en local. |
| S1-05 · Levantar la API, MySQL y MinIO con Compose | 3 h | `feat/entorno-docker-compose` | Integrar los tres servicios en el entorno local. | Con las variables de `.env.example` configuradas, `docker compose up` levanta los tres servicios. La ruta HTTP responde y MinIO es accesible. Un volumen nuevo de MySQL se inicializa con las nueve tablas del esquema existente. Las tablas siguen disponibles tras reiniciar los servicios. `.env.example` carece de credenciales reales. |
| S1-06 · Verificar la API en GitHub Actions | 1 h | `feat/ci-api` | Compilar y probar la API en cada PR a `main`. | Una ejecución en un PR muestra el resultado de `./mvnw verify` con Java 21. Un fallo de compilación o de pruebas hace fallar el flujo. |
| S1-07 · Documentar y verificar el arranque desde un clon limpio | 1 h | `docs/arranque-s1` | Dejar instrucciones reproducibles para el siguiente sprint. | El README y la sección de comandos de AGENTS.md recogen los requisitos y los comandos de compilación, pruebas y arranque. Al seguirlos desde un clon limpio se verifica la construcción de MinIO, el arranque de Compose y la respuesta HTTP de la API. |

## Pendiente fuera del código

- Wireframes en Figma antes del Sprint S5.
- Usuario de pruebas e importador de la colección de prendas de prueba.

## Registro

| Fecha | Rama | Qué se hizo |
| --- | --- | --- |
| 13/11/2026 | `docs/plan-s1` | Se registra el plan aprobado del Sprint S1, con la estructura, las decisiones técnicas y el orden de las issues. |
| 13/11/2026 | — | Se añaden `AGENTS.md` y `docs/ESTADO.md` para trabajar con varios agentes. |
