import { useEffect, useRef, useState } from 'react';
import fondoFinalFeliz from '../src/assets/fondo_inicio.jpg';

const API_URL = "https://conjunction-diesel-classes-happy.trycloudflare.com/capitulo/";
const VALIDAR_URL = "https://conjunction-diesel-classes-happy.trycloudflare.com/validar/";

export default function Juego() {
  const canvasRef = useRef(null);
  const [capitulo, setCapitulo] = useState(null);
  const [termLines, setTermLines] = useState([]);
  const [mensajeSistema, setMensajeSistema] = useState("");
  const [respuesta, setRespuesta] = useState("");
  const [time, setTime] = useState(new Date().toISOString().replace('T', ' ').slice(0, 19));
  const [acertijoResuelto, setAcertijoResuelto] = useState(false);

  const audioAmbiente = useRef(null);
  const audioError = useRef(null);
  const audioSuccess = useRef(null);
  const audioClick = useRef(null);
  const audioFinalBueno = useRef(null);
  const audioFinalMalo = useRef(null);

  if (!audioAmbiente.current) {
    audioAmbiente.current = new Audio('/sounds/ambiente.mp3');
    audioError.current = new Audio('/sounds/error.mp3');
    audioSuccess.current = new Audio('/sounds/suceso2.mp3');
    audioClick.current = new Audio('/sounds/suceso.mp3');
    audioFinalBueno.current = new Audio('/sounds/finafeliz.mp3');
    audioFinalMalo.current = new Audio('/sounds/finalmalo.mp3');
  }

  // GAME OVER
  const [gameOver, setGameOver] = useState(false);
  const [mensajeFinal, setMensajeFinal] = useState("");
  // GOOD ENDING
  const [isGoodEnding, setIsGoodEnding] = useState(false);

  // Arrancar el audio ambiente nada más montar el componente
  useEffect(() => {
    audioAmbiente.current.loop = true;
    audioAmbiente.current.volume = 0.4;
    // el usuario ya hizo clic en tu pantalla de inicio
    audioAmbiente.current.play().catch(e => console.log("Audio bloqueado por el navegador", e));

    //para que no siga sonando si vas a otra ruta
    return () => {
      audioAmbiente.current.pause();
    };
  }, []);

  //efecto matrix
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    const chars = "ｦｱｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ23456789";
    const fontSize = 10;
    const columns = canvas.width / fontSize;
    const drops = Array(Math.floor(columns)).fill(1);
    const draw = () => {
      ctx.fillStyle = "rgba(0, 0, 0, 0.035)";
      ctx.fillRect(0, 0, canvas.width, canvas.height);
      ctx.font = `${fontSize}px monospace`;
      for (let i = 0; i < drops.length; i++) {
        const text = chars.charAt(Math.floor(Math.random() * chars.length));
        const x = i * fontSize;
        const y = drops[i] * fontSize;
        if (Math.random() > 0.98) {
          ctx.fillStyle = "#ccffcc";
          ctx.shadowBlur = 18;
        } else {
          ctx.fillStyle = "#00ff41";
          ctx.shadowBlur = 8;
        }
        ctx.fillText(text, x, y);
        if (y > canvas.height && Math.random() > 0.985) drops[i] = 0;
        drops[i] += Math.random() * 1.2;
      }
    };
    const interval = setInterval(draw, 33);
    const timeInterval = setInterval(() => setTime(new Date().toISOString().replace('T', ' ').slice(0, 19)), 1000);
    return () => { clearInterval(interval); clearInterval(timeInterval); };
  }, []);



  const typeSingleLine = (text, type) => {
    return new Promise(resolve => {
      setTermLines(prev => [...prev, { text: "", type: type, isFinished: false }]);
      let acumulado = "";
      let i = 0;
      
      const timer = setInterval(() => {
        acumulado += text.charAt(i);
        setTermLines(prev => {
          const newLines = [...prev];
          if (newLines.length > 0) newLines[newLines.length - 1].text = acumulado;
          return newLines;
        });
        i++;
        if (i >= text.length) {
          clearInterval(timer);
          setTermLines(prev => {
            const newLines = [...prev];
            if (newLines.length > 0) newLines[newLines.length - 1].isFinished = true;
            return newLines;
          });
          resolve();
        }
      }, 30);
    });
  };

  const parseChapterContent = (content) => {
    if (!content) return [];
    const lines = content.split('\n').filter(line => line.trim() !== "");
    return lines.map(line => {
      let type = 'line';
      let text = line.trim();
      if (text.startsWith('>>')) type = 'header';
      else if (text.startsWith('ECHO >')) type = 'echo';
      return { type, text };
    });
  };

  const loadChapter = async (id) => {
    try {
      // 1. Sonido de click cada vez que se elige una ruta
      audioClick.current.currentTime = 0;
      audioClick.current.play().catch(() => {});

      const response = await fetch(`${API_URL}${id}`);
      const data = await response.json();

      // 2. DETECCIÓN DE FINALES
      if (id === 19) {
        audioAmbiente.current.pause(); // Paramos el zumbido de ordenador viejo
        audioFinalBueno.current.currentTime = 0;
        audioFinalBueno.current.play().catch(e => console.error("Error audio:", e));
        setIsGoodEnding(true); // Activamos la pantalla especial
        return;
      } else if (id === 20) {
        audioAmbiente.current.pause();
        audioFinalMalo.current.play().catch(() => {});
        setGameOver(true);
        setMensajeFinal("SISTEMA DAÑADO");
        return;
      }
      
      setCapitulo(data);
      setTermLines([]);
      setMensajeSistema("");
      setRespuesta("");
      setAcertijoResuelto(false);
      const linesToType = parseChapterContent(data.contenido);
      for (const line of linesToType) {
        await typeSingleLine(line.text, line.type);
        await new Promise(r => setTimeout(r, 200)); 
      }
    } catch (e) {
      setMensajeSistema("!! ERROR: NÚCLEO ECHO FUERA DE LÍNEA");
    }
  };

  useEffect(() => { loadChapter(1); }, []);

  const validarRespuesta = async () => {
    if (!capitulo) return;
    const res = await fetch(`${VALIDAR_URL}${capitulo.id}?respuesta=${respuesta}`);
    const data = await res.json();
    if (data.status === "success") {
      audioSuccess.current.currentTime = 0;
      audioSuccess.current.play().catch(() => {});
      setMensajeSistema(">> FIREWALL DESACTIVADO. ACCESO A RUTAS DESBLOQUEADO.");
      setAcertijoResuelto(true);
    } else {
      audioError.current.currentTime = 0;
      audioError.current.play().catch(() => {});
      setMensajeSistema("!! ACCESO DENEGADO: CÓDIGO ERRÓNEO.");
    }
  };

  if (!capitulo) {
    return (
      <div className="crt-overlay">
        <canvas ref={canvasRef} id="matrix-canvas"></canvas>
        <div id="full-screen-terminal-container">
            <p className="echo-line">INICIANDO NÚCLEO ECHO...</p>
            <p className="line-line">CONECTANDO CON LA BASE DE DATOS EN DOCKER...</p>
        </div>
      </div>
    );
  }

  if (gameOver) {
  return (
    <div className="game-over-screen">
      <h1 className="critical-text">{mensajeFinal}</h1>
      <p className="retry-question">¿Desea reiniciar el núcleo y reintentar la experiencia?</p>
      
      <div className="retry-options">
        <button className="btn-retry" onClick={() => window.location.href = "/"}>
             REINICIAR 
        </button>
        <button className="btn-retry" onClick={() => {
          setMensajeFinal("GRACIAS POR PARTICIPAR EN ECHO");
          //ocultar botones tras elegir NO
          document.querySelector('.retry-options').style.display = 'none';
        }}>
          SALIR 
        </button>
      </div>
    </div>
  );
}

