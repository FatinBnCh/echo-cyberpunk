#  PROJECT ECHO: Cyberpunk Interactive Terminal 

> **[ALERT] FIREWALL DETECTED.** Accediendo a los fragmentos de memoria de Valentina... ¿Serás capaz de eludir la cripta de datos y ejecutar la reparación del sistema?

---

##  Despliegue en Vivo / Live Demo

¡Puedes probar la experiencia interactiva completa de este proyecto de manera inmediata sin necesidad de configuraciones locales pinchando en el siguiente enlace!

<div align="center">
  <br />
  <a href="https://echo-cyberpunk.vercel.app/" target="_blank">
    <img src="https://img.shields.io/badge/%E2%96%B6_LIVE_DEMO-%F0%9F%9F%A2_EJECUTAR_JUEGO-00ff00?style=for-the-badge&logo=vercel&logoColor=black&labelColor=000000" alt="Live Demo" height="50">
  </a>
  <br />
  <sub><i>Nota: El juego requiere que el clúster de servidores de backend domésticos esté encendido para procesar los acertijos.</i></sub>
  <br /><br />
</div>

---

##  Descripción del Proyecto

**PROJECT ECHO** es un videojuego interactivo de texto, misterio y acertijos con una inmersión estética inspirada en la terminal de Matrix y la cultura *cyberpunk* retro. El juego sitúa al usuario frente a una simulación de consola CRT antigua con errores de memoria corrupta. A través de la resolución de retos, interactuando con mecánicas de decodificación binaria y superando cortafuegos de seguridad, el jugador desentraña una narrativa oculta en una base de datos distribuida.

###  Características Visuales y Sonoras
* **Efecto CRT & Scanlines:** Recreación nostálgica de las antiguas pantallas de fósforo verde.
* **Matrix Code Rain Canvas:** Fondo dinámico interactivo renderizado mediante HTML5 Canvas en tiempo real.
* **Diseño de Sonido Adaptativo:** Banda sonora ambiental ciberpunk y efectos sonoros interactivos para aciertos, errores y finales alternativos.
* **Respuestas en Tiempo Real:** Validación dinámica de acertijos conectando de manera asíncrona con servicios de backend.

---

##  Tecnologías Utilizadas

El proyecto se divide en una arquitectura desacoplada moderna (*Frontend / Backend / Database*):

###  Frontend
* **React (JSX) + Vite:** Entorno de desarrollo ultra rápido y componentes modulares de interfaz.
* **HTML5 Canvas:** Lluvia de código en cascada optimizada por hardware.
* **CSS3 Custom Properties:** Estilos inmersivos con animaciones cronometradas y paleta de colores neón fosforescente.

###  Backend y Base de Datos
* **Python + FastAPI:** API REST asíncrona de alta velocidad para la validación lógica de los acertijos del cortafuegos.
* **SQL Database Engine:** Almacenamiento seguro del registro de puzzles, datos de la cripta y estados del juego.

---

##  Arquitectura de Red e Infraestructura Doméstica

Una de las piezas clave de este proyecto es su infraestructura de servidores híbrida. El entorno se aloja de forma distribuida combinando la computación en la nube y el auto-alojamiento local (*self-hosting*):

```text
       [ PROFESORES / JUGADORES ]
                   │
                   ▼ (Acceso Web Público)
       ┌────────────────────────┐
       │   Vercel Cloud Host    │ ─── Condicionado por políticas HTTPS
       │  (React-Vite Frontend) │
       └────────────────────────┘
                   │
                   ▼ (Peticiones API seguras)
       ┌────────────────────────┐
       │   Cloudflare Tunnel    │ ─── Proxy seguro HTTPS (Bypass CG-NAT)
       └────────────────────────┘
                   │
                   ▼ (Tráfico Enrutado a Red Local)
┌─────────────────────────────────────────────────────────────┐
│ SERVIDOR DOMÉSTICO (Entorno de Virtualización)              │
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Máquina Virtual: VirtualBox (Ubuntu Server)           │  │
│  │                                                       │  │
│  │  ┌───────────────┐  ▲             ┌────────────────┐  │  │
│  │  │ Visual Studio │  │ (Remote     │ Docker Compose │  │  │
│  │  │ Code IDE      │  └─ SSH)       │    Clúster App │  │  │
│  │  └───────────────┘                └────────┬───────┘  │  │
│  │                                            │          │  │
│  │               ┌────────────────────────────┴───────┐  │  │
│  │               ▼                                    ▼  │  │
│  │  ┌────────────────────────┐            ┌────────────────┐│  │
│  │  │ Contenedor: API Python │ ────────▶  │Contenedor: SQL ││  │
│  │  │ (FastAPI App Engine)   │            │(Data Engine)   ││  │
│  │  └────────────────────────┘            └────────────────┘│  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
