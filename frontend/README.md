# RoomMate Manager - Frontend (React Application)

> **Status:** Planned for Phase 2 Development
> **Current:** HTML Prototype Complete

---

## Overview

This directory will contain the production React frontend application for RoomMate Manager. The current implementation uses HTML prototypes located in the `prototype/` directory.

## Planned Technology Stack

### Core Framework
- **React 18+** - Modern React with hooks and concurrent features
- **TypeScript** - Type safety and better developer experience
- **Vite** - Fast build tool and development server

### Styling & UI
- **Tailwind CSS 3.x** - Utility-first CSS framework (maintained from prototype)
- **Headless UI** - Unstyled, accessible UI components
- **React Hook Form** - Performant forms with easy validation
- **Framer Motion** - Smooth animations and transitions

### State Management
- **Zustand** - Lightweight state management
- **React Query (TanStack Query)** - Server state management and caching
- **React Context** - Local component state when needed

### Routing & Navigation
- **React Router 6** - Declarative routing
- **React Router DOM** - DOM bindings for web

### API Integration
- **Axios** - HTTP client for API calls
- **React Query** - API caching and synchronization
- **WebSocket** - Real-time updates for shopping lists

### Development Tools
- **ESLint** - Code linting
- **Prettier** - Code formatting
- **Husky** - Git hooks
- **Lint-staged** - Pre-commit linting

### Testing
- **Vitest** - Unit testing framework
- **React Testing Library** - Component testing utilities
- **MSW (Mock Service Worker)** - API mocking for tests
- **Playwright** - End-to-end testing

### Build & Deployment
- **Vite** - Build tool
- **Vercel** - Deployment platform
- **GitHub Actions** - CI/CD pipeline

---

## Project Structure (Planned)

```
frontend/
├── public/
│   ├── icons/              # App icons and favicons
│   └── manifest.json       # PWA manifest
├── src/
│   ├── components/         # Reusable UI components
│   │   ├── ui/            # Basic UI components (Button, Input, etc.)
│   │   ├── forms/         # Form components
│   │   ├── layout/        # Layout components
│   │   └── common/        # Common components
│   ├── pages/             # Page components
│   │   ├── auth/         # Authentication pages
│   │   ├── dashboard/    # Dashboard page
│   │   ├── expenses/     # Expense management pages
│   │   ├── shopping/     # Shopping list pages
│   │   ├── receipts/     # Receipt gallery pages
│   │   └── settings/     # Settings pages
│   ├── hooks/            # Custom React hooks
│   ├── services/         # API services and utilities
│   ├── store/           # State management (Zustand stores)
│   ├── utils/           # Utility functions
│   ├── types/           # TypeScript type definitions
│   ├── styles/          # Global styles and Tailwind config
│   ├── assets/          # Static assets
│   ├── App.tsx          # Main application component
│   └── main.tsx         # Application entry point
├── tests/               # Test files
├── docs/               # Component documentation
├── package.json
├── tsconfig.json
├── vite.config.ts
├── tailwind.config.js
└── README.md
```

---

## Component Architecture

### Design System Components

Based on the prototype design system, we'll create these foundational components:

```typescript
// Basic UI Components
- Button (Primary, Secondary, Danger variants)
- Input (Text, Number, Date, File variants)
- Card (Standard, List variants)
- Badge (Status, Category variants)
- Modal (Standard, Confirmation variants)
- Dropdown (Select, Filter variants)

// Layout Components
- Header (With navigation and user menu)
- Sidebar (Desktop navigation)
- MobileNav (Mobile navigation)
- PageLayout (Standard page wrapper)
- Container (Responsive container)

// Form Components
- ExpenseForm (Add/edit expenses)
- ProfileForm (User profile editing)
- SettingsForm (App preferences)
- AuthForm (Login/register)

// Feature Components
- ExpenseList (Filterable expense table)
- ShoppingList (Collaborative shopping list)
- ReceiptGallery (Receipt management)
- BalanceCard (Balance display)
- QuickActions (Dashboard actions)
```

### State Management Structure

