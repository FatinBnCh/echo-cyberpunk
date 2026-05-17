import { useState } from 'react';
import './App.css';
import Juego from './Juego';

function App() {
  const [gameStarted, setGameStarted] = useState(false);
  const [repairing, setRepairing] = useState(false);

  const startRepair = () => {
    setRepairing(true);
    setTimeout(() => {
      setGameStarted(true);
    }, 1500);
  };

  if (gameStarted) {
    return <Juego />;
  }

  return (
    <div className="crt-overlay">
      <div className={`escena-pixel ${repairing ? 'glitch-flash' : ''}`}>
        <div className="contenedor-inicio">
          <div className="status-text glitch-red">
            {repairing ? "INICIANDO DEBUG..." : "SYSTEM FAILURE\nMEMORY CORRUPT\nECHO.EXE NOT FOUND"}
          </div>
          
          <button 
            className="boton-pixel-start" 
            onClick={startRepair}
            disabled={repairing}
          >
            {repairing ? "Reparando..." : "Ejecutar Reparación"}
          </button>
        </div>
      </div>
    </div>
  );
}

export default App;