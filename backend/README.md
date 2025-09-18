# RoomMate Manager - Backend (Laravel API)

> **Status:** Planned for Phase 1 Development
> **Current:** HTML Prototype Complete (Frontend Only)

---

## Overview

This directory will contain the Laravel-based RESTful API backend for RoomMate Manager. The API will handle user authentication, expense management, real-time features, and data persistence.

## Technology Stack

### Core Framework
- **Laravel 10.x** - PHP web application framework
- **PHP 8.2+** - Modern PHP features and performance
- **Composer** - Dependency management

### Database
- **MySQL 8.0** - Primary database (production)
- **SQLite** - Development and testing
- **Laravel Migrations** - Database schema management
- **Eloquent ORM** - Database abstraction layer

### Authentication & Security
- **Laravel Sanctum** - SPA authentication
- **Google OAuth 2.0** - Social authentication
- **JWT Tokens** - API authentication
- **Rate Limiting** - API protection
- **CORS** - Cross-origin resource sharing

### Real-time Features
- **Laravel WebSockets** - Real-time communication
- **Pusher** - WebSocket service (production)
- **Redis** - Message broker and caching

### File Storage
- **Laravel Storage** - File management
- **Amazon S3** - Cloud file storage (production)
- **Local Storage** - Development file storage

### Testing & Quality
- **PHPUnit** - Unit and feature testing
- **Laravel Dusk** - Browser testing
- **PHP CodeSniffer** - Code style checking
- **PHPStan** - Static analysis

### Deployment & Infrastructure
- **Docker** - Containerization
- **Laravel Forge** - Server management
- **AWS/DigitalOcean** - Cloud hosting
- **GitHub Actions** - CI/CD pipeline

---

## Project Structure (Planned)

```
backend/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── Auth/          # Authentication controllers
│   │   │   ├── Api/           # API controllers
│   │   │   │   ├── ExpenseController.php
│   │   │   │   ├── ReceiptController.php
│   │   │   │   ├── ShoppingListController.php
│   │   │   │   ├── UserController.php
│   │   │   │   └── RoommateController.php
│   │   │   └── WebController.php
│   │   ├── Middleware/        # Custom middleware
│   │   ├── Requests/          # Form request validation
│   │   └── Resources/         # API resources
│   ├── Models/                # Eloquent models
│   │   ├── User.php
│   │   ├── Expense.php
│   │   ├── Receipt.php
│   │   ├── ShoppingItem.php
│   │   ├── Category.php
│   │   └── RoommateConnection.php
│   ├── Services/              # Business logic services
│   ├── Events/                # Laravel events
│   ├── Listeners/             # Event listeners
│   ├── Jobs/                  # Queue jobs
│   ├── Mail/                  # Email templates
│   └── Notifications/         # Push notifications
├── database/
│   ├── migrations/            # Database migrations
│   ├── seeders/              # Database seeders
│   └── factories/            # Model factories
├── routes/
│   ├── api.php               # API routes
│   ├── web.php               # Web routes
│   └── channels.php          # WebSocket channels
├── tests/
│   ├── Feature/              # Feature tests
│   ├── Unit/                 # Unit tests
│   └── Browser/              # Browser tests
├── storage/
│   ├── app/receipts/         # Receipt uploads
│   └── app/profiles/         # Profile images
├── config/                   # Configuration files
├── docker/                   # Docker configuration
├── docs/                     # API documentation
├── .env.example             # Environment variables template
├── composer.json            # PHP dependencies
├── phpunit.xml              # Testing configuration
└── README.md
```

---

## Database Schema

### Core Entities

