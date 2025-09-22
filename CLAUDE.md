# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

RoomMate Manager is a collaborative expense management web application specifically designed for roommate pairs. The project is currently in MVP state with complete HTML prototypes and is structured for future React frontend and Ruby on Rails backend development.

**Current Status:**
- ✅ Complete HTML prototypes (7 screens) in `prototype/html-screens/`
- 📅 React frontend planned (Phase 2)
- 📅 Ruby on Rails API backend planned (Phase 1)

**Target Users:** Brazilian roommate pairs managing shared expenses in Portuguese (Brasil) with Real (R$) currency.

## Development Commands

### Prototype Development
```bash
# Run local development server for HTML prototypes
cd prototype
python -m http.server 8000
# or
npx serve .
# or
php -S localhost:8000

# Access prototype at:
# http://localhost:8000/html-screens/login_register_screens.html
```

### Future Development Commands

**Frontend (React - Phase 2):**
```bash
cd frontend
npm install           # Install dependencies
npm run dev          # Start development server
npm run build        # Build for production
npm run test         # Run tests
npm run lint         # Lint code
npm run typecheck    # TypeScript checking

# shadcn/ui component management
npx shadcn-ui@latest init          # Initialize shadcn/ui
npx shadcn-ui@latest add button    # Add specific components
npx shadcn-ui@latest add card      # Add card component
npx shadcn-ui@latest add form      # Add form components
npx shadcn-ui@latest add dialog    # Add dialog component
```

**Backend (Ruby on Rails - Phase 1):**
```bash
cd backend
bundle install            # Install dependencies
rails server              # Start development server (port 3000)
rails db:migrate          # Run database migrations
rails test                # Run tests
rspec                     # Run RSpec tests (if using RSpec)
rails db:reset            # Reset database with seed data
rails db:seed             # Seed database with sample data
rails console             # Interactive Rails console for debugging
rails generate model User # Generate models, controllers, etc.
```

## Architecture Overview

### Repository Structure
- **`prototype/`** - Complete HTML/CSS/JS prototypes (current implementation)
- **`frontend/`** - React application (planned - Phase 2)
- **`backend/`** - Ruby on Rails API (planned - Phase 1)
- **`docs/`** - Technical and user documentation
- **`.github/`** - GitHub workflows, issue templates, PR templates

### Technology Stack

**Current (Prototype):**
- HTML5 + Tailwind CSS + Vanilla JavaScript
- Font Awesome 6.4.0 for icons
- Mobile-first responsive design

**Planned Production:**
- **Frontend:** React + TypeScript + Tailwind CSS + Vite + shadcn/ui
- **Backend:** Ruby on Rails 7+ + PostgreSQL/MySQL
- **Authentication:** Google OAuth + Devise + JWT
- **Real-time:** Action Cable (WebSockets) for shopping lists
- **Background Jobs:** Sidekiq + Redis for async processing
- **API:** RESTful JSON API with Active Model Serializers
- **Deployment:** Vercel (frontend) + Railway/Render (backend) - Free tier

### Core Features
1. **Expense Management** - Add, split, and track shared expenses with smart categorization
2. **Shopping Lists** - Real-time collaborative shopping with auto-categorization
3. **Receipt Gallery** - Upload, organize, and link receipts to expenses
4. **Balance Tracking** - Real-time balance calculations and settlement management
5. **Smart Features** - Auto-categorization, quick actions, mobile-optimized UX

## Design System

### Key Design Principles
- **Mobile-First:** All designs start with mobile, enhanced for tablet/desktop
- **Brazilian Localization:** Portuguese (Brasil) language, R$ currency, DD/MM/YYYY dates
- **Density-Optimized:** Information-dense layouts for efficient expense tracking
- **Component-Based:** Reusable patterns following Tailwind utility-first approach