```typescript
// User Store
interface UserStore {
  user: User | null;
  roommate: User | null;
  login: (credentials: LoginCredentials) => Promise<void>;
  logout: () => void;
  updateProfile: (data: ProfileData) => Promise<void>;
}

// Expenses Store
interface ExpensesStore {
  expenses: Expense[];
  loading: boolean;
  filters: ExpenseFilters;
  addExpense: (expense: CreateExpenseData) => Promise<void>;
  updateExpense: (id: string, data: UpdateExpenseData) => Promise<void>;
  deleteExpense: (id: string) => Promise<void>;
  setFilters: (filters: ExpenseFilters) => void;
}

// Shopping Store
interface ShoppingStore {
  items: ShoppingItem[];
  addItem: (item: string) => void;
  toggleItem: (id: string) => void;
  removeItem: (id: string) => void;
  clearCompleted: () => void;
}

// Receipts Store
interface ReceiptsStore {
  receipts: Receipt[];
  uploading: boolean;
  uploadReceipt: (file: File) => Promise<Receipt>;
  linkToExpense: (receiptId: string, expenseId: string) => Promise<void>;
  deleteReceipt: (id: string) => Promise<void>;
}
```

---

## Migration Strategy

### Phase 2.1: Project Setup (Week 1)
- [ ] Initialize Vite + React + TypeScript project
- [ ] Configure Tailwind CSS with design system
- [ ] Set up ESLint, Prettier, and development tools
- [ ] Create basic project structure
- [ ] Set up CI/CD pipeline

### Phase 2.2: Core Components (Week 2)
- [ ] Implement design system components
- [ ] Create layout components (Header, Sidebar, etc.)
- [ ] Set up routing with React Router
- [ ] Implement authentication flow
- [ ] Create basic page layouts

### Phase 2.3: Feature Implementation (Weeks 3-4)
- [ ] Dashboard with balance cards and quick actions
- [ ] Add/edit expense functionality
- [ ] Expense list with filtering and search
- [ ] Shopping list with real-time updates
- [ ] Receipt gallery and upload

### Phase 2.4: Integration & Polish (Weeks 5-6)
- [ ] API integration with backend
- [ ] Real-time WebSocket implementation
- [ ] Form validation and error handling
- [ ] Loading states and error boundaries
- [ ] Performance optimization

### Phase 2.5: Testing & Deployment (Weeks 7-8)
- [ ] Unit tests for components and hooks
- [ ] Integration tests for user flows
- [ ] End-to-end tests with Playwright
- [ ] Production build optimization
- [ ] Deployment to Vercel

---

## Development Guidelines

### Code Standards
- Use TypeScript for all new code
- Follow React functional component patterns
- Use custom hooks for reusable logic
- Implement proper error boundaries
- Follow accessibility best practices (WCAG 2.1 AA)

### Component Guidelines
- Use compound component patterns where appropriate
- Implement proper TypeScript props interfaces
- Include JSDoc comments for complex components
- Use forwardRef for components that need DOM access
- Implement proper loading and error states

### Performance Considerations
- Use React.memo for expensive components
- Implement proper code splitting with React.lazy
- Optimize bundle size with tree shaking
- Use React Query for efficient data fetching
- Implement virtual scrolling for large lists

### Accessibility
- Maintain semantic HTML structure
- Implement proper ARIA attributes
- Ensure keyboard navigation works
- Test with screen readers
- Maintain color contrast standards

---

## API Integration

### Authentication
```typescript
// Auth service integration
const authService = {
  login: (credentials: LoginCredentials) => Promise<AuthResponse>,
  register: (userData: RegisterData) => Promise<AuthResponse>,
  refresh: () => Promise<AuthResponse>,
  logout: () => Promise<void>,
};
```

### Real-time Features
```typescript
// WebSocket integration for real-time updates
const useWebSocket = () => {
  // Shopping list updates
  // Expense notifications
  // Balance changes
};
```

---

## Progressive Web App (PWA)

### Offline Capabilities
- Cache critical app shell
- Offline expense entry (sync when online)
- Cached receipt viewing
- Background sync for shopping lists

### Mobile Features
- Add to home screen prompt
- Push notifications for expense updates
- Camera integration for receipt capture
- Touch-optimized interactions

---

## Next Steps

1. **Review Prototype:** Analyze HTML prototype for component patterns
2. **Setup Development Environment:** Initialize project with planned stack
3. **Create Design System:** Convert Tailwind utilities to React components
4. **Implement Core Features:** Start with authentication and dashboard
5. **Backend Integration:** Connect with Laravel API (Phase 3)

---

## Related Documentation

- [Prototype Documentation](../prototype/README.md)
- [Technical Documentation](../docs/technical-docs.md)
- [Backend Documentation](../backend/README.md)

---

*This directory will be populated during Phase 2 of development. The HTML prototypes in the `prototype/` directory serve as the foundation for the React implementation.*