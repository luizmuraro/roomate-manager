# RoomMate Manager - HTML Prototype

> **Status:** MVP Complete ✅
> **7 Screens:** Fully functional HTML/CSS/JS prototypes

---

## Overview

This directory contains the complete HTML prototype for RoomMate Manager, featuring all core functionality implemented with HTML5, Tailwind CSS, and Vanilla JavaScript. The prototype serves as the foundation for the production React application.

## 🎯 Prototype Features

### ✅ Complete Screen Set
- **Authentication:** Login & Registration with roommate invitation
- **Dashboard:** Balance overview, quick actions, recent activity
- **Add Expense:** Smart form with split calculations and receipt upload
- **Expenses List:** Advanced filtering, search, and management
- **Shopping List:** Real-time collaborative shopping with auto-categorization
- **Receipt Gallery:** Visual receipt management with linking
- **Settings:** Comprehensive profile and preference management

### ✅ Advanced UX Patterns
- **Mobile-First Design:** Optimized for mobile with responsive desktop layout
- **Auto-Categorization:** Smart category detection for shopping items
- **Real-Time Sync:** UI patterns ready for WebSocket integration
- **Quick Actions:** Streamlined workflows for common tasks
- **Visual Feedback:** Hover states, transitions, and loading indicators

---

## 📁 File Structure

```
prototype/
├── html-screens/                    # Main prototype screens
│   ├── login_register_screens.html  # Authentication flow
│   ├── roommate_dashboard.html      # Main dashboard
│   ├── add_expense_modal.html       # Expense entry form
│   ├── expenses_list_screen.html    # Expense management
│   ├── shopping_list_screen.html    # Collaborative shopping
│   ├── receipt_gallery_screen.html  # Receipt management
│   └── settings_profile_screen.html # User settings
├── assets/                          # Shared assets
│   ├── css/                        # Custom CSS (minimal)
│   ├── js/                         # JavaScript utilities
│   └── images/                     # Placeholder images
└── README.md                       # This file
```

---

## 🚀 Getting Started

### Local Development

1. **Clone and Navigate**
   ```bash
   git clone <repository-url>
   cd roommate-manager/prototype
   ```

2. **Start Local Server**
   ```bash
   # Option 1: Python
   python -m http.server 8000

   # Option 2: Node.js
   npx serve .

   # Option 3: PHP
   php -S localhost:8000
   ```

3. **Open in Browser**
   ```
   http://localhost:8000/html-screens/login_register_screens.html
   ```