### Color System
```css
/* Primary Colors */
--blue-600: #2563eb;    /* Primary actions, links */
--blue-50: #eff6ff;     /* Light backgrounds */

/* Status Colors */
--orange-500: #f97316;  /* Pending expenses */
--green-500: #10b981;   /* Completed/settled */
--red-500: #ef4444;     /* Debt/danger actions */

/* Neutral Scale */
--gray-50: #f9fafb;     /* Page backgrounds */
--gray-900: #111827;    /* Primary text */
```

### Component Patterns
- **Cards:** White background, rounded-lg, subtle shadow, gray-200 border
- **Buttons:** Primary (blue-600), Secondary (gray border), Danger (red-500)
- **Status Badges:** Color-coded with emoji indicators for categories
- **Forms:** Real-time validation, Brazilian date formatting (DD/MM/YYYY)

### shadcn/ui Component Strategy

**Core Philosophy:**
- Use shadcn/ui as the foundation for all UI components
- Customize and extend shadcn components for app-specific needs
- Maintain design consistency while leveraging battle-tested patterns
- Copy components into codebase for full control and customization

**Essential shadcn/ui Components for This Project:**
```bash
# Core UI primitives
npx shadcn-ui@latest add button
npx shadcn-ui@latest add card
npx shadcn-ui@latest add input
npx shadcn-ui@latest add label
npx shadcn-ui@latest add select
npx shadcn-ui@latest add textarea

# Complex components
npx shadcn-ui@latest add form
npx shadcn-ui@latest add dialog
npx shadcn-ui@latest add sheet       # For mobile navigation
npx shadcn-ui@latest add dropdown-menu
npx shadcn-ui@latest add avatar
npx shadcn-ui@latest add badge

# Data display
npx shadcn-ui@latest add table
npx shadcn-ui@latest add calendar
npx shadcn-ui@latest add popover
npx shadcn-ui@latest add toast

# Advanced components
npx shadcn-ui@latest add command     # For search/filtering
npx shadcn-ui@latest add tabs
npx shadcn-ui@latest add switch
npx shadcn-ui@latest add progress
```

**Custom Component Development Strategy:**

1. **Base Components (shadcn/ui):** Use as-is for standard UI elements
   - Button, Input, Card, Dialog, etc.
   - Maintain original shadcn styling and behavior

2. **Extended Components:** Customize shadcn components for app needs
   - ExpenseCard (extends Card)
   - QuickAddForm (extends Form)
   - CategoryBadge (extends Badge)
   - BalanceDisplay (extends Card + custom logic)

3. **Composite Components:** Combine multiple shadcn components
   - ExpenseListItem (Card + Button + Badge + Avatar)
   - AddExpenseDialog (Dialog + Form + Select + Input)
   - ShoppingListItem (Card + Checkbox + Button)

4. **App-Specific Components:** Built from scratch when needed
   - ReceiptGallery (custom grid with file handling)
   - BalanceChart (custom visualization)
   - CategoryFilter (custom multi-select)

**Component File Structure:**
```
frontend/src/components/
├── ui/                          # shadcn/ui components (auto-generated)
│   ├── button.tsx
│   ├── card.tsx
│   ├── form.tsx
│   └── ...
├── common/                      # Extended/customized components
│   ├── expense-card.tsx
│   ├── category-badge.tsx
│   ├── balance-display.tsx
│   └── quick-add-form.tsx
├── features/                    # Feature-specific components
│   ├── expenses/
│   │   ├── expense-list.tsx
│   │   ├── add-expense-dialog.tsx
│   │   └── expense-details.tsx
│   ├── shopping/
│   │   ├── shopping-list.tsx
│   │   └── shopping-item.tsx
│   └── receipts/
│       ├── receipt-gallery.tsx
│       └── receipt-upload.tsx
└── layout/                      # Layout components
    ├── header.tsx
    ├── navigation.tsx
    └── mobile-menu.tsx
```

**Customization Examples:**