```sql
-- Users table
users (
    id: bigint primary key,
    name: varchar(255),
    email: varchar(255) unique,
    email_verified_at: timestamp nullable,
    password: varchar(255),
    google_id: varchar(255) nullable,
    avatar: varchar(255) nullable,
    phone: varchar(20) nullable,
    preferences: json,
    created_at: timestamp,
    updated_at: timestamp
);

-- Roommate connections
roommate_connections (
    id: bigint primary key,
    user_id: bigint foreign key,
    roommate_id: bigint foreign key,
    status: enum('pending', 'accepted', 'declined'),
    connected_at: timestamp nullable,
    created_at: timestamp,
    updated_at: timestamp
);

-- Expense categories
categories (
    id: bigint primary key,
    name: varchar(100),
    emoji: varchar(10),
    color: varchar(7),
    is_default: boolean default false,
    created_at: timestamp,
    updated_at: timestamp
);

-- Expenses
expenses (
    id: bigint primary key,
    description: varchar(255),
    amount: decimal(10,2),
    currency: varchar(3) default 'BRL',
    date: date,
    paid_by: bigint foreign key references users(id),
    category_id: bigint foreign key references categories(id),
    split_method: enum('equal', 'custom', 'percentage'),
    split_data: json,
    status: enum('pending', 'settled'),
    notes: text nullable,
    created_at: timestamp,
    updated_at: timestamp
);

-- Expense participants (for split tracking)
expense_participants (
    id: bigint primary key,
    expense_id: bigint foreign key,
    user_id: bigint foreign key,
    amount: decimal(10,2),
    percentage: decimal(5,2) nullable,
    is_paid: boolean default false,
    paid_at: timestamp nullable
);

-- Receipts
receipts (
    id: bigint primary key,
    user_id: bigint foreign key,
    expense_id: bigint foreign key nullable,
    filename: varchar(255),
    original_name: varchar(255),
    mime_type: varchar(100),
    file_size: bigint,
    file_path: varchar(500),
    upload_date: timestamp,
    metadata: json nullable,
    created_at: timestamp,
    updated_at: timestamp
);

-- Shopping list items
shopping_items (
    id: bigint primary key,
    household_id: bigint, -- For future multi-roommate support
    name: varchar(255),
    category: varchar(100),
    emoji: varchar(10),
    quantity: varchar(50) nullable,
    notes: text nullable,
    is_completed: boolean default false,
    completed_by: bigint foreign key nullable,
    completed_at: timestamp nullable,
    added_by: bigint foreign key,
    created_at: timestamp,
    updated_at: timestamp
);

-- Settlements (balance resolution tracking)
settlements (
    id: bigint primary key,
    from_user: bigint foreign key,
    to_user: bigint foreign key,
    amount: decimal(10,2),
    method: varchar(100),
    reference: varchar(255) nullable,
    settled_at: timestamp,
    created_at: timestamp,
    updated_at: timestamp
);
```

### Indexes and Constraints

```sql
-- Performance indexes
CREATE INDEX idx_expenses_paid_by ON expenses(paid_by);
CREATE INDEX idx_expenses_date ON expenses(date);
CREATE INDEX idx_expenses_status ON expenses(status);
CREATE INDEX idx_receipts_expense_id ON receipts(expense_id);
CREATE INDEX idx_shopping_items_household ON shopping_items(household_id);
CREATE INDEX idx_expense_participants_expense ON expense_participants(expense_id);

-- Unique constraints
ALTER TABLE roommate_connections ADD CONSTRAINT unique_roommate_pair
    UNIQUE(user_id, roommate_id);
```

---

## API Endpoints

### Authentication
```php
POST /api/auth/register          // User registration
POST /api/auth/login             // Email/password login
POST /api/auth/google            // Google OAuth login
POST /api/auth/logout            // Logout
POST /api/auth/refresh           // Refresh token
GET  /api/auth/user              // Get current user
```

### User Management
```php
GET    /api/users/profile        // Get user profile
PUT    /api/users/profile        // Update profile
POST   /api/users/avatar         // Upload profile image
DELETE /api/users/avatar         // Remove profile image
PUT    /api/users/preferences    // Update app preferences
```

