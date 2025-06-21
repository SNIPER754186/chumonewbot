import requests
import re
import sys

def _reverse_string(s):
    """Invierte una cadena de texto."""
    return s[::-1]

def _deobfuscate_ofus(text):
    """Desofusca una cadena usando el algoritmo 'ofus'."""
    replacements = {
        ".": "x", "x": ".",
        "5": "s", "s": "5",
        "1": "@", "@": "1",
        "2": "?", "?": "2",
        "4": "0", "0": "4",
        "/": "K", "K": "/"
    }
    
    reversed_text = _reverse_string(text)
    
    deobf_text = []
    for char in reversed_text:
        deobf_text.append(replacements.get(char, char))
    
    return "".join(deobf_text)

def _deobfuscate_ofusLTM(text):
    """Desofusca una cadena usando el algoritmo 'ofusLTM'."""
    replacements = {
        ".": "v", "v": ".",
        "1": "@", "@": "1",
        "2": "?", "?": "2",
        "4": "p", "p": "4",
        "-": "L", "L": "-"
    }
    
    reversed_text = _reverse_string(text)
    
    deobf_text = []
    for char in reversed_text:
        deobf_text.append(replacements.get(char, char))
    
    return "".join(deobf_text)

def run_deobfuscation_cli(url):
    """
    Descarga y desofusca un script Bash de una URL,
    imprimiendo el resultado en la consola.
    """
    print(f"Descargando script de: {url}")

    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status() 
        obfuscated_code = response.text
        
        print("Script descargado. Procesando desofuscación...")

        deobfuscated_code_result = obfuscated_code
        output_messages_list = []

        # --- Manejo de la ofuscación de la primera línea (bootstrap Bash) ---
        lines = obfuscated_code.split('\n')
        if lines:
            first_line_content = lines[0].strip()
            # Regex más flexible para detectar el patrón de ofuscación de la primera línea
            if first_line_content.startswith('(_______________=`_') or re.match(r'^\(_______________=.*`_.*`', first_line_content):
                deobfuscated_code_result = "#!/bin/bash\n# La primera línea ofuscada (bootstrap Bash) ha sido eliminada. \n# Para desofuscación profunda, se requiere un entorno Linux y la técnica de core dump.\n" + "\n".join(lines[1:])
                output_messages_list.append("\n--- ADVERTENCIA: La ofuscación de la primera línea es compleja (bootstrap Bash) y no puede ser desofuscada textualmente en Windows. Ha sido reemplazada por una cabecera limpia. ---\n\n")
        
        # --- Buscar y reemplazar patrones de ofuscación internos (ofus y ofusLTM) ---
        replacements_map = {} 

        # Detectar si las funciones ofus/ofusLTM están presentes en el código original
        ofus_func_present = re.search(r'ofus\s*\(\)\s*\{.*?return\$txtofus', obfuscated_code, re.DOTALL)
        ofusLTM_func_present = re.search(r'ofusLTM\s*\(\)\s*\{.*?return\$txtofus', obfuscated_code, re.DOTALL)

        if ofus_func_present:
            output_messages_list.append("--- Función 'ofus' detectada. Se buscarán y revertirán sus patrones. ---\n")
            for match_obj in re.finditer(r'[x\.s5@1\?204K/]+', obfuscated_code):
                s = match_obj.group(0)
                if (10 < len(s) < 50) and re.search(r'[xK]', s):
                    try:
                        deobf_s = _deobfuscate_ofus(s)
                        if (re.match(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:.*', deobf_s) or "https://" in deobf_s or "http://" in deobf_s) and s not in obfuscated_code[ofus_func_present.start():ofus_func_present.end()]:
                            replacements_map[s] = deobf_s + " # DEOBF_OFUS"
                            output_messages_list.append(f"  Posible reversión: '{s}' -> '{deobf_s}'\n")
                    except Exception as e:
                        output_messages_list.append(f"  Error al desofuscar '{s}' con ofus: {e}\n")

        if ofusLTM_func_present:
            output_messages_list.append("--- Función 'ofusLTM' detectada. Se buscarán y revertirán sus patrones. ---\n")
            for match_obj in re.finditer(r'[v\.@1\?2p4L\-]+', obfuscated_code):
                s = match_obj.group(0)
                if (10 < len(s) < 50) and re.search(r'[vL]', s):
                    try:
                        deobf_s = _deobfuscate_ofusLTM(s)
                        if (re.match(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:.*', deobf_s) or "https://" in deobf_s or "http://" in deobf_s) and s not in obfuscated_code[ofusLTM_func_present.start():ofusLTM_func_present.end()]:
                            replacements_map[s] = deobf_s + " # DEOBF_OFLTM"
                            output_messages_list.append(f"  Posible reversión: '{s}' -> '{deobf_s}'\n")
                    except Exception as e:
                        output_messages_list.append(f"  Error al desofuscar '{s}' con ofusLTM: {e}\n")
        
        if replacements_map:
            sorted_obf_strings = sorted(replacements_map.keys(), key=len, reverse=True)
            pattern = re.compile("|".join(map(re.escape, sorted_obf_strings)))
            
            def replace_match(match):
                return replacements_map[match.group(0)]
            
            deobfuscated_code_result = pattern.sub(replace_match, deobfuscated_code_result)

        output_messages_list.append("\n--- Código Resultante (Desofuscación de Patrones Aplicada) ---\n")
        output_messages_list.append(deobfuscated_code_result)

        final_output_content = "".join(output_messages_list)
        print(final_output_content) # Imprimir en la consola

    except requests.exceptions.RequestException as e:
        print(f"Error de Conexión: No se pudo conectar a la URL o descargar el contenido:\n{e}", file=sys.stderr)
    except Exception as e:
        print(f"Ocurrió un error inesperado:\n{e}", file=sys.stderr)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Uso: python desofuscador_cli.py <URL_del_script_ofuscado>", file=sys.stderr)
        print("Ejemplo: python desofuscador_cli.py https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/setup", file=sys.stderr)
        sys.exit(1)
    
    script_url = sys.argv[1]
    run_deobfuscation_cli(script_url)
