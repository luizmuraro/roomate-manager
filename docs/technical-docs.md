# RoomMate Manager - Technical Documentation

**Version:** 1.0.0-prototype
**Date:** September 2025
**Status:** MVP Complete

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Project Overview](#project-overview)
3. [Technical Architecture](#technical-architecture)
4. [Screen Documentation](#screen-documentation)
5. [Design System](#design-system)
6. [Implementation Details](#implementation-details)
7. [Development Guidelines](#development-guidelines)
8. [Deployment Strategy](#deployment-strategy)
9. [Future Roadmap](#future-roadmap)

---

## Executive Summary

RoomMate Manager is a collaborative expense management application designed specifically for roommates. The MVP prototype has been successfully completed, featuring all core functionality implemented as responsive HTML prototypes with advanced UX patterns.

### Key Achievements
- ✅ Complete MVP prototype with 7 core screens
- ✅ Mobile-first responsive design
- ✅ Advanced UX patterns (quick add, auto-categorization, real-time sync)
- ✅ Comprehensive design system established
- ✅ Production-ready UI components

### Project Metrics
- **Development Time:** 2 weeks
- **Screens Completed:** 7/7 (100%)
- **Core Features:** 15+ implemented
- **Design Consistency:** Standardized across all screens
- **Mobile Optimization:** Full responsive design

---

## Project Overview

### Problem Statement
Roommates struggle with tracking shared expenses, splitting costs fairly, and settling balances. Traditional solutions are either too complex or lack collaborative features for shared living situations.

### Solution Approach
A streamlined web application focused on the essential features roommates need:
- Simple expense splitting (50/50 default)
- Real-time shopping lists
- Receipt management with visual gallery
- Clear balance tracking with minimal states

### Target Users
- **Primary:** 2-person roommate pairs
- **Secondary:** Small shared living situations (3-4 people)
- **Demographics:** Young professionals, students, urban renters

---

## Technical Architecture

### Current Stack (Prototype)
```
Frontend: HTML5 + Tailwind CSS + Vanilla JavaScript
Icons: Font Awesome 6.4.0
Design: Mobile-first responsive
Browser Support: Modern browsers (Chrome, Firefox, Safari)
```

### Planned Production Stack
```
Frontend: React + TypeScript + Tailwind CSS + shadcn/ui
Backend: Ruby on Rails 7+ (RESTful API)
Database: PostgreSQL/MySQL
Authentication: Google OAuth + Devise + JWT
Real-time: Action Cable (WebSockets) for shopping lists
Background Jobs: Sidekiq + Redis
Deployment: Vercel (frontend) + Heroku/Railway (backend)
```

### Architecture Principles
- **Mobile-First:** All designs start with mobile layout
- **Component-Based:** Reusable UI patterns
- **API-Driven:** Clear separation of concerns
- **Real-time Collaboration:** Live updates for shared features

---

## Screen Documentation

### 1. Authentication System

**Login Screen**
- Clean, centered design with logo prominence
- Email/password fields with validation
- Google OAuth integration ready
- "Remember me" and "Forgot password" options
- Mobile-optimized form layout

**Registration Screen**
- Two-step form: personal info + roommate invitation
- Real-time validation for password strength
- Optional roommate email invitation during signup
- Terms of service agreement
- Seamless transition to dashboard post-registration

**Key Features:**
- Google OAuth integration ready
- No demo account (production-focused)
- Roommate invitation flow
- Responsive form validation

---

### 2. Dashboard - Central Hub

The dashboard provides an immediate overview of financial status and quick access to core functions.

**Layout Structure:**
- **Balance Cards:** Your Balance, Total Spent, Your Share
- **Quick Actions:** Add Expense, Upload Receipt, Shopping List, Settle Up
- **Recent Activity:** Timeline of recent expenses with amounts
- **Balance with Roommate:** Detailed breakdown by category

**Visual Hierarchy:**
- Primary focus on balance status (red for debt, green for credit)
- Quick actions prominently displayed with icons
- Recent activity with clear visual indicators
- Responsive grid system (1 column mobile, 3 columns desktop)

**Key Metrics Displayed:**
- Your current balance: -R$ 245,50 (you owe)
- Total monthly spending: R$ 1,850,00
- Your 50% share: R$ 925,00
- Category breakdowns (Groceries, Utilities, Household)

---

### 3. Add Expense - Streamlined Entry

**Form Structure:**
- **Basic Info:** Description, amount, date, paid by
- **Category Selection:** Optional categorization with emoji indicators
- **Split Options:** Equal (default), Custom, Percentage
- **Receipt Upload:** Drag & drop with preview
- **Smart Receipt Scanner:** Feature teaser for future implementation

**Split Calculation:**
- Real-time calculation display
- Default 50/50 split highlighted as "Recommended"
- Custom split options for special cases
- Clear visualization of each person's share

**UX Enhancements:**
- Auto-filled current date
- Smart category suggestions
- Receipt upload with preview
- Form validation with clear error states

---

### 4. Expenses List - Dense Information Display

**Advanced Filtering System:**
- **Search:** Real-time text search across expense descriptions
- **Category Filter:** Dropdown with emoji indicators
- **Status Filter:** Current Balance vs Settled
- **Date Range:** Custom date picker with quick presets
- **Quick Filters:** All, You Paid, Alex Paid, High Value, Current Balance

**Table Design:**
- **Density Optimized:** 6 expenses visible per screen
- **Color Coding:** Border-left indicators by category
- **Status Indicators:** Clear pending/settled states
- **Action Buttons:** View details, more options per row
- **Receipt Status:** Visual indicators for attached receipts

**Data Structure per Row:**
- Expense name with category badge
- Date, who paid, category
- Total amount and your share
- Status (Pending/Settled) with payment info
- Receipt availability indicator

---

### 5. Shopping List - Real-time Collaboration

**Quick Add System:**
- **Single Input Field:** Type item name + Enter to add
- **Auto-categorization:** Smart category detection by keywords
- **Auto-focus:** Immediate input availability
- **Auto-clear:** Input clears after adding for rapid entry

**List Management:**
- **Real-time Sync:** WebSocket-ready for live updates
- **Check/Uncheck:** Visual completion states
- **Category Indicators:** Emoji-based categorization
- **Collaboration Tracking:** Shows who added each item

**Filtering Options:**
- All items (12), Pending (8), Done (4)
- Quick clear completed items
- Sort and organization options

**Visual Design:**
- Compact row layout (py-3 px-4) for maximum density
- Hover states for better interaction feedback
- Smooth animations for add/remove actions
- Mobile-optimized touch targets

---

### 6. Receipt Gallery - Visual Organization

**Upload System:**
- **Drag & Drop Area:** Large, prominent upload zone
- **File Support:** PNG, JPG, PDF up to 10MB
- **Batch Upload:** Multiple file selection
- **Instant Preview:** Thumbnail generation

**Gallery Layout:**
- **Responsive Grid:** 1-4 columns based on screen size
- **Aspect Ratio:** 3:4 ratio for consistent preview sizing
- **Hover Effects:** Subtle elevation on hover
- **Link Status:** Visual indicators for expense linking

**Filtering & Organization:**
- **Category Filters:** All, Recent, Groceries, Utilities, Unlinked
- **Sort Options:** Date, Amount, Category
- **View Modes:** Grid (default) and List view
- **Search:** Text search across receipt descriptions

**Receipt Card Structure:**
- **Preview Image:** Thumbnail with fallback for PDFs
- **Metadata:** Amount, date, linked status
- **Category Badge:** Color-coded with emoji
- **Actions:** Link to expense, delete, edit

---

### 7. Settings & Profile - Comprehensive Management

**Profile Section:**
- **Photo Management:** Avatar with change photo option
- **Personal Info:** Name, email, phone (optional)
- **Individual Save:** Dedicated "Save Profile" button

**Roommate Management:**
- **Current Connection:** Display connected roommate with status
- **Connection History:** "Connected since" information
- **Invite System:** Ready for additional roommate invitations
- **Management Options:** Rename, permissions, remove

**Notification Preferences:**
- **Email Notifications:** Master toggle
- **New Expenses:** When roommate adds expenses
- **Settlement Reminders:** Weekly balance notifications
- **Shopping Lists:** Item updates and completions
- **Individual Save:** "Save Notifications" button

**App Preferences:**
- **Currency:** Brazilian Real (R$) default with international options
- **Language:** Portuguese (Brasil) with multi-language support
- **Split Method:** Default to equal split with custom options
- **Auto-categorization:** Smart category suggestions toggle
- **Individual Save:** "Save Preferences" button

**Privacy & Security:**
- **Password Management:** Change password with last updated info
- **Data Export:** Download expense data (CSV/JSON)
- **Individual Save:** "Save Security" button

**Danger Zone:**
- **Disconnect Roommate:** Settle balances and remove connection
- **Delete Account:** Permanent account deletion with confirmation
- **Visual Warning:** Red styling for destructive actions

---

## Design System

### Color Palette
```css
/* Primary Colors */
--blue-primary: #3b82f6;    /* Primary actions, links */
--blue-light: #eff6ff;      /* Hover states, backgrounds */

/* Status Colors */
--orange-pending: #f97316;  /* Pending expenses */
--green-settled: #10b981;   /* Settled/completed */
--red-debt: #ef4444;        /* Debt/owed amounts */

/* Neutral Colors */
--gray-50: #f9fafb;         /* Backgrounds */
--gray-100: #f3f4f6;        /* Borders, dividers */
--gray-600: #4b5563;        /* Secondary text */
--gray-900: #111827;        /* Primary text */
```

### Typography Scale
```css
/* Headings */
.text-2xl { font-size: 1.5rem; }   /* Page titles */
.text-lg { font-size: 1.125rem; }  /* Section headers */
.text-base { font-size: 1rem; }    /* Body text */

/* Supporting Text */
.text-sm { font-size: 0.875rem; }  /* Metadata */
.text-xs { font-size: 0.75rem; }   /* Labels, captions */

/* Weights */
.font-bold { font-weight: 700; }     /* Emphasis */
.font-semibold { font-weight: 600; } /* Headers */
.font-medium { font-weight: 500; }   /* Default */
```

### Spacing System
```css
/* High Density (Lists, Tables) */
.compact { padding: 0.75rem 1rem; }  /* py-3 px-4 */

/* Normal Density (Cards, Forms) */
.normal { padding: 1rem 1.5rem; }    /* py-4 px-6 */

/* Generous (Headers, Sections) */
.generous { padding: 1.5rem 2rem; }  /* py-6 px-8 */
```

### Component Patterns

**Card Pattern:**
```css
.card {
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  border: 1px solid #e5e7eb;
}
```

**Button Patterns:**
```css
.btn-primary {
  background: #3b82f6;
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 0.5rem;
  transition: background-color 0.2s;
}

.btn-primary:hover {
  background: #2563eb;
}
```

**Status Indicators:**
```css
.status-pending {
  background: #fff7ed;
  color: #c2410c;
}

.status-settled {
  background: #ecfdf5;
  color: #065f46;
}
```

### Responsive Breakpoints
```css
/* Mobile First Approach */
/* xs: 0px - 639px (default) */
/* sm: 640px+ */  @media (min-width: 640px)
/* md: 768px+ */  @media (min-width: 768px)
/* lg: 1024px+ */ @media (min-width: 1024px)
/* xl: 1280px+ */ @media (min-width: 1280px)
```

### Grid Systems
```css
/* List Grids (Expenses, Receipts) */
.grid-responsive {
  grid-template-columns: 1fr;                    /* Mobile */
  @media (min-width: 640px) { columns: 2; }     /* SM */
  @media (min-width: 1024px) { columns: 3; }    /* LG */
  @media (min-width: 1280px) { columns: 4; }    /* XL */
}
```

---

## Rails Backend Development Guide

### Development Environment Setup

**Prerequisites:**
- Ruby 3.0+ installed (recommended: use rbenv or rvm)
- PostgreSQL or MySQL database
- Redis (for background jobs)
- Node.js (for asset compilation if needed)

**Initial Project Setup:**
```bash
# Create new Rails API project
rails new roommate-manager-api --api --database=postgresql

# Navigate to project directory
cd roommate-manager-api

# Install dependencies
bundle install

# Configure database
rails db:create
rails db:migrate
rails db:seed

# Start development servers
rails server          # API server (port 3000)
redis-server          # For background jobs
bundle exec sidekiq   # Background job processor
```

### Essential Rails Development Commands

**Database Management:**
```bash
# Create and run migrations
rails generate migration CreateExpenses amount:decimal description:string
rails db:migrate

# Generate models with associations
rails generate model User email:string name:string
rails generate model Expense amount:decimal description:string user:references

# Reset database (development only)
rails db:reset
rails db:drop db:create db:migrate db:seed

# Rollback migrations
rails db:rollback STEP=2

# Check migration status
rails db:migrate:status
```

**Code Generation:**
```bash
# Generate complete resources (model + controller + routes)
rails generate resource Expense amount:decimal description:string user:references

# Generate controllers only
rails generate controller Api::V1::Expenses index create show update destroy

# Generate serializers (if using active_model_serializers)
rails generate serializer Expense amount description category status

# Generate background jobs
rails generate job ProcessReceipt
```

**Testing Commands:**
```bash
# Run all tests
rails test                    # Default Rails testing
bundle exec rspec            # RSpec tests
bundle exec rspec spec/models # Run specific test types

# Generate test files
rails generate rspec:model Expense
rails generate rspec:request Expenses
```

**Development Tools:**
```bash
# Interactive console (like Node.js REPL)
rails console
rails console --sandbox      # Rollback all changes on exit

# Routes inspection
rails routes
rails routes | grep expense  # Filter specific routes

# Database console
rails dbconsole

# Generate documentation
bundle exec yard             # Generate API documentation
```

### Rails Project Structure for API

```
app/
├── controllers/
│   └── api/
│       └── v1/
│           ├── application_controller.rb
│           ├── expenses_controller.rb
│           ├── users_controller.rb
│           └── shopping_items_controller.rb
├── models/
│   ├── user.rb
│   ├── expense.rb
│   └── shopping_item.rb
├── serializers/
│   ├── user_serializer.rb
│   ├── expense_serializer.rb
│   └── shopping_item_serializer.rb
├── jobs/
│   ├── application_job.rb
│   └── receipt_processing_job.rb
├── channels/
│   ├── application_cable/
│   └── shopping_list_channel.rb
└── mailers/
    └── user_mailer.rb

config/
├── routes.rb
├── database.yml
├── application.rb
└── environments/
    ├── development.rb
    ├── production.rb
    └── test.rb

db/
├── migrate/
├── schema.rb
└── seeds.rb

spec/                        # RSpec tests
├── models/
├── requests/
├── jobs/
└── factories/

Gemfile                      # Dependencies
```

### Core Rails Patterns for This Project

**User Model with Roommate Relationship:**
```ruby
# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses, dependent: :destroy
  has_many :paid_expenses, class_name: 'Expense', foreign_key: 'paid_by_id'
  has_many :shopping_items, dependent: :destroy

  belongs_to :roommate, class_name: 'User', optional: true
  has_one :roommate_connection, class_name: 'User', foreign_key: 'roommate_id'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def total_balance
    expenses.sum(:amount) - paid_expenses.sum(:amount)
  end
end
```

**Expense Model with Business Logic:**
```ruby
# app/models/expense.rb
class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :paid_by, class_name: 'User'
  has_one_attached :receipt

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 3 }

  enum status: { pending: 0, settled: 1 }
  enum category: {
    groceries: 0,
    utilities: 1,
    household: 2,
    dining: 3,
    other: 4
  }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_category, ->(cat) { where(category: cat) }
  scope :by_status, ->(status) { where(status: status) }

  def split_amount
    amount / 2.0  # For roommate pairs
  end

  def formatted_amount
    "R$ #{amount.to_f.to_s.gsub('.', ',')}"
  end
end
```

**API Controller Pattern:**
```ruby
# app/controllers/api/v1/expenses_controller.rb
class Api::V1::ExpensesController < Api::V1::ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :update, :destroy, :settle]

  def index
    @expenses = current_user.expenses
                           .includes(:paid_by, receipt_attachment: :blob)
                           .recent

    @expenses = @expenses.by_category(params[:category]) if params[:category].present?
    @expenses = @expenses.by_status(params[:status]) if params[:status].present?

    render json: @expenses, each_serializer: ExpenseSerializer
  end

  def create
    @expense = current_user.expenses.build(expense_params)
    @expense.paid_by = current_user

    if @expense.save
      ExpenseNotificationJob.perform_later(@expense)
      render json: @expense, serializer: ExpenseSerializer, status: :created
    else
      render json: { errors: @expense.errors }, status: :unprocessable_entity
    end
  end

  def settle
    @expense.update!(status: :settled)
    render json: @expense, serializer: ExpenseSerializer
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :description, :category, :receipt)
  end

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end
end
```

**Background Job for Processing:**
```ruby
# app/jobs/expense_notification_job.rb
class ExpenseNotificationJob < ApplicationJob
  queue_as :default

  def perform(expense)
    # Send notification to roommate
    UserMailer.expense_added(expense).deliver_now

    # Broadcast to real-time channel
    ActionCable.server.broadcast(
      "user_#{expense.user.roommate_id}",
      {
        type: 'expense_added',
        expense: ExpenseSerializer.new(expense).as_json
      }
    )
  end
end
```

**Real-time Shopping List with Action Cable:**
```ruby
# app/channels/shopping_list_channel.rb
class ShoppingListChannel < ApplicationCable::Channel
  def subscribed
    stream_from "shopping_list_#{current_user.id}"
    stream_from "shopping_list_#{current_user.roommate_id}" if current_user.roommate
  end

  def add_item(data)
    item = current_user.shopping_items.create!(
      name: data['name'],
      category: detect_category(data['name'])
    )

    broadcast_to_roommate('item_added', item)
  end

  def toggle_item(data)
    item = current_user.shopping_items.find(data['id'])
    item.update!(completed: !item.completed)

    broadcast_to_roommate('item_toggled', item)
  end

  private

  def broadcast_to_roommate(action, item)
    ActionCable.server.broadcast(
      "shopping_list_#{current_user.roommate_id}",
      {
        action: action,
        item: ShoppingItemSerializer.new(item).as_json
      }
    )
  end

  def detect_category(name)
    # Auto-categorization logic
    case name.downcase
    when /milk|cheese|yogurt/ then 'dairy'
    when /banana|apple|fruit/ then 'produce'
    when /chicken|beef|meat/ then 'meat'
    else 'other'
    end
  end
end
```

### Testing Patterns

**Model Testing with RSpec:**
```ruby
# spec/models/expense_spec.rb
RSpec.describe Expense, type: :model do
  let(:user) { create(:user) }
  let(:roommate) { create(:user) }

  before { user.update(roommate: roommate) }

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:paid_by) }
  end

  describe '#split_amount' do
    let(:expense) { create(:expense, amount: 100.00) }

    it 'calculates 50% split for roommate pairs' do
      expect(expense.split_amount).to eq(50.00)
    end
  end

  describe 'scopes' do
    let!(:grocery_expense) { create(:expense, category: 'groceries') }
    let!(:utility_expense) { create(:expense, category: 'utilities') }

    it 'filters by category' do
      expect(Expense.by_category('groceries')).to include(grocery_expense)
      expect(Expense.by_category('groceries')).not_to include(utility_expense)
    end
  end
end
```

**Request Testing for API:**
```ruby
# spec/requests/api/v1/expenses_spec.rb
RSpec.describe 'Api::V1::Expenses', type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/expenses' do
    let!(:expenses) { create_list(:expense, 3, user: user) }

    it 'returns expenses for current user' do
      get '/api/v1/expenses', headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_response.size).to eq(3)
    end

    it 'filters by category' do
      create(:expense, user: user, category: 'groceries')
      create(:expense, user: user, category: 'utilities')

      get '/api/v1/expenses?category=groceries', headers: headers

      expect(json_response.size).to eq(1)
      expect(json_response.first['category']).to eq('groceries')
    end
  end

  describe 'POST /api/v1/expenses' do
    let(:expense_params) do
      {
        expense: {
          amount: 50.00,
          description: 'Groceries at Mercado',
          category: 'groceries'
        }
      }
    end

    it 'creates a new expense' do
      expect {
        post '/api/v1/expenses', params: expense_params, headers: headers
      }.to change(Expense, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(json_response['amount']).to eq('50.0')
    end
  end
end
```

---

## Implementation Details

### JavaScript Patterns

**Event Handling:**
```javascript
// Inline onclick for prototype simplicity
<button onclick="handleAction()">Action</button>

// Function naming convention: camelCase
function handleQuickAdd(event) { }
function toggleItemStatus(button) { }
function saveUserProfile() { }
```

**DOM Manipulation:**
```javascript
// Consistent query patterns
const items = document.querySelectorAll('.item-row');
const activeFilters = document.querySelectorAll('.filter.active');

// Class manipulation
element.classList.add('active');
element.classList.remove('hidden');
element.classList.toggle('completed');
```

**Auto-categorization Logic:**
```javascript
function detectCategory(itemName) {
  const name = itemName.toLowerCase();

  if (name.includes('milk') || name.includes('cheese')) {
    return { emoji: '🥛', class: 'dairy' };
  }

  if (name.includes('banana') || name.includes('apple')) {
    return { emoji: '🥬', class: 'produce' };
  }

  // ... more heuristics

  return { emoji: '📦', class: 'other' };
}
```

### CSS Architecture

**Utility-First Approach:**
```css
/* Component classes built from utilities */
.expense-row {
  @apply px-4 py-3 flex items-center space-x-3 hover:bg-gray-50;
}

.quick-filter {
  @apply px-4 py-2.5 text-sm font-medium rounded-xl border-2
         border-gray-200 text-gray-600 hover:bg-gray-50
         hover:border-gray-300 transition-all duration-200
         bg-white shadow-sm;
}

.quick-filter.active {
  @apply bg-blue-600 text-white border-blue-600 shadow-md
         transform scale-105;
}
```

**Animation Patterns:**
```css
/* Standard transitions */
.transition-colors { transition: color 0.2s ease; }
.transition-all { transition: all 0.2s ease; }

/* Hover elevations */
.hover\:shadow-lg:hover {
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

/* Loading states */
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}
```

### Form Validation Patterns

**Real-time Validation:**
```javascript
// Date input formatting
const dateInput = document.getElementById('date');
dateInput.addEventListener('input', (e) => {
  let value = e.target.value.replace(/\D/g, '');
  if (value.length >= 3 && value.length <= 4) {
    value = value.replace(/(\d{2})(\d{1,2})/, '$1/$2');
  } else if (value.length >= 5) {
    value = value.replace(/(\d{2})(\d{2})(\d{4})/, '$1/$2/$3');
  }
  e.target.value = value;
});
```

**Required Field Handling:**
```javascript
function validateForm(formId) {
  const form = document.getElementById(formId);
  const requiredFields = form.querySelectorAll('[required]');

  let isValid = true;
  requiredFields.forEach(field => {
    if (!field.value.trim()) {
      field.classList.add('border-red-300');
      isValid = false;
    } else {
      field.classList.remove('border-red-300');
    }
  });

  return isValid;
}
```

---

## Development Guidelines

### Code Standards

**HTML Structure:**
```html
<!-- Semantic structure -->
<main class="flex-1 lg:pl-64">
  <section class="px-4 py-6 lg:px-8">
    <header class="mb-6">
      <h1 class="text-2xl font-bold text-gray-900">Page Title</h1>
    </header>
    <!-- Content -->
  </section>
</main>
```

**Accessibility Requirements:**
```html
<!-- ARIA labels -->
<button aria-label="Add new expense" class="floating-add-btn">
  <i class="fas fa-plus" aria-hidden="true"></i>
</button>

<!-- Form labels -->
<label for="expense-amount" class="block text-sm font-medium">
  Amount
</label>
<input id="expense-amount" type="number" required>
```

### shadcn/ui Integration Strategy

**Framework Selection Rationale:**
shadcn/ui was chosen for its modern approach to component libraries - components are copied into the codebase rather than imported as dependencies. This provides:
- Full customization control for Brazilian localization
- No external dependency risks
- Easy modification for app-specific requirements
- Built on proven Radix UI primitives
- Perfect TypeScript support
- Excellent Tailwind CSS integration

**Essential Components for Roommate Manager:**
```bash
# Core UI (Phase 1)
npx shadcn-ui@latest add button card input label badge avatar

# Forms & Interactions (Phase 2)
npx shadcn-ui@latest add form dialog sheet dropdown-menu select textarea

# Data Display (Phase 3)
npx shadcn-ui@latest add table calendar command popover toast tabs
```

**Component Hierarchy:**
```
src/components/
├── ui/                    # shadcn/ui base components (auto-generated)
├── expense/               # Expense-specific composites
├── shopping/              # Shopping list components
├── receipts/              # Receipt management
├── dashboard/             # Dashboard widgets
└── layout/                # App layout components
```

**Brazilian Localization Extensions:**
- Currency: R$ 1.234,56 formatting
- Dates: DD/MM/YYYY format
- Forms: Portuguese validation messages
- Calendar: Brazilian holidays support
- Number formatting: Decimal comma convention

**Migration from HTML Prototypes:**
Each existing HTML screen component maps to shadcn-based React components, maintaining the same visual design while adding interactive capabilities and real-time features.

### Component Documentation

**Button Components:**
```html
<!-- Primary Button -->
<button class="bg-blue-600 text-white px-4 py-2 rounded-lg
               font-medium hover:bg-blue-700 transition-colors">
  Primary Action
</button>

<!-- Secondary Button -->
<button class="border border-gray-300 text-gray-700 px-4 py-2
               rounded-lg hover:bg-gray-50 transition-colors">
  Secondary Action
</button>
```

**Card Components:**
```html
<!-- Standard Card -->
<div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
  <h3 class="font-semibold text-gray-900 mb-4">Card Title</h3>
  <!-- Card content -->
</div>

<!-- List Card -->
<div class="bg-white rounded-lg shadow-sm border border-gray-200">
  <div class="px-6 py-3 border-b border-gray-200">
    <h3 class="font-semibold text-gray-900">List Header</h3>
  </div>
  <div class="divide-y divide-gray-100">
    <!-- List items -->
  </div>
</div>
```

### Performance Guidelines

**Image Optimization:**
- Use appropriate formats (WebP for photos, SVG for icons)
- Implement lazy loading for receipt gallery
- Compress images to <100KB for thumbnails

**JavaScript Performance:**
- Debounce search inputs (300ms delay)
- Use event delegation for dynamic content
- Minimize DOM queries with caching

**CSS Optimization:**
- Use Tailwind's purge feature in production
- Minimize custom CSS in favor of utilities
- Use CSS Grid/Flexbox over JavaScript layouts

---

## Deployment Strategy

### Development Environment
```bash
# Local development server
python -m http.server 8000
# or
npx serve .
```

### Staging Environment
```yaml
# Vercel configuration (vercel.json)
{
  "builds": [
    {
      "src": "*.html",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/$1"
    }
  ]
}
```

### Production Considerations

**Performance:**
- Enable Gzip compression
- Set up CDN for static assets
- Implement service worker for offline functionality

**Security:**
- HTTPS enforcement
- Content Security Policy headers
- XSS protection

**Monitoring:**
- Error tracking (Sentry)
- Performance monitoring (Web Vitals)
- User analytics (privacy-compliant)

---

## Future Roadmap

### Phase 1: Backend Development (4 weeks)
- [ ] Ruby on Rails API setup with authentication
- [ ] Database schema implementation with migrations
- [ ] CRUD operations for all entities using Active Record
- [ ] Real-time Action Cable integration for shopping lists
- [ ] Background job processing with Sidekiq
- [ ] File upload handling with Active Storage

### Phase 2: React Migration (6 weeks)
- [ ] shadcn/ui setup and core component integration
- [ ] Component library development (extend shadcn components)
- [ ] State management (Zustand/Redux)
- [ ] Rails API integration with error handling
- [ ] Advanced form validation (client + server)
- [ ] WebSocket integration with Action Cable
- [ ] Authentication flow with JWT tokens
- [ ] Custom component development for app-specific features

### Phase 3: Advanced Features (8 weeks)
- [ ] OCR receipt scanning integration
- [ ] Bank account connections (Open Banking)
- [ ] Advanced reporting and analytics with Rails reporting gems
- [ ] Multi-roommate support (3+ people)
- [ ] Background job monitoring and management
- [ ] API rate limiting and security enhancements

### Phase 4: Mobile & Polish (4 weeks)
- [ ] Progressive Web App implementation
- [ ] Push notifications
- [ ] Offline functionality
- [ ] Performance optimization

### Future Enhancements

**Phase 5: Internationalization (4 weeks)**
- [ ] **Multi-language Support (i18n):** Framework implementation with Rails I18n
- [ ] **Portuguese (Brasil):** Primary language (default)
- [ ] **English:** Secondary language for international users
- [ ] **Spanish:** Third language for LATAM expansion
- [ ] **Localization Framework:** Prepared for additional languages
- [ ] **Currency Localization:** Multi-currency support with exchange rates
- [ ] **Date/Number Formatting:** Region-specific formatting patterns
- [ ] **Cultural Adaptations:** Local payment methods and preferences

**Long-term Enhancements:**
- Advanced machine learning for expense categorization
- Integration with popular payment apps (PIX, PayPal, Stripe, Mercado Pago)
- Shared budget planning and financial goals
- Expense approval workflows for group living
- Integration with accounting software (QuickBooks, ContaAzul)
- Multi-currency support with real-time exchange rates
- Advanced reporting and analytics dashboard
- Mobile app development (React Native)
- Offline-first functionality with sync capabilities

---

## Conclusion

The RoomMate Manager prototype successfully demonstrates a comprehensive solution for roommate expense management. The MVP implementation provides a solid foundation for production development with:

✅ **Complete Feature Set** - All essential roommate expense features
✅ **Production-Ready Design** - Consistent, accessible, responsive
✅ **Scalable Architecture** - Clear patterns for React migration
✅ **User-Focused UX** - Optimized for daily expense management

The prototype is ready for backend development and React migration, with clear technical specifications and design patterns established for efficient development workflow.

---

*This documentation serves as the technical specification for development and the user guide for stakeholders. For development questions, refer to the implementation sections. For business questions, refer to the project overview and roadmap sections.*