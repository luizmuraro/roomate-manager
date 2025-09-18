# RoomMate Manager 🏠💰

> **Collaborative expense management web application for roommates**

[![Live Demo](https://img.shields.io/badge/Live-Demo-blue?style=for-the-badge)](https://your-username.github.io/roommate-manager)
[![MVP Status](https://img.shields.io/badge/Status-MVP%20Complete-green?style=for-the-badge)](#mvp-status)
[![Brazilian Portuguese](https://img.shields.io/badge/Language-PT--BR-yellow?style=for-the-badge)](#localization)

## 📖 Overview

RoomMate Manager is a mobile-first web application designed specifically for roommate pairs to collaboratively manage shared expenses, shopping lists, and receipts. Built with Brazilian Real (R$) as the default currency and Portuguese (Brasil) as the primary language.

### 🎯 Key Features

- **💸 Smart Expense Splitting** - Automatic expense division with customizable split ratios
- **📝 Real-time Shopping Lists** - Collaborative shopping with live updates
- **📸 Receipt Management** - Digital receipt gallery with categorization
- **📱 Mobile-First Design** - Optimized for mobile devices with density-optimized UI
- **🔐 Secure Authentication** - Google OAuth integration (planned)
- **🤖 Auto-Categorization** - Intelligent expense categorization using heuristics

## 🚀 MVP Status

✅ **Complete HTML Prototypes** (7 screens)
- Login & Registration screens
- Roommate dashboard with expense overview
- Add expense modal with smart features
- Comprehensive expenses list
- Interactive shopping list
- Receipt gallery management
- Settings & profile configuration

🔄 **In Development**
- React frontend implementation
- Laravel API backend
- Real-time collaboration features

## 🛠️ Tech Stack

### Current (Prototype)
- **Frontend:** HTML5 + Tailwind CSS + Vanilla JavaScript
- **Deployment:** GitHub Pages
- **Design:** Mobile-first responsive design

### Planned (Production)
- **Frontend:** React.js + TypeScript
- **Backend:** Laravel (PHP) + MySQL
- **Authentication:** Google OAuth 2.0
- **Real-time:** WebSockets / Server-Sent Events
- **Deployment:** AWS / Vercel + Laravel Forge

## 📁 Repository Structure

```
roommate-manager/
├── README.md                     # This file
├── docs/                         # Complete documentation
│   ├── technical-docs.md        # Technical specifications
│   ├── user-guide.md           # User documentation
│   ├── screenshots/            # Application screenshots
│   └── README.md               # Documentation index
├── prototype/                   # HTML prototypes (MVP)
│   ├── html-screens/           # 7 complete HTML screens
│   ├── assets/                 # CSS, JS, and images
│   └── README.md               # Prototype setup guide
├── frontend/                    # Future React application
├── backend/                     # Future Laravel API
├── .github/                     # GitHub configuration
│   ├── workflows/              # CI/CD pipelines
│   ├── ISSUE_TEMPLATE/         # Issue templates
│   └── PULL_REQUEST_TEMPLATE.md
├── .gitignore                   # Git ignore rules
└── LICENSE                      # MIT License
```

## 🚀 Getting Started

### Quick Demo
Visit our [live demo](https://your-username.github.io/roommate-manager) to see the prototype in action.

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/roommate-manager.git
   cd roommate-manager
   ```

2. **Run the prototype locally**
   ```bash
   cd prototype
   # Open html-screens/login_register_screens.html in your browser
   # or use a local server:
   python -m http.server 8000
   # Navigate to http://localhost:8000/html-screens/
   ```

3. **Explore the documentation**
   ```bash
   cd docs
   # Read technical-docs.md for detailed specifications
   # Check user-guide.md for usage instructions
   ```

## 📱 Screenshots

| Screen | Description |
|--------|-------------|
| ![Login](docs/screenshots/login.png) | Authentication & Registration |
| ![Dashboard](docs/screenshots/dashboard.png) | Roommate Expense Overview |
| ![Add Expense](docs/screenshots/add-expense.png) | Smart Expense Addition |
| ![Expenses List](docs/screenshots/expenses-list.png) | Comprehensive Expense Management |
| ![Shopping List](docs/screenshots/shopping-list.png) | Collaborative Shopping |
| ![Receipt Gallery](docs/screenshots/receipt-gallery.png) | Digital Receipt Management |
| ![Settings](docs/screenshots/settings.png) | Profile & Configuration |

*Screenshots will be added to complete the documentation.*

## 🌍 Localization

- **Primary Language:** Portuguese (Brasil)
- **Currency:** Brazilian Real (R$)
- **Date Format:** DD/MM/YYYY
- **Number Format:** Brazilian standards (1.234,56)

## 🤝 Contributing

We welcome contributions! Please see our contributing guidelines:

### Development Workflow

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Follow our coding standards** (see [technical-docs.md](docs/technical-docs.md))
5. **Submit a pull request**

### Branch Strategy
- `main` - Production-ready code
- `prototype` - HTML prototype development
- `feature/*` - Feature development branches
- `bugfix/*` - Bug fix branches

### Code Standards
- Mobile-first responsive design
- Accessibility (WCAG 2.1 AA)
- Brazilian Portuguese localization
- Clean, semantic HTML
- Component-based CSS with Tailwind
- ES6+ JavaScript standards

## 🛣️ Development Roadmap

### Phase 1: MVP Prototype ✅
- [x] HTML/CSS/JS prototypes
- [x] Mobile-responsive design
- [x] Core user flows
- [x] GitHub Pages deployment

### Phase 2: React Frontend 🔄
- [ ] Component architecture
- [ ] State management (Redux/Zustand)
- [ ] TypeScript implementation
- [ ] Progressive Web App (PWA)

### Phase 3: Backend API 📅
- [ ] Laravel API development
- [ ] Database design & migrations
- [ ] Authentication system
- [ ] RESTful API endpoints

### Phase 4: Real-time Features 📅
- [ ] WebSocket implementation
- [ ] Live expense updates
- [ ] Collaborative shopping lists
- [ ] Push notifications

### Phase 5: Advanced Features 📅
- [ ] Receipt OCR scanning
- [ ] Expense analytics & reports
- [ ] Multi-roommate support (3+ people)
- [ ] Integration with banking APIs

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built for Brazilian roommates managing shared expenses
- Inspired by real-world roommate financial challenges
- Designed with mobile-first accessibility in mind

---

**Made with ❤️ for Brazilian roommates**

For questions, suggestions, or support, please [open an issue](https://github.com/your-username/roommate-manager/issues) or contact the development team.