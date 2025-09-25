#!/bin/bash

# Script auxiliar para capturar screenshots para PRs
# Uso: capture-pr-screenshots [output-dir]

set -e

OUTPUT_DIR="${1:-.github/screenshots}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}📸 Capturando screenshots para PR...${NC}"

# Criar diretório se não existir
mkdir -p "$OUTPUT_DIR"

# Verificar se o frontend está rodando
if ! curl -s http://localhost:3001 > /dev/null 2>&1; then
    echo -e "${RED}❌ Frontend não está rodando em localhost:3001${NC}"
    echo -e "${YELLOW}💡 Inicie o frontend com: npm run dev${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Frontend detectado em localhost:3001${NC}"

# URLs para capturar
declare -a urls=(
    "/"
    "/auth"
    "/dashboard"
)

# Nomes dos arquivos
declare -a names=(
    "home"
    "auth"
    "dashboard"
)

echo -e "${BLUE}📱 Iniciando captura de screenshots...${NC}"

# Loop através das URLs
for i in "${!urls[@]}"; do
    url="http://localhost:3001${urls[$i]}"
    name="${names[$i]}"
    output_file="${OUTPUT_DIR}/${name}_${TIMESTAMP}.png"

    echo -e "${BLUE}📸 Capturando ${url}...${NC}"

    # Usar diferentes ferramentas baseado na disponibilidade
    if command -v google-chrome &> /dev/null || command -v google-chrome-stable &> /dev/null; then
        # Usar Chrome/Chromium para screenshot
        CHROME_CMD="google-chrome"
        if ! command -v google-chrome &> /dev/null; then
            CHROME_CMD="google-chrome-stable"
        fi

        $CHROME_CMD --headless --disable-gpu --window-size=1280,720 --screenshot="$output_file" "$url" 2>/dev/null || {
            echo -e "${YELLOW}⚠️ Falha ao capturar ${name}${NC}"
            continue
        }

    elif command -v firefox &> /dev/null; then
        # Usar Firefox para screenshot
        firefox --headless --screenshot="$output_file" --window-size=1280,720 "$url" 2>/dev/null || {
            echo -e "${YELLOW}⚠️ Falha ao capturar ${name}${NC}"
            continue
        }

    elif command -v wkhtmltopdf &> /dev/null; then
        # Usar wkhtmltoimage como fallback
        temp_html="/tmp/screenshot_${name}.html"
        curl -s "$url" > "$temp_html"
        wkhtmltoimage --width 1280 --height 720 "$temp_html" "$output_file" 2>/dev/null || {
            echo -e "${YELLOW}⚠️ Falha ao capturar ${name}${NC}"
            rm -f "$temp_html"
            continue
        }
        rm -f "$temp_html"

    else
        echo -e "${RED}❌ Nenhuma ferramenta de screenshot disponível${NC}"
        echo -e "${YELLOW}💡 Instale: google-chrome, firefox, ou wkhtmltopdf${NC}"
        exit 1
    fi

    if [ -f "$output_file" ]; then
        file_size=$(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file" 2>/dev/null || echo "0")
        if [ "$file_size" -gt 1000 ]; then
            echo -e "${GREEN}✅ Screenshot salvo: ${output_file}${NC}"
        else
            echo -e "${YELLOW}⚠️ Screenshot pode estar vazio: ${output_file}${NC}"
        fi
    else
        echo -e "${RED}❌ Falha ao salvar screenshot: ${output_file}${NC}"
    fi
done

echo
echo -e "${GREEN}🎉 Captura concluída!${NC}"
echo -e "${BLUE}📁 Screenshots salvos em: ${OUTPUT_DIR}${NC}"

# Listar arquivos criados
if ls "$OUTPUT_DIR"/*_${TIMESTAMP}.png 1> /dev/null 2>&1; then
    echo -e "${BLUE}📋 Arquivos criados:${NC}"
    ls -la "$OUTPUT_DIR"/*_${TIMESTAMP}.png

    echo
    echo -e "${BLUE}📝 Para usar no PR, adicione ao markdown:${NC}"
    for i in "${!names[@]}"; do
        name="${names[$i]}"
        file_path="${OUTPUT_DIR}/${name}_${TIMESTAMP}.png"
        if [ -f "$file_path" ]; then
            echo "![${name^}](./${OUTPUT_DIR}/${name}_${TIMESTAMP}.png)"
        fi
    done
else
    echo -e "${YELLOW}⚠️ Nenhum screenshot foi capturado com sucesso${NC}"
fi

echo
echo -e "${BLUE}💡 Dica: Commit os screenshots junto com suas mudanças!${NC}"