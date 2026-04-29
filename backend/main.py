from fastapi import FastAPI, HTTPException
from sqlalchemy import create_engine, text
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

app = FastAPI(title="ECHO")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

# Conexión a la base de datos
DATABASE_URL = "mysql+mysqlconnector://root:root@db/echo_db"
engine = create_engine(DATABASE_URL)

@app.get("/capitulo/{id_capitulo}")
def leer_capitulo(id_capitulo: int):
    try:
        with engine.connect() as conn:
            # 1. Traer el texto del capitulo
            res_cap = conn.execute(
                text("SELECT titulo, contenido FROM capitulos WHERE id_capitulo = :id"),
                {"id": id_capitulo}
            ).fetchone()
            
            if not res_cap:
                raise HTTPException(status_code=404, detail="Capitulo no encontrado")

            # 2. Buscar si tiene acertijo
            res_acertijo = conn.execute(
                text("SELECT pregunta FROM acertijos WHERE id_capitulo = :id"),
                {"id": id_capitulo}
            ).fetchone()
            
            # 3. Traer opciones de decision
            resp_opcion = conn.execute(
                text("SELECT id_decision, texto_opcion, id_capitulo_destino FROM decisiones WHERE id_capitulo_origen = :id"),
                {"id": id_capitulo}
            ).fetchall()

            # 4. Construir el objeto de datos
            data = {
                "titulo": res_cap.titulo,
                "contenido": res_cap.contenido,
                "acertijo": res_acertijo.pregunta if res_acertijo else None,
                "opciones": [
                    {"id": r.id_decision, "texto": r.texto_opcion, "destino": r.id_capitulo_destino} 
                    for r in resp_opcion
                ]
            }

            # ÚNICO RETURN: Forzamos UTF-8 para evitar los símbolos como Â¿
            return JSONResponse(
                content=data, 
                media_type="application/json; charset=utf-8"
            )
            
    except Exception as e:
        print(f"Error en base de datos: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/validar/{id_capitulo}")
def validar_capitulo(id_capitulo: int, respuesta: str):
    with engine.connect() as conn:
        res = conn.execute(
            text("SELECT respuesta_correcta FROM acertijos WHERE id_capitulo = :id"),
            {"id": id_capitulo}
        ).fetchone()
        
        if res and respuesta.strip().lower() == str(res.respuesta_correcta).lower():
            return {"status": "success", "mensaje": "Acceso concedido"}
        return {"status": "error", "mensaje": "Respuesta incorrecta"}