```typescript
// Extended Card for Expenses
// components/common/expense-card.tsx
import { Card, CardContent, CardHeader } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'

interface ExpenseCardProps {
  expense: Expense
  onSettle?: () => void
}

export function ExpenseCard({ expense, onSettle }: ExpenseCardProps) {
  return (
    <Card className="border-l-4 border-l-blue-500">
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <Badge variant={expense.category}>
            {getCategoryEmoji(expense.category)} {expense.category}
          </Badge>
          <span className="text-sm text-muted-foreground">
            {formatBrazilianDate(expense.created_at)}
          </span>
        </div>
      </CardHeader>
      <CardContent>
        <div className="flex items-center justify-between">
          <div>
            <p className="font-medium">{expense.description}</p>
            <p className="text-sm text-muted-foreground">
              Paid by {expense.paid_by.name}
            </p>
          </div>
          <div className="text-right">
            <p className="font-bold text-lg">
              {formatBrazilianCurrency(expense.amount)}
            </p>
            <p className="text-sm text-muted-foreground">
              Your share: {formatBrazilianCurrency(expense.split_amount)}
            </p>
          </div>
        </div>
        {expense.status === 'pending' && onSettle && (
          <Button
            variant="outline"
            size="sm"
            className="mt-4 w-full"
            onClick={onSettle}
          >
            Mark as Settled
          </Button>
        )}
      </CardContent>
    </Card>
  )
}
```

**Brazilian Localization with shadcn/ui:**
- Currency formatting: R$ 1.234,56 (Brazilian format)
- Date formatting: DD/MM/YYYY
- Number formatting: 1.234,56 (comma for decimal)
- Form validation messages in Portuguese
- Custom calendar component with Brazilian holidays

**Migration Strategy from HTML Prototypes:**
1. **Identify Patterns:** Map current HTML components to shadcn equivalents
2. **Start with Primitives:** Replace basic elements (buttons, inputs, cards)
3. **Build Composites:** Combine primitives into complex components
4. **Add Interactions:** Enhance with React state and event handling
5. **Customize Styling:** Adjust Tailwind classes for exact design match

## Key Development Patterns

### File Naming Conventions
- **HTML Files:** `screen_name_screen.html` (snake_case with descriptive names)
- **CSS Classes:** Follow Tailwind utilities, minimal custom CSS
- **JavaScript Functions:** camelCase with descriptive action names (`handleQuickAdd`, `toggleItemStatus`)

### Auto-Categorization Logic
The shopping list implements smart categorization based on keywords:
```javascript
// Key categories with emoji indicators
🥛 Dairy (milk, cheese, yogurt)
🥬 Produce (fruits, vegetables)
🍖 Meat (chicken, beef, fish)
🧹 Household (soap, shampoo, cleaning)
📦 Other (default fallback)
```

### Form Validation Patterns
- **Brazilian Date Format:** Real-time DD/MM/YYYY formatting
- **Required Fields:** Visual indication with red borders
- **Real-time Feedback:** Immediate validation on input changes
- **Currency:** Brazilian Real (R$) with proper formatting (1.234,56)

### Responsive Breakpoints
```css
/* Mobile First (0-639px) - Default */
/* Tablet: 640px+ */
/* Desktop: 1024px+ */
/* Wide: 1280px+ */
```

## Navigation Architecture

### Screen Flow
```
Authentication → Dashboard (main hub)
├── Add Expense → Dashboard
├── Expenses List → Expense Details → Dashboard
├── Shopping List → Dashboard
├── Receipt Gallery → Receipt Details → Dashboard
└── Settings → Profile/Preferences → Dashboard
```

### Critical User Paths
1. **Quick Expense Entry:** Dashboard → Add Expense → Split calculation → Save → Dashboard
2. **Shopping Collaboration:** Dashboard → Shopping List → Quick add items → Real-time sync
3. **Receipt Management:** Dashboard → Receipt Gallery → Upload → Link to expense
4. **Balance Settlement:** Dashboard → Expenses List → Filter → Settle → Update balance

## Development Guidelines

### HTML/CSS Standards
- Use semantic HTML5 elements (`<main>`, `<section>`, `<article>`)
- Follow Tailwind utility-first approach, minimal custom CSS
- Maintain WCAG 2.1 AA accessibility standards
- Ensure keyboard navigation and screen reader compatibility

