#!/bin/bash

# Script interativo para criar PR's automaticamente
# Uso: npm run create-pr

set -e

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

clear
echo -e "${BLUE}🚀 Criação Interativa de Pull Request${NC}"
echo -e "${BLUE}=====================================${NC}"
echo

# Verificar se estamos em um repositório git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Erro: Não está em um repositório Git${NC}"
    exit 1
fi

# Verificar se há mudanças para comitar
if git diff --quiet && git diff --cached --quiet; then
    echo -e "${YELLOW}⚠️  Aviso: Não há mudanças para comitar${NC}"
    read -p "$(echo -e ${CYAN})Continuar mesmo assim? (y/N): $(echo -e ${NC})" -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Cancelado pelo usuário${NC}"
        exit 1
    fi
    echo
fi

# Mostrar branch atual
CURRENT_BRANCH=$(git branch --show-current)
echo -e "${BLUE}📍 Branch atual: ${YELLOW}${CURRENT_BRANCH}${NC}"
echo

# Input 1: Tipo de PR (Conventional Commits)
echo -e "${CYAN}🏷️  Tipo do PR:${NC}"
echo -e "${YELLOW}   1) feat     - Nova funcionalidade${NC}"
echo -e "${YELLOW}   2) fix      - Correção de bug${NC}"
echo -e "${YELLOW}   3) refactor - Refatoração de código${NC}"
echo -e "${YELLOW}   4) style    - Mudanças de estilo/formatação${NC}"
echo -e "${YELLOW}   5) test     - Adicionar ou corrigir testes${NC}"
echo -e "${YELLOW}   6) docs     - Mudanças na documentação${NC}"
echo -e "${YELLOW}   7) chore    - Tarefas de manutenção${NC}"
read -p "$(echo -e ${GREEN})Escolha (1-7): $(echo -e ${NC})" PR_TYPE_NUM

while [[ ! "$PR_TYPE_NUM" =~ ^[1-7]$ ]]; do
    echo -e "${RED}❌ Escolha válida: 1 a 7${NC}"
    read -p "$(echo -e ${GREEN})Escolha (1-7): $(echo -e ${NC})" PR_TYPE_NUM
done

# Mapear número para tipo
case $PR_TYPE_NUM in
    1) PR_TYPE="feat" ;;
    2) PR_TYPE="fix" ;;
    3) PR_TYPE="refactor" ;;
    4) PR_TYPE="style" ;;
    5) PR_TYPE="test" ;;
    6) PR_TYPE="docs" ;;
    7) PR_TYPE="chore" ;;
esac

echo

# Input 2: Escopo (Frontend/Backend/Both)
echo -e "${CYAN}🎯 Escopo da mudança:${NC}"
echo -e "${YELLOW}   1) frontend - Mudanças apenas no frontend${NC}"
echo -e "${YELLOW}   2) backend  - Mudanças apenas no backend${NC}"
echo -e "${YELLOW}   3) fullstack - Mudanças no frontend e backend${NC}"
echo -e "${YELLOW}   4) config   - Configurações e setup${NC}"
echo -e "${YELLOW}   5) scripts  - Scripts e automações${NC}"
read -p "$(echo -e ${GREEN})Escolha (1-5): $(echo -e ${NC})" SCOPE_NUM

while [[ ! "$SCOPE_NUM" =~ ^[1-5]$ ]]; do
    echo -e "${RED}❌ Escolha válida: 1 a 5${NC}"
    read -p "$(echo -e ${GREEN})Escolha (1-5): $(echo -e ${NC})" SCOPE_NUM
done

# Mapear número para escopo
case $SCOPE_NUM in
    1) PR_SCOPE="frontend" ;;
    2) PR_SCOPE="backend" ;;
    3) PR_SCOPE="fullstack" ;;
    4) PR_SCOPE="config" ;;
    5) PR_SCOPE="scripts" ;;
esac

echo

