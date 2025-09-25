# 🤖 Sistema Automatizado de PR com AI Review

Sistema completo para criação automatizada de Pull Requests com revisão por IA gratuita usando CodeRabbit.

## 📋 Componentes Instalados

### 1. Script Automatizado ✅
- **Localização:** `/home/muraro/.local/bin/create-pr`
- **Função:** Criação automática de branches, commits e PRs
- **Status:** Instalado e executável

### 2. GitHub Actions Workflows ✅
- **PR Quality Check:** `.github/workflows/pr-quality-check.yml`
- **CodeRabbit AI Review:** `.github/workflows/coderabbit.yml`
- **Status:** Configurados e prontos

### 3. Configurações ✅
- **RuboCop:** `.rubocop.yml` - Análise de código
- **CodeRabbit:** `.coderabbit.yaml` - Configuração da IA
- **Gemfile:** Ferramentas de qualidade adicionadas

## 🚀 Como Usar

### Instalação Inicial (Uma vez)

1. **GitHub CLI** (se não instalado):
```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh
gh auth login
```

2. **Adicionar script ao PATH** (adicione ao ~/.bashrc ou ~/.zshrc):
```bash
export PATH="$HOME/.local/bin:$PATH"
```

3. **Recarregar shell:**
```bash
source ~/.bashrc  # ou source ~/.zshrc
```

### Uso Diário

```bash
# Navegar para o projeto
cd /home/muraro/Projects/roommate-manager/backend

# Fazer suas modificações...
# Editar arquivos, adicionar features, etc.

# Criar PR automaticamente
create-pr "user-authentication" "Add JWT authentication system"
```

**O que acontece automaticamente:**
1. 🌿 Cria branch: `feature/YYYYMMDD_HHMM_user-authentication`
2. 📦 Faz commit das mudanças
3. ⬆️  Push da branch
4. 🎯 Cria PR no GitHub
5. 🤖 Solicita review do CodeRabbit AI
6. 📊 Executa testes automatizados
7. 🔍 Análise de qualidade (RuboCop)
8. 🛡️  Análise de segurança (Brakeman)

## 🤖 Recursos da IA Review

### CodeRabbit AI analisa:
- ✅ Convenções Rails
- ✅ Localização brasileira (R$, DD/MM/YYYY)
- ✅ Segurança (SQL injection, XSS)
- ✅ Performance (N+1 queries)
- ✅ Testes e cobertura
- ✅ Best practices

### GitHub Actions executa:
- 🧪 **RSpec Tests** - Suite completa de testes
- 🔍 **RuboCop** - Análise de estilo
- 🛡️ **Brakeman** - Análise de segurança
- 📦 **Bundle Audit** - Vulnerabilidades em gems
- 📊 **Coverage Report** - Cobertura de testes

## 💰 Recursos Gratuitos

### Totalmente Gratuito:
- ✅ GitHub Actions (2000 min/mês)
- ✅ CodeRabbit AI (Open Source projects)
- ✅ GitHub CLI
- ✅ Todos os workflows configurados

### Limites Generosos:
- 2000 minutos de CI por mês
- Reviews ilimitadas da IA
- PRs ilimitados
- Repositórios privados suportados

## 📝 Exemplos de Uso

### Feature Nova
```bash
create-pr "expense-categories" "Add smart expense categorization"
```

### Bug Fix
```bash
create-pr "fix-currency-format" "Fix Brazilian currency display in receipts"
```

### Refactoring
```bash
create-pr "refactor-serializers" "Extract currency formatting to shared concern"
```

### API Enhancement
```bash
create-pr "api-filtering" "Add advanced filtering to expenses endpoint"
```

## 🔧 Troubleshooting

### Script não encontrado
```bash
# Verificar se está no PATH
which create-pr

# Se não estiver, adicionar ao PATH
export PATH="$HOME/.local/bin:$PATH"
```

### GitHub CLI não autenticado
```bash
gh auth status
gh auth login
```

### Workflows não executando
- Verificar se os arquivos estão em `.github/workflows/`
- Confirmar se o repositório tem Actions habilitadas
- Verificar permissões do repositório

## 🎯 Próximos Passos

1. **Testar o sistema** com uma feature pequena
2. **Ajustar configurações** conforme necessário
3. **Documentar** casos específicos do projeto
4. **Monitorar** performance dos workflows

## 🏆 Benefícios

### Para Desenvolvimento:
- ⚡ Criação de PR em 30 segundos
- 🤖 Review automática por IA
- 📊 Análise de qualidade instantânea
- 🔒 Verificação de segurança

### Para Qualidade:
- 🧪 Testes automáticos
- 📝 Documentação automática
- 🎯 Padrões consistentes
- 🚀 Deploy confiável

---
🤖 **Sistema criado com Claude Code** - Pronto para usar!