### JavaScript Patterns
- Use inline event handlers for prototype simplicity (`onclick="function()"`)
- Keep functions focused and descriptive
- Implement real-time form validation
- Use consistent DOM querying patterns

### Future React Migration
- Each HTML screen maps to a React page component
- Current JavaScript functions become custom hooks
- Tailwind classes transfer directly to React components
- **Component Library:** shadcn/ui components as foundation, custom components when needed
- **Component Strategy:** Use shadcn/ui primitives, extend/customize for app-specific needs
- State management with Zustand for client state, React Query for server state

## Testing Approach

### Manual Testing Checklist
- **Responsive:** Test on mobile (320px+), tablet (768px+), desktop (1024px+)
- **Cross-browser:** Chrome, Firefox, Safari, Edge
- **Accessibility:** Keyboard navigation, screen readers, color contrast
- **Functionality:** All forms, navigation, interactive elements

### Future Automated Testing
- **Frontend:** Vitest + React Testing Library + Playwright E2E
- **Backend:** RSpec + FactoryBot + Request specs for API testing
- **Integration:** Full user flow testing across frontend/backend
- **Rails Testing:** Model tests, Controller tests, System tests with Capybara

## Deployment Strategy

### Current (Prototype)
- GitHub Pages deployment for live demo
- Static file serving from `prototype/html-screens/`

### Production Deployment (Free Tier Strategy)
- **Frontend:** Vercel (Free tier - perfect for React apps)
- **Backend:** Railway (Free tier - $5/month after trial) or Render (Free tier)
- **Database:** PostgreSQL (Railway/Render free tier included)
- **File Storage:** Cloudinary (Free tier - 25GB bandwidth) for receipts/images
- **Background Jobs:** Built-in Rails jobs (vs paid Redis)
- **Real-time:** Action Cable with Redis (Railway free tier)
- **Monitoring:** Railway/Render built-in monitoring
- **Domain:** Custom domain via Vercel (free with domain purchase)

**Total Cost: $0-5/month** for a fully functional production app

### Free Tier Resources Breakdown

**🆓 Completely Free (Forever):**
- **Vercel** - Frontend hosting, unlimited personal projects
- **GitHub** - Repository hosting, Actions (2000 minutes/month)
- **Google OAuth** - Authentication service
- **Cloudinary** - Image storage (25GB bandwidth/month)

**💰 Minimal Cost Options:**
- **Railway** - $5/month after 500 hours free trial (includes DB + Redis)
- **Render** - Free tier with limitations, $7/month for production
- **PlanetScale** - Free MySQL tier (1 database, 1GB storage)
- **Redis Cloud** - 30MB free tier

**🎯 Recommended Stack for Real Usage:**
```
Frontend: Vercel (Free)
Backend: Railway ($5/month)
Database: PostgreSQL (included with Railway)
Storage: Cloudinary (Free tier)
Auth: Google OAuth (Free)
Monitoring: Railway built-in (Free)

Total: $5/month for production-ready app
```

**📱 Real-World Usage Considerations:**
- Supports 2-4 active users easily on free tiers
- Handle hundreds of expenses/month
- Real-time shopping lists work smoothly
- Professional custom domain possible
- Automatic deployments on git push
- SSL certificates included
- Database backups included

## Important Development Notes

### Brazilian Localization Requirements
- **Currency:** Brazilian Real (R$) with format "1.234,56"
- **Date Format:** DD/MM/YYYY consistently across application
- **Language:** Portuguese (Brasil) for all user-facing text
- **Number Format:** Brazilian standards (decimal comma, thousands dot)

### Performance Considerations
- **Mobile-First:** Optimize for mobile devices and slower connections
- **Image Optimization:** Compress receipt images, use WebP format
- **Bundle Size:** Keep JavaScript minimal, leverage Tailwind purging
- **Loading States:** Implement proper loading indicators for all async operations

### Security Best Practices
- **File Uploads:** Validate receipt file types and sizes (PNG, JPG, PDF up to 10MB)
- **Authentication:** Prepare for Google OAuth integration
- **API Security:** CORS configuration, rate limiting, input validation
- **Data Privacy:** LGPD compliance for Brazilian users