# Input 3: Título/Descrição da mudança
echo -e "${CYAN}📝 Título da mudança:${NC}"
echo -e "${YELLOW}   Descreva brevemente o que foi feito${NC}"
echo -e "${YELLOW}   Exemplo: \"update swap flow to support safe\"${NC}"
read -p "$(echo -e ${GREEN})➤ $(echo -e ${NC})" PR_TITLE

while [[ -z "$PR_TITLE" ]]; do
    echo -e "${RED}❌ Título é obrigatório!${NC}"
    read -p "$(echo -e ${GREEN})➤ $(echo -e ${NC})" PR_TITLE
done

# Construir o título final
FULL_PR_TITLE="${PR_TYPE}(${PR_SCOPE}): ${PR_TITLE}"

# Gerar feature name baseado no título
FEATURE_NAME=$(echo "$PR_TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')

echo

# Input 4: Screenshots baseado no escopo
SKIP_SCREENSHOTS=true
if [[ "$PR_SCOPE" == "frontend" || "$PR_SCOPE" == "fullstack" ]]; then
    echo -e "${CYAN}📸 Capturar screenshots automaticamente?${NC}"
    echo -e "${YELLOW}   Esta mudança afeta a interface do usuário${NC}"
    read -p "$(echo -e ${GREEN})Sim (Y/n): $(echo -e ${NC})" -r
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        SKIP_SCREENSHOTS=false
    fi
    echo
fi

echo

# Confirmação final
echo -e "${BLUE}📋 Resumo do PR:${NC}"
echo -e "${YELLOW}   Título: ${FULL_PR_TITLE}${NC}"
echo -e "${YELLOW}   Tipo: ${PR_TYPE}${NC}"
echo -e "${YELLOW}   Escopo: ${PR_SCOPE}${NC}"
echo -e "${YELLOW}   Feature name: ${FEATURE_NAME}${NC}"
echo -e "${YELLOW}   Screenshots: $([ "$SKIP_SCREENSHOTS" = true ] && echo "❌ Não" || echo "✅ Sim")${NC}"
echo -e "${YELLOW}   Branch atual: ${CURRENT_BRANCH}${NC}"
echo

read -p "$(echo -e ${GREEN})Confirmar criação do PR? (Y/n): $(echo -e ${NC})" -r
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${RED}❌ Cancelado pelo usuário${NC}"
    exit 1
fi

echo
echo -e "${BLUE}🚀 Iniciando criação do PR...${NC}"

# Gerar timestamp e branch name
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BRANCH_NAME="feature/${TIMESTAMP}_${FEATURE_NAME}"

# Criar e mudar para nova branch
echo -e "${BLUE}🌿 Criando branch: ${BRANCH_NAME}${NC}"
git checkout -b "$BRANCH_NAME"

# Fazer commit das mudanças (se houver)
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo -e "${BLUE}📦 Commitando mudanças...${NC}"
    git add .
    git commit -m "$FULL_PR_TITLE

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"
fi

# Push para remote
echo -e "${BLUE}⬆️  Fazendo push da branch...${NC}"
git push -u origin "$BRANCH_NAME"

# Verificar se gh está instalado
if ! command -v gh &> /dev/null; then
    echo -e "${YELLOW}⚠️  GitHub CLI não instalado.${NC}"
    echo -e "${GREEN}✅ Branch criada com sucesso: ${BRANCH_NAME}${NC}"
    echo -e "${BLUE}🔗 Criar PR manualmente em: https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[\\/:]\\([^.]*\\).*/\\1/')/compare/${BRANCH_NAME}${NC}"
    exit 0
fi

# Verificar se está autenticado no GitHub
if ! gh auth status &>/dev/null; then
    echo -e "${YELLOW}⚠️  Não está autenticado no GitHub${NC}"
    echo "Execute: gh auth login"
    exit 1
fi

# Função para capturar screenshots
capture_screenshots() {
    echo -e "${BLUE}📸 Capturando screenshots das mudanças...${NC}"

    # Verificar se o frontend está rodando
    local screenshots_captured=""

    if curl -s http://localhost:3001 > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Frontend detectado em http://localhost:3001${NC}"

        # Criar diretório para screenshots se não existir
        mkdir -p .github/screenshots

        # Usar script de captura se existir
        if [ -f "./scripts/capture-screenshots.sh" ]; then
            echo -e "${BLUE}📱 Executando captura automática...${NC}"

            if ./scripts/capture-screenshots.sh 2>/dev/null; then
                screenshots_captured="✅ Screenshots capturados automaticamente"
            else
                echo -e "${YELLOW}⚠️ Captura automática falhou.${NC}"
                screenshots_captured="⚠️ Screenshots devem ser adicionados manualmente"
            fi
        else
            echo -e "${YELLOW}⚠️ Script de captura não encontrado${NC}"
            screenshots_captured="⚠️ Screenshots devem ser adicionados manualmente"
        fi
    else
        echo -e "${YELLOW}⚠️ Frontend não está rodando em localhost:3001${NC}"
        screenshots_captured="⚠️ Frontend não está rodando - screenshots devem ser adicionados manualmente"
    fi

    echo "$screenshots_captured"
}

# Capturar screenshots (se não foi pulado)
if [ "$SKIP_SCREENSHOTS" = true ]; then
    echo -e "${YELLOW}⏭️  Screenshots pulados conforme solicitado${NC}"
    SCREENSHOTS_STATUS="⏭️ Screenshots pulados - mudanças não relacionadas à UI"
else
    SCREENSHOTS_STATUS=$(capture_screenshots)
fi

# Criar PR automaticamente
echo -e "${BLUE}🎯 Criando Pull Request...${NC}"

PR_BODY="## 📋 Summary
$PR_TITLE

## 🖼️ Screenshots
$SCREENSHOTS_STATUS

<!-- Adicione screenshots aqui se necessário:
![Before](./.github/screenshots/before.png)
![After](./.github/screenshots/after.png)
-->

### 📱 UI Changes (if applicable)
- [ ] Authentication screens
- [ ] Dashboard interface
- [ ] Mobile responsiveness
- [ ] Brazilian localization (português)

## 🧪 Test Plan
- [ ] Manual testing completed
- [ ] UI components tested on different screen sizes
- [ ] API endpoints tested (if applicable)
- [ ] Brazilian localization verified (if applicable)
- [ ] RSpec tests passing
- [ ] No lint errors
- [ ] Tailwind CSS compilation working

## 🔍 Code Quality
- [ ] TypeScript types properly defined
- [ ] Tailwind classes optimized
- [ ] Components follow shadcn/ui patterns
- [ ] Brazilian formatting (currency, dates) working
- [ ] Accessibility standards met

## 🤖 AI Review
@coderabbitai review this PR

## 📝 Additional Notes
- Generated with interactive npm run create-pr script
- $([ "$SKIP_SCREENSHOTS" = true ] && echo "No screenshots needed for this change" || echo "Screenshots captured automatically")
- Ready for review and merge

### 🚀 Frontend Stack
- Next.js 15 + React 19 + TypeScript
- Tailwind CSS 4 with custom color system
- shadcn/ui components
- Zustand state management

---
🤖 Generated with [Claude Code](https://claude.ai/code)"

gh pr create \
    --title "$FULL_PR_TITLE" \
    --body "$PR_BODY" \
    --assignee "@me" \
    --label "enhancement,needs-review"

# Obter URL do PR
PR_URL=$(gh pr view --json url --jq '.url')

echo
echo -e "${GREEN}🎉 PR criado com sucesso!${NC}"
echo -e "${GREEN}✅ Feature: ${FEATURE_NAME}${NC}"
echo -e "${GREEN}✅ Branch: ${BRANCH_NAME}${NC}"
echo -e "${GREEN}🔗 URL: ${PR_URL}${NC}"
echo -e "${GREEN}🤖 AI Review solicitado automaticamente${NC}"

# Abrir PR no browser (opcional)
read -p "$(echo -e ${CYAN})Abrir PR no navegador? (Y/n): $(echo -e ${NC})" -r
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    gh pr view --web
fi

echo
echo -e "${BLUE}📝 Para voltar à branch anterior: ${YELLOW}git checkout ${CURRENT_BRANCH}${NC}"