### Roommate Management
```php
POST   /api/roommates/invite     // Send roommate invitation
GET    /api/roommates            // Get connected roommate
PUT    /api/roommates/accept     // Accept invitation
DELETE /api/roommates/disconnect // Disconnect roommate
```

### Expense Management
```php
GET    /api/expenses             // List expenses (with filters)
POST   /api/expenses             // Create new expense
GET    /api/expenses/{id}        // Get expense details
PUT    /api/expenses/{id}        // Update expense
DELETE /api/expenses/{id}        // Delete expense
POST   /api/expenses/{id}/settle // Mark expense as settled
GET    /api/expenses/balance     // Get current balance
GET    /api/expenses/summary     // Get expense summary/stats
```

### Receipt Management
```php
GET    /api/receipts             // List receipts
POST   /api/receipts             // Upload receipt
GET    /api/receipts/{id}        // Get receipt details
DELETE /api/receipts/{id}        // Delete receipt
POST   /api/receipts/{id}/link   // Link receipt to expense
```

### Shopping List
```php
GET    /api/shopping             // Get shopping items
POST   /api/shopping             // Add shopping item
PUT    /api/shopping/{id}        // Update shopping item
DELETE /api/shopping/{id}        // Delete shopping item
POST   /api/shopping/{id}/toggle // Toggle completion status
DELETE /api/shopping/completed   // Clear completed items
```

### Categories
```php
GET    /api/categories           // List expense categories
POST   /api/categories           // Create custom category
PUT    /api/categories/{id}      // Update category
DELETE /api/categories/{id}      // Delete category
```

---

## Authentication & Security

### Laravel Sanctum Implementation
```php
// API authentication middleware
Route::middleware('auth:sanctum')->group(function () {
    // Protected API routes
});

// Token management
$user = User::find(1);
$token = $user->createToken('mobile-app');
```

### Google OAuth Integration
```php
// Google OAuth configuration
'google' => [
    'client_id' => env('GOOGLE_CLIENT_ID'),
    'client_secret' => env('GOOGLE_CLIENT_SECRET'),
    'redirect' => env('GOOGLE_REDIRECT_URL'),
],
```

### Rate Limiting
```php
// API rate limiting
RateLimiter::for('api', function (Request $request) {
    return Limit::perMinute(60)->by($request->user()?->id ?: $request->ip());
});
```

---

## Real-time Features

### WebSocket Channels
```php
// Shopping list updates
Broadcast::channel('shopping.{householdId}', function ($user, $householdId) {
    return $user->belongsToHousehold($householdId);
});

// Expense notifications
Broadcast::channel('expenses.{userId}', function ($user, $userId) {
    return $user->id === (int) $userId;
});
```

### Event Broadcasting
```php
// Shopping item added event
class ShoppingItemAdded implements ShouldBroadcast
{
    public function broadcastOn()
    {
        return new PrivateChannel('shopping.' . $this->householdId);
    }
}

// Expense added event
class ExpenseAdded implements ShouldBroadcast
{
    public function broadcastOn()
    {
        return new PrivateChannel('expenses.' . $this->roommateId);
    }
}
```

---

## File Management

### Receipt Upload
```php
class ReceiptController extends Controller
{
    public function store(ReceiptUploadRequest $request)
    {
        $file = $request->file('receipt');

        // Validate file type and size
        // Generate unique filename
        // Store file (S3 in production, local in development)
        // Create receipt record in database
        // Return receipt resource
    }
}
```

### File Storage Configuration
```php
// Filesystems configuration
'receipts' => [
    'driver' => env('RECEIPTS_DISK', 'local'),
    'root' => storage_path('app/receipts'),
    'url' => env('APP_URL').'/storage/receipts',
],

's3-receipts' => [
    'driver' => 's3',
    'bucket' => env('AWS_RECEIPTS_BUCKET'),
    'region' => env('AWS_DEFAULT_REGION'),
],
```

---

## Background Jobs

### Email Notifications
```php
class SendExpenseNotification implements ShouldQueue
{
    public function handle()
    {
        // Send email notification for new expense
        // Update notification preferences
        // Log notification sent
    }
}
```

