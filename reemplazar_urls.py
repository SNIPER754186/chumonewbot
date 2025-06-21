import os
import re

# ⚙️ RUTA A TU PROYECTO LOCAL
DIRECTORIO_RAIZ = r"C:\Users\uknown\Documents\GitHub\chumonewbot"

# 🌐 URL BASE DE TU GITHUB
NUEVA_BASE = "https://raw.githubusercontent.com/SNIPER754186/chumonewbot/refs/heads/LaTamSRC/"

# 🔍 Soporta:
PATRONES = [
    re.compile(r"https://raw\.githubusercontent\.com/[^/]+/[^/]+/main/(.+?)(?=[\")\s])"),
    re.compile(r"https://github\.com/[^/]+/[^/]+/raw/main/(.+?)(?=[\")\s])")
]

EXTENSIONES_VALIDAS = (".sh", ".py", ".txt", ".bot", ".gen", ".crt", ".conf", ".ini", ".cfg", ".md")

def reemplazar_urls_en_archivo(ruta):
    with open(ruta, "r", encoding="utf-8", errors="ignore") as f:
        contenido = f.read()

    contenido_original = contenido

    for patron in PATRONES:
        contenido = patron.sub(lambda m: NUEVA_BASE + m.group(1), contenido)

    if contenido != contenido_original:
        with open(ruta, "w", encoding="utf-8") as f:
            f.write(contenido)
        print(f"✅ Rutas reemplazadas en: {ruta}")

def recorrer_directorio():
    for carpeta_raiz, _, archivos in os.walk(DIRECTORIO_RAIZ):
        for archivo in archivos:
            if archivo.endswith(EXTENSIONES_VALIDAS):
                ruta_completa = os.path.join(carpeta_raiz, archivo)
                reemplazar_urls_en_archivo(ruta_completa)

if __name__ == "__main__":
    recorrer_directorio()
