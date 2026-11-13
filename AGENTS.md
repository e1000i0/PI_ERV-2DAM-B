# AGENTS.md — HANGER

Instrucciones para cualquier agente que trabaje en este repositorio. Léelas enteras antes de tocar nada.

## Qué es

HANGER es un armario virtual: el usuario registra sus prendas, crea outfits y la app detecta las prendas poco usadas para reutilizarlas, venderlas o donarlas. Es el proyecto intermodular (PI) de 2.º DAM de Emilio Ruiz Vázquez, curso 2026/2027. Es un proyecto individual: Emilio es Product Owner, Scrum Master y Developer.

- Descripción, stack, arquitectura y planificación de sprints: [`README.md`](README.md)
- Modelo de datos: [`database/schema.sql`](database/schema.sql) y [`docs/DIAGRAMA_ER_BBDD.png`](docs/DIAGRAMA_ER_BBDD.png)
- **Estado actual y siguiente tarea: [`docs/ESTADO.md`](docs/ESTADO.md)** ← empieza siempre por aquí

## Decisiones cerradas (no reabrir sin que Emilio lo pida)

- Stack: Ionic + Angular + Capacitor (APK y PWA), Spring Boot en capas (controladores, servicios, repositorios, entidades/DTOs) con JWT, MySQL/MariaDB, Docker, GitHub Actions, Swagger/OpenAPI. Flutter + Firebase está descartado.
- Base de datos de 9 tablas. Las temporadas van en `prenda_temporada` (una fila por temporada; todo el año = las cuatro). La temporada de un outfit no se guarda: se calcula con las comunes a sus prendas.
- Imágenes en almacenamiento compatible con S3 (MinIO en el sandbox). `prendas.imagen_clave` guarda la clave del objeto, nunca una URL. Al subir: validar el tipo real, quitar EXIF y generar miniatura. Cada imagen solo la ve su propietario.
- Recomendaciones por reglas, sin IA. Tiendas, Vinted y parte social quedan fuera del MVP.
- Opcionales (solo si sobra tiempo): etiquetas libres, favoritos y estadísticas.
- Despliegue automático desde GitHub a un sandbox con Docker (obligatorio por las bases del módulo).

## Cómo trabajar

1. Lee `docs/ESTADO.md` y coge la tarea que indique. Si no está claro qué hacer, pregunta a Emilio; no elijas tú el alcance.
2. Trabaja en una rama propia por tarea: `feat/<tema>`, `fix/<tema>` o `docs/<tema>`. Nunca hagas commit directo en `main`.
3. No trabajes en una rama que tenga otro agente activo (lo indica `docs/ESTADO.md`).
4. Los cambios entran en `main` mediante pull request que revisa Emilio.
5. Al terminar la sesión, **actualiza `docs/ESTADO.md`**: qué has hecho, qué queda a medias, problemas encontrados y siguiente paso. Es lo que usará el siguiente agente.

## Reglas

- **No inventes ni supongas datos** (fechas, cifras, requisitos, decisiones). Si falta algo, pregunta a Emilio.
- Haz lo que pide la tarea, ni más ni menos. No añadas funcionalidades fuera del MVP.
- Cambios en `database/schema.sql` o en las decisiones cerradas: solo con el visto bueno de Emilio.
- Idioma: español para documentación, commits, comentarios y nombres del dominio (prenda, outfit, temporada…). Cuida la ortografía: se evalúa.
- Commits pequeños y descriptivos, en español y en imperativo (p. ej. "Añade endpoint de login").
- Documentos generados por script en `tools/`; formato limpio y funcional.
- El repositorio es público: no subas credenciales, `.env`, claves ni datos personales. No menciones en el repo qué herramientas o modelos de IA se han usado.
- Los secretos van en variables de entorno; deja un `.env.example` sin valores reales.

## Comandos

*Pendiente del Sprint S1.* Objetivo: `docker compose up` levanta la API, la base de datos y MinIO. Quien monte la estructura del proyecto debe añadir aquí los comandos de build, test y arranque.