## Rails Learning Resources for Frontend Developers

As a frontend specialist transitioning to Rails backend development, this section provides detailed guidance and resources to accelerate your Rails learning journey.

### Rails Fundamentals for Frontend Developers

**Key Concepts to Master:**
1. **MVC Architecture:** Model-View-Controller pattern (similar to frontend frameworks)
2. **Active Record:** ORM for database interactions (like Prisma/TypeORM)
3. **Routing:** RESTful routes (similar to React Router but server-side)
4. **Migrations:** Version control for database schema changes
5. **Validations:** Server-side data validation (complements frontend validation)

### Rails Development Workflow

**Project Setup:**
```bash
# Create new Rails API project
rails new roommate-manager-api --api --database=postgresql

# Navigate to project
cd roommate-manager-api

# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate

# Start server
rails server  # Runs on localhost:3000
```

**Common Development Commands:**
```bash
# Generate resources (creates model, controller, routes)
rails generate resource Expense amount:decimal description:string user:references

# Generate migrations only
rails generate migration AddCategoryToExpenses category:string

# Run migrations
rails db:migrate

# Rollback migrations
rails db:rollback

# Reset database (development only)
rails db:reset

# Rails console (like Node.js REPL)
rails console

# Run tests
rails test        # Default Rails tests
rspec            # If using RSpec
```

### Essential Rails Patterns for API Development

**1. Model Structure (app/models/expense.rb):**
```ruby
class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :roommate, class_name: 'User'

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 3 }

  enum status: { pending: 0, settled: 1 }
  enum category: { groceries: 0, utilities: 1, household: 2, other: 3 }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_user, ->(user_id) { where(user_id: user_id) }
end
```

**2. Controller Structure (app/controllers/api/v1/expenses_controller.rb):**
```ruby
class Api::V1::ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :update, :destroy]

  def index
    @expenses = current_user.expenses.includes(:roommate).recent
    render json: @expenses, each_serializer: ExpenseSerializer
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      render json: @expense, serializer: ExpenseSerializer, status: :created
    else
      render json: { errors: @expense.errors }, status: :unprocessable_entity
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :description, :category, :roommate_id)
  end

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end
end
```

**3. Serializer Pattern (app/serializers/expense_serializer.rb):**
```ruby
class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :amount, :description, :category, :status, :created_at

  belongs_to :user, serializer: UserSerializer
  belongs_to :roommate, serializer: UserSerializer

  def amount
    object.amount.to_f
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y')  # Brazilian date format
  end
end
```

### Rails vs Frontend Development Parallels

**Routing Comparison:**
```ruby
# Rails routes (config/routes.rb)
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :expenses do
        member do
          patch :settle
        end
      end
    end
  end
end

# Similar to React Router
# /api/v1/expenses        (GET, POST)
# /api/v1/expenses/:id    (GET, PATCH, DELETE)
# /api/v1/expenses/:id/settle (PATCH)
```

**State Management Comparison:**
```ruby
# Rails: Database is your state store
# Models handle business logic
# Controllers handle HTTP requests/responses
# Similar to Redux pattern but server-side

# Frontend: Component state + global state
# Rails: Database state + application state
```

### Essential Gems for API Development

**Core API Gems:**
```ruby
# Gemfile
gem 'rails', '~> 7.0'
gem 'pg', '~> 1.1'                    # PostgreSQL
gem 'puma', '~> 5.0'                  # Web server
gem 'bootsnap', '>= 1.4.4'           # Boot optimization

# API specific
gem 'rack-cors'                       # CORS handling
gem 'active_model_serializers'       # JSON serialization
gem 'jbuilder'                        # JSON templates (alternative)

# Authentication
gem 'devise'                          # Authentication
gem 'devise-jwt'                      # JWT tokens
gem 'omniauth'                        # OAuth (Google)
gem 'omniauth-google-oauth2'          # Google OAuth

# Background processing
gem 'sidekiq'                         # Background jobs
gem 'redis'                           # Required for Sidekiq

# File uploads
gem 'image_processing', '~> 1.2'     # Image variants

# Development/Testing
group :development, :test do
  gem 'rspec-rails'                   # Testing framework
  gem 'factory_bot_rails'             # Test data factories
  gem 'faker'                         # Fake data generation
  gem 'pry-rails'                     # Better console
end

group :development do
  gem 'listen', '~> 3.3'              # File watching
  gem 'spring'                        # Application preloader
end
```