if (isGoodEnding) {
    return (
      <div className="good-ending-screen">
        {/* Usamos un div intermedio para centrar y dimensionar el monitor */}
        <div className="monitor-wrapper" style={{ backgroundImage: `url(${fondoFinalFeliz})` }}>
          
          <div className="monitor-patch">
            <p className="status-text">SYSTEM RESTORED</p>
            <p className="status-text">MEMORY INTACT</p>
            <p className="status-text">ECHO.EXE ONLINE</p>
            <br />
            
            <button className="btn-retry" onClick={() => window.location.href = "/"}>
               REINICIAR SISTEMA 
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="crt-overlay">
      <canvas ref={canvasRef} id="matrix-canvas"></canvas>
      
      <div id="full-screen-terminal-container">
        <div id="terminal-header">
            <div className="header-item">{`> SYS_TIME: ${time} `}</div>
            <div className="header-center">
                <div>{'>>'} ESTADO: CONECTADO</div>
                <div>{'>>'} SECTOR {capitulo?.id}...</div>
            </div>
            <div className="header-item">{`> NODE: echonode_admin [AUTHORIZED]`}</div>
        </div>

        <hr className="terminal-separator" />

        <div id="terminal-log">
            {termLines.map((line, index) => (
                <p key={index} className={`term-line ${line.type}-line`}>{line.text}</p>
            ))}
        </div>

        {capitulo?.acertijo && termLines.length > 0 && termLines[termLines.length - 1].isFinished && !acertijoResuelto && (
          <div id="firewall-area">
            <p className="alert-text">[ALERT] FIREWALL DETECTED</p>
            <p className="puzzle-text">{`[RETO]: ${capitulo.acertijo}`}</p>
            <div className="input-line">
                <span>INPUT &gt; </span>
                <input 
                  type="text" 
                  value={respuesta}
                  onChange={(e) => setRespuesta(e.target.value)}
                  onKeyDown={(e) => e.key === 'Enter' && validarRespuesta()}
                  autoFocus 
                  autoComplete="off"
                />
            </div>
          </div>
        )}

        {mensajeSistema && (
            <div id="system-message" className={mensajeSistema.includes('!!') ? 'error' : 'success'}>
              {mensajeSistema}
            </div>
        )}

        {capitulo?.opciones && capitulo.opciones.length > 0 && termLines.length > 0 && termLines[termLines.length - 1].isFinished && (!capitulo.acertijo || acertijoResuelto) && (
          <div id="options-integrated">
            {capitulo.opciones.map((opt, index) => (
              <button key={index} className="option-integrated" onClick={() => loadChapter(opt.destino)}>
                {`[${index + 1}] > ${opt.texto}`}
              </button>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}