### Data Processing
```php
class ProcessReceiptOCR implements ShouldQueue
{
    public function handle()
    {
        // Extract text from receipt image
        // Detect amount and merchant
        // Suggest expense details
        // Update receipt metadata
    }
}
```

---

## Testing Strategy

### Feature Tests
```php
class ExpenseManagementTest extends TestCase
{
    public function test_user_can_create_expense()
    {
        // Arrange: Create authenticated user
        // Act: Send POST request to create expense
        // Assert: Expense created and stored correctly
    }

    public function test_expense_split_calculation()
    {
        // Test different split methods
        // Verify calculations are correct
    }
}
```

### Unit Tests
```php
class ExpenseModelTest extends TestCase
{
    public function test_calculates_split_amounts_correctly()
    {
        // Test expense model business logic
        // Verify split calculations
        // Test edge cases
    }
}
```

---

## Development Timeline

### Phase 1.1: Project Setup (Week 1)
- [ ] Initialize Laravel project
- [ ] Configure database and migrations
- [ ] Set up authentication with Sanctum
- [ ] Configure Google OAuth
- [ ] Set up basic API structure

### Phase 1.2: Core Models & API (Week 2)
- [ ] Implement User and Roommate models
- [ ] Create Expense and Receipt models
- [ ] Build basic CRUD API endpoints
- [ ] Implement expense splitting logic
- [ ] Add API validation and error handling

### Phase 1.3: Advanced Features (Week 3)
- [ ] Shopping list API with real-time updates
- [ ] Receipt file upload and management
- [ ] Balance calculation and settlement
- [ ] Email notifications
- [ ] API documentation

### Phase 1.4: Real-time & Polish (Week 4)
- [ ] WebSocket implementation
- [ ] Background job processing
- [ ] Performance optimization
- [ ] Security hardening
- [ ] Comprehensive testing

---

## Deployment

### Development Environment
```bash
# Local development setup
composer install
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

### Production Deployment
```bash
# Production deployment (Laravel Forge)
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan migrate --force
```

### Docker Configuration
```dockerfile
FROM php:8.2-fpm-alpine

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Application setup
WORKDIR /var/www/html
COPY . .
RUN composer install --optimize-autoloader --no-dev
```

---

## Environment Variables

```bash
# Application
APP_NAME="RoomMate Manager API"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://api.roommatemanager.com

# Database
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=roommate_manager
DB_USERNAME=roommate_user
DB_PASSWORD=secure_password

# Authentication
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret

# File Storage
AWS_ACCESS_KEY_ID=your_aws_key
AWS_SECRET_ACCESS_KEY=your_aws_secret
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=roommate-receipts

# WebSocket
PUSHER_APP_ID=your_pusher_app_id
PUSHER_APP_KEY=your_pusher_key
PUSHER_APP_SECRET=your_pusher_secret
PUSHER_APP_CLUSTER=mt1

# Email
MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_USERNAME=your_username
MAIL_PASSWORD=your_password

# Redis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379
```

---

## API Documentation

### Swagger/OpenAPI
```yaml
openapi: 3.0.0
info:
  title: RoomMate Manager API
  description: API for collaborative roommate expense management
  version: 1.0.0
  contact:
    name: RoomMate Manager
    url: https://github.com/your-username/roommate-manager

servers:
  - url: https://api.roommatemanager.com/api
    description: Production server
  - url: http://localhost:8000/api
    description: Development server
```

### Postman Collection
A comprehensive Postman collection will be provided with:
- All API endpoints
- Authentication examples
- Request/response samples
- Environment variables

---

## Related Documentation

- [Frontend Documentation](../frontend/README.md)
- [Technical Documentation](../docs/technical-docs.md)
- [Deployment Guide](../docs/deployment.md)

---

*This directory will be populated during Phase 1 of development. The Laravel API will provide the backend foundation for the React frontend implementation.*