### Database Design Patterns

**Migration Examples:**
```ruby
# db/migrate/xxx_create_expenses.rb
class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :description, null: false
      t.integer :category, default: 0
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :roommate, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :expenses, :category
    add_index :expenses, :status
    add_index :expenses, :created_at
  end
end
```

### Testing Patterns for Frontend Developers

**Model Testing (spec/models/expense_spec.rb):**
```ruby
RSpec.describe Expense, type: :model do
  it 'validates presence of amount' do
    expense = build(:expense, amount: nil)
    expect(expense).not_to be_valid
    expect(expense.errors[:amount]).to include("can't be blank")
  end

  it 'calculates split amount correctly' do
    expense = create(:expense, amount: 100.00)
    expect(expense.split_amount).to eq(50.00)
  end
end
```

**API Testing (spec/requests/expenses_spec.rb):**
```ruby
RSpec.describe 'Expenses API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/expenses' do
    let(:expense_params) do
      {
        expense: {
          amount: 50.00,
          description: 'Groceries',
          category: 'groceries'
        }
      }
    end

    it 'creates a new expense' do
      expect {
        post '/api/v1/expenses', params: expense_params, headers: headers
      }.to change(Expense, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json_response['amount']).to eq(50.00)
    end
  end
end
```

### Real-time Features with Action Cable

**WebSocket Setup (app/channels/shopping_list_channel.rb):**
```ruby
class ShoppingListChannel < ApplicationCable::Channel
  def subscribed
    stream_from "shopping_list_#{current_user.id}"
  end

  def add_item(data)
    item = current_user.shopping_items.create!(data['item'])
    ActionCable.server.broadcast(
      "shopping_list_#{current_user.roommate.id}",
      {
        action: 'item_added',
        item: ShoppingItemSerializer.new(item).as_json
      }
    )
  end
end
```

### Learning Resources and Next Steps

**Essential Reading:**
1. **Rails Guides:** https://guides.rubyonrails.org/ (comprehensive official docs)
2. **Rails API Documentation:** Focus on ActionController::API
3. **Active Record Basics:** Understanding models and associations
4. **Rails Testing Guide:** RSpec vs Minitest patterns

**Practice Projects for Learning:**
1. **Start Simple:** Build the expense API endpoints first
2. **Add Complexity:** Implement user authentication with Devise
3. **Real-time Features:** Add Action Cable for shopping lists
4. **File Uploads:** Implement receipt uploads with Active Storage

**Development Tools:**
- **IDE:** RubyMine, VS Code with Ruby extensions
- **Database:** TablePlus, Postico for PostgreSQL visualization
- **API Testing:** Postman, Insomnia for endpoint testing
- **Console:** Use `rails console` extensively for debugging

This foundation will help you build a robust Rails API backend while leveraging your frontend expertise to create a well-structured, maintainable codebase.

## Atualizações Importantes da Estrutura

### Campos de Auditoria de Settlement

**Expenses (Despesas):**
```ruby
# Campos adicionais
- settled_at (datetime, nullable)     # Data/hora do settlement
- settled_by_id (integer, nullable)   # ID do usuário que fez o settlement

# Relacionamento
belongs_to :settled_by, class_name: 'User', optional: true

# Método helper
def mark_as_settled!(user)
  update!(
    status: :settled,
    settled_at: Time.current,
    settled_by: user
  )
end
```