### Live Demo
Visit the [live prototype](https://your-username.github.io/roommate-manager) deployed on GitHub Pages.

---

## 📱 Screen Documentation

### 1. Authentication Flow
**File:** `login_register_screens.html`

**Features:**
- Clean, centered login form
- Two-step registration process
- Google OAuth integration ready
- Roommate invitation during signup
- Mobile-optimized form layout
- Real-time validation patterns

**Navigation:**
- Login → Dashboard
- Register → Dashboard
- Forgot Password → Recovery flow

---

### 2. Dashboard
**File:** `roommate_dashboard.html`

**Features:**
- **Balance Cards:** Current balance, total spent, your share
- **Quick Actions:** Add expense, upload receipt, shopping list, settle up
- **Recent Activity:** Timeline of latest expenses
- **Balance Breakdown:** Category-wise spending analysis
- **Responsive Grid:** 1-3 columns based on screen size

**Key Metrics:**
- Current balance: -R$ 245,50 (example debt state)
- Monthly spending: R$ 1,850,00
- Category breakdown with visual indicators

---

### 3. Add Expense Modal
**File:** `add_expense_modal.html`

**Features:**
- **Smart Form:** Auto-filled date, category suggestions
- **Split Calculator:** Real-time 50/50 split with custom options
- **Receipt Upload:** Drag & drop with preview
- **Category Selection:** Emoji-based categorization
- **Validation:** Real-time form validation

**Split Methods:**
- Equal (50/50) - Default and recommended
- Custom amounts - Specify exact values
- Percentage - Set custom percentages

---

### 4. Expenses List
**File:** `expenses_list_screen.html`

**Features:**
- **Advanced Filtering:** Search, category, status, date range
- **Quick Filters:** Pre-configured filter buttons
- **Dense Layout:** 6 expenses per screen view
- **Status Indicators:** Pending vs settled with visual cues
- **Receipt Indicators:** Shows which expenses have receipts

**Filtering Options:**
- Text search across descriptions
- Category filtering with emoji icons
- Date range selection
- Status filtering (pending/settled)
- Quick filters (you paid, roommate paid, high value)

---

### 5. Shopping List
**File:** `shopping_list_screen.html`

**Features:**
- **Quick Add:** Type item + Enter for rapid entry
- **Auto-Categorization:** Smart category detection
- **Real-Time Ready:** UI patterns for live collaboration
- **Visual Completion:** Check/uncheck with smooth animations
- **Filtering:** All, pending, completed items

**Auto-Categories:**
- 🥛 Dairy (milk, cheese, yogurt)
- 🥬 Produce (fruits, vegetables)
- 🍖 Meat (chicken, beef, fish)
- 🧹 Household (cleaning, toiletries)
- 📦 Other (miscellaneous items)

---

### 6. Receipt Gallery
**File:** `receipt_gallery_screen.html`

**Features:**
- **Drag & Drop Upload:** Large, prominent upload area
- **Responsive Grid:** 1-4 columns based on screen size
- **File Support:** PNG, JPG, PDF up to 10MB
- **Visual Organization:** Category filters and search
- **Linking System:** Connect receipts to expenses

**Organization:**
- Grid view with 3:4 aspect ratio
- Category filtering
- Link status indicators
- Hover effects and actions

---

### 7. Settings & Profile
**File:** `settings_profile_screen.html`

**Features:**
- **Profile Management:** Photo, personal info, save sections
- **Roommate Connection:** Current connection status and management
- **Notification Preferences:** Granular notification controls
- **App Preferences:** Currency, language, split method defaults
- **Privacy & Security:** Password management, data export
- **Danger Zone:** Account deletion and roommate disconnection

**Sections:**
- Profile (individual save)
- Roommate management
- Notifications (individual save)
- App preferences (individual save)
- Privacy & security (individual save)

---

## 🎨 Design System

### Color Palette
```css
/* Primary Colors */
--blue-600: #2563eb;    /* Primary actions */
--blue-50: #eff6ff;     /* Light backgrounds */

/* Status Colors */
--orange-500: #f97316;  /* Pending */
--green-500: #10b981;   /* Completed */
--red-500: #ef4444;     /* Debt/danger */

/* Neutral Scale */
--gray-50: #f9fafb;     /* Backgrounds */
--gray-900: #111827;    /* Text */
```

### Typography
```css
/* Headings */
.text-2xl { font-size: 1.5rem; }    /* Page titles */
.text-lg { font-size: 1.125rem; }   /* Section headers */

/* Body Text */
.text-base { font-size: 1rem; }     /* Standard text */
.text-sm { font-size: 0.875rem; }   /* Supporting text */
.text-xs { font-size: 0.75rem; }    /* Captions */
```

### Component Patterns
```css
/* Cards */
.card {
  @apply bg-white rounded-lg shadow-sm border border-gray-200;
}

/* Buttons */
.btn-primary {
  @apply bg-blue-600 text-white px-4 py-2 rounded-lg
         font-medium hover:bg-blue-700 transition-colors;
}

/* Status Badges */
.status-pending {
  @apply bg-orange-100 text-orange-800 px-2 py-1 rounded-full text-xs;
}
```

---

## ⚡ JavaScript Implementation

### Event Handling Patterns
```javascript
// Inline event handlers for prototype simplicity
<button onclick="handleAction()">Action</button>

// Function naming convention
function handleQuickAdd(event) { /* Add shopping item */ }
function toggleItemStatus(button) { /* Toggle completion */ }
function saveUserProfile() { /* Save profile changes */ }
```

### Auto-Categorization Logic
```javascript
function detectCategory(itemName) {
  const name = itemName.toLowerCase();

  // Dairy products
  if (name.includes('milk') || name.includes('cheese') || name.includes('yogurt')) {
    return { emoji: '🥛', class: 'dairy' };
  }

  // Produce
  if (name.includes('banana') || name.includes('apple') || name.includes('lettuce')) {
    return { emoji: '🥬', class: 'produce' };
  }

  // Meat
  if (name.includes('chicken') || name.includes('beef') || name.includes('fish')) {
    return { emoji: '🍖', class: 'meat' };
  }

  // Household
  if (name.includes('soap') || name.includes('shampoo') || name.includes('toilet')) {
    return { emoji: '🧹', class: 'household' };
  }

  // Default
  return { emoji: '📦', class: 'other' };
}
```

### Form Validation
```javascript
// Real-time date formatting
function formatDateInput(input) {
  let value = input.value.replace(/\D/g, '');
  if (value.length >= 3 && value.length <= 4) {
    value = value.replace(/(\d{2})(\d{1,2})/, '$1/$2');
  } else if (value.length >= 5) {
    value = value.replace(/(\d{2})(\d{2})(\d{4})/, '$1/$2/$3');
  }
  input.value = value;
}

// Required field validation
function validateForm(formElement) {
  const requiredFields = formElement.querySelectorAll('[required]');
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

## 📱 Responsive Design

### Breakpoint Strategy
```css
/* Mobile First (default: 0-639px) */
.mobile-layout { /* Base mobile styles */ }

/* Tablet (640px+) */
@media (min-width: 640px) {
  .tablet-layout { /* Tablet adaptations */ }
}

/* Desktop (1024px+) */
@media (min-width: 1024px) {
  .desktop-layout { /* Desktop enhancements */ }
}
```

### Grid Patterns
```css
/* Responsive cards */
.card-grid {
  grid-template-columns: 1fr;                /* Mobile: 1 column */
  @media (min-width: 640px) { columns: 2; } /* Tablet: 2 columns */
  @media (min-width: 1024px) { columns: 3; } /* Desktop: 3 columns */
}

/* Dashboard layout */
.dashboard-grid {
  gap: 1rem;                                   /* Mobile: compact */
  @media (min-width: 1024px) { gap: 1.5rem; } /* Desktop: generous */
}
```

---

## 🔗 Navigation Flow

### Screen Connections
```
Login/Register → Dashboard
Dashboard → Add Expense → Dashboard
Dashboard → Shopping List
Dashboard → Receipt Gallery
Dashboard → Expenses List → Expense Details
Dashboard → Settings → Profile/Preferences
```

### Quick Navigation
```javascript
// Screen navigation helper
function navigateToScreen(screenName) {
  const screens = {
    'login': 'login_register_screens.html',
    'dashboard': 'roommate_dashboard.html',
    'add-expense': 'add_expense_modal.html',
    'expenses': 'expenses_list_screen.html',
    'shopping': 'shopping_list_screen.html',
    'receipts': 'receipt_gallery_screen.html',
    'settings': 'settings_profile_screen.html'
  };

  if (screens[screenName]) {
    window.location.href = screens[screenName];
  }
}
```

---

## 🧪 Testing Guidelines

### Manual Testing Checklist

**Responsive Testing:**
- [ ] Test all screens on mobile (320px-768px)
- [ ] Test all screens on tablet (768px-1024px)
- [ ] Test all screens on desktop (1024px+)
- [ ] Verify touch targets are 44px minimum

**Functionality Testing:**
- [ ] All forms validate correctly
- [ ] Navigation works between screens
- [ ] Interactive elements respond to clicks/taps
- [ ] Auto-categorization works for shopping items

**Browser Testing:**
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)

**Accessibility Testing:**
- [ ] Keyboard navigation works
- [ ] Screen reader compatibility
- [ ] Color contrast meets WCAG standards
- [ ] Form labels are properly associated

---

## 🚀 Migration to React

### Component Mapping
```
HTML Screen → React Components
├── login_register_screens.html → AuthPage + LoginForm + RegisterForm
├── roommate_dashboard.html → Dashboard + BalanceCards + QuickActions
├── add_expense_modal.html → ExpenseModal + ExpenseForm
├── expenses_list_screen.html → ExpensesPage + ExpenseList + FilterBar
├── shopping_list_screen.html → ShoppingPage + ShoppingList + QuickAdd
├── receipt_gallery_screen.html → ReceiptsPage + ReceiptGallery + UploadArea
└── settings_profile_screen.html → SettingsPage + ProfileForm + PreferencesForm
```

### State Extraction
```javascript
// From prototype JavaScript to React state
const [expenses, setExpenses] = useState([]);
const [shoppingItems, setShoppingItems] = useState([]);
const [receipts, setReceipts] = useState([]);
const [user, setUser] = useState(null);
const [roommate, setRoommate] = useState(null);
```

---

## 📋 Development Notes

### Code Standards
- Use semantic HTML5 elements
- Follow BEM methodology for custom CSS classes
- Maintain consistent Tailwind utility usage
- Keep JavaScript functions simple and focused

### Performance Considerations
- Optimize images for web (WebP format)
- Minimize custom CSS in favor of Tailwind utilities
- Use efficient DOM querying patterns
- Implement proper loading states

### Accessibility Features
- Proper ARIA labels and roles
- Keyboard navigation support
- Screen reader compatibility
- High contrast mode support

---

## 🔄 Updates & Maintenance

### Version History
- **v1.0.0** - Initial MVP prototype complete
- **v1.0.1** - Responsive design improvements
- **v1.0.2** - Accessibility enhancements

### Future Enhancements
- [ ] OCR receipt scanning demo
- [ ] Advanced search filters
- [ ] Expense analytics visualizations
- [ ] Progressive Web App features

---

## 📚 Related Documentation

- [Main README](../README.md) - Project overview
- [Technical Docs](../docs/technical-docs.md) - Detailed specifications
- [User Guide](../docs/user-guide.md) - Feature documentation
- [Frontend Plan](../frontend/README.md) - React migration strategy

---

*This prototype serves as the complete foundation for the production React application. All design patterns, user flows, and functionality demonstrated here will be implemented in the final application.*