**Shopping Items (Estrutura Simplificada):**
```ruby
# Campos principais
- id (primary key)
- name (string, not null) # "Organic Bananas", "Whole Milk - 1L"
- category (enum: produce, dairy, meat, household, pantry, other)
- completed (boolean, default: false) # Apenas boolean, sem auditoria
- created_at, updated_at

# Relacionamentos
- belongs_to :user (quem adicionou o item)
- belongs_to :roommate, class_name: 'User' (lista compartilhada)

# SEM campos de auditoria: completed_at, completed_by_id
# Rationale: Shopping list é temporária, não precisa de histórico detalhado
```

### Formatação Monetária Padronizada

**Helper para Serializers:**
```ruby
# app/serializers/concerns/currency_formatting.rb
module CurrencyFormatting
  extend ActiveSupport::Concern

  private

  def format_currency(amount)
    return { raw: 0.0, formatted: "R$ 0,00" } if amount.nil?

    {
      raw: amount.to_f,
      formatted: format_brazilian_currency(amount.to_f)
    }
  end

  def format_brazilian_currency(amount)
    # Converte para formato brasileiro: R$ 1.234,56
    formatted = sprintf("%.2f", amount)
    formatted = formatted.gsub('.', ',')  # Decimal vírgula

    # Adiciona pontos nos milhares
    integer_part, decimal_part = formatted.split(',')
    integer_part = integer_part.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse

    "R$ #{integer_part},#{decimal_part}"
  end
end
```

**Exemplo de Uso em Serializers:**
```ruby
class ExpenseSerializer < ActiveModel::Serializer
  include CurrencyFormatting

  attributes :id, :description, :amount, :your_share, :category, :status,
             :date, :settled_at, :settled_by

  def amount
    format_currency(object.amount)
  end

  def your_share
    format_currency(object.split_amount)
  end

  def settled_by
    return nil unless object.settled_by
    {
      id: object.settled_by.id,
      name: object.settled_by.name
    }
  end
end
```

**Exemplo de Response Final:**
```json
{
  "id": 1,
  "description": "Grocery Shopping",
  "amount": {
    "raw": 127.80,
    "formatted": "R$ 127,80"
  },
  "your_share": {
    "raw": 63.90,
    "formatted": "R$ 63,90"
  },
  "settled_at": "2025-09-20T14:30:00Z",
  "settled_by": {
    "id": 1,
    "name": "You"
  }
}
```

## Roadmap de Internacionalização (i18n)

### Estrutura de Idiomas Planejada

**Fase 5: Multi-idioma (4 semanas)**
```ruby
# Idiomas suportados (ordem de prioridade)
1. Português (Brasil) - pt-BR (padrão)
2. English - en-US
3. Español - es-ES
4. Framework preparado para expansão
```

**Implementação Rails I18n:**
```ruby
# config/locales/pt-BR.yml
pt-BR:
  expense:
    categories:
      groceries: "Compras"
      utilities: "Contas"
      household: "Casa"
    status:
      pending: "Pendente"
      settled: "Quitado"
  currency:
    symbol: "R$"
    format: "%n"
    separator: ","
    delimiter: "."

# config/locales/en-US.yml
en-US:
  expense:
    categories:
      groceries: "Groceries"
      utilities: "Utilities"
      household: "Household"
    status:
      pending: "Pending"
      settled: "Settled"
  currency:
    symbol: "$"
    format: "%s%n"
    separator: "."
    delimiter: ","
```

**API Response Localizada:**
```json
{
  "expense": {
    "category_display": "Compras",
    "status_display": "Pendente",
    "amount": {
      "raw": 127.80,
      "formatted": "R$ 127,80",
      "currency": "BRL"
    }
  },
  "locale": "pt-BR"
}
```

**Headers de Localização:**
```ruby
# API aceita header Accept-Language
Accept-Language: pt-BR,en-US;q=0.9,es-ES;q=0.8

# Endpoint para trocar idioma do usuário
PUT /api/v1/users/locale
{
  "locale": "en-US"
}
```

---

This codebase represents a well-structured foundation for a Brazilian-focused roommate expense management application, with complete prototypes ready for production development.