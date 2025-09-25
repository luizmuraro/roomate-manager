# 📋 RoomMate Manager API Documentation

## 🔐 Authentication

All API endpoints require authentication via JWT token:

```bash
Authorization: Bearer <your_jwt_token>
```

## 📄 Pagination

All listing endpoints (`/api/v1/expenses`, `/api/v1/shopping_items`, `/api/v1/receipts`) support pagination.

### Pagination Parameters

| Parameter | Type | Default | Max | Description |
|-----------|------|---------|-----|-------------|
| `page` | integer | 1 | ∞ | Page number |
| `per_page` | integer | varies | 100 | Items per page |

### Default Items Per Page

- **Expenses**: 10 items (detailed financial data)
- **Shopping Items**: 20 items (simpler list data)
- **Receipts**: 12 items (optimized for grid layout)

### Pagination Response Format

```json
{
  "expenses": [...],  // or "shopping_items", "receipts"
  "pagination": {
    "current_page": 1,
    "per_page": 10,
    "total_pages": 5,
    "total_count": 47,
    "next_page": 2,
    "prev_page": null
  }
}
```

## 💰 Expenses API

### List Expenses
```bash
GET /api/v1/expenses
```

**Query Parameters:**
- `page` (integer): Page number
- `per_page` (integer): Items per page (max 100)
- `search` (string): Search in description
- `category` (string): Filter by category
- `status` (string): Filter by status
- `paid_by` (string): "you" or "roommate"
- `high_value` (boolean): Filter high value expenses (>R$100)
- `date_from` (date): Start date filter (DD/MM/YYYY)
- `date_to` (date): End date filter (DD/MM/YYYY)
- `sort_by` (string): Sort options

**Example:**
```bash
GET /api/v1/expenses?page=1&per_page=5&category=groceries&sort_by=date_desc
```

**Response:**
```json
{
  "expenses": [
    {
      "id": 1,
      "description": "Compras do mês",
      "amount": {
        "raw": 127.80,
        "formatted": "R$ 127,80"
      },
      "your_share": {
        "raw": 63.90,
        "formatted": "R$ 63,90"
      },
      "category": "groceries",
      "category_display": "🛒 Compras",
      "status": "pending",
      "status_display": "Pendente",
      "date": "25/09/2025",
      "paid_by": {
        "id": 1,
        "name": "João"
      }
    }
  ],
  "pagination": {
    "current_page": 1,
    "per_page": 5,
    "total_pages": 3,
    "total_count": 12,
    "next_page": 2,
    "prev_page": null
  }
}
```

### Other Expense Endpoints

```bash
POST   /api/v1/expenses          # Create expense
GET    /api/v1/expenses/:id      # Show expense
PATCH  /api/v1/expenses/:id      # Update expense
DELETE /api/v1/expenses/:id      # Delete expense
PATCH  /api/v1/expenses/:id/settle # Mark as settled
```

## 🛒 Shopping Items API

### List Shopping Items
```bash
GET /api/v1/shopping_items
```

**Query Parameters:**
- `page` (integer): Page number
- `per_page` (integer): Items per page (max 100, default 20)
- `completed` (boolean): Filter by completion status
- `category` (string): Filter by category

**Example:**
```bash
GET /api/v1/shopping_items?page=1&per_page=10&completed=false&category=produce
```

**Response:**
```json
{
  "shopping_items": [
    {
      "id": 1,
      "name": "Bananas Orgânicas",
      "category": "produce",
      "category_display": "🥬 Hortifruti",
      "completed": false,
      "added_by": {
        "id": 1,
        "name": "Maria"
      },
      "created_at": "25/09/2025"
    }
  ],
  "pagination": {
    "current_page": 1,
    "per_page": 10,
    "total_pages": 2,
    "total_count": 18,
    "next_page": 2,
    "prev_page": null
  }
}
```

### Other Shopping Item Endpoints

```bash
POST   /api/v1/shopping_items              # Create item
GET    /api/v1/shopping_items/:id          # Show item
PATCH  /api/v1/shopping_items/:id          # Update item
DELETE /api/v1/shopping_items/:id          # Delete item
PATCH  /api/v1/shopping_items/:id/toggle   # Toggle completion
DELETE /api/v1/shopping_items/clear_completed # Clear completed items
GET    /api/v1/shopping_items/stats        # Get statistics
```

## 📷 Receipts API

### List Receipts
```bash
GET /api/v1/receipts
```

**Query Parameters:**
- `page` (integer): Page number
- `per_page` (integer): Items per page (max 100, default 12)
- `search` (string): Search in title
- `category` (string): Filter by category
- `status` (string): Filter by status
- `unlinked` (boolean): Show only unlinked receipts
- `date_from` (date): Start date filter
- `date_to` (date): End date filter
- `sort_by` (string): Sort options

**Example:**
```bash
GET /api/v1/receipts?page=1&per_page=6&unlinked=true&category=groceries
```

**Response:**
```json
{
  "receipts": [
    {
      "id": 1,
      "title": "Supermercado Extra",
      "amount": {
        "raw": 89.50,
        "formatted": "R$ 89,50"
      },
      "category": "groceries",
      "category_display": "🛒 Compras",
      "status": "processed",
      "status_display": "Processado",
      "date": "24/09/2025",
      "is_linked": false,
      "expense": null,
      "image_url": null
    }
  ],
  "pagination": {
    "current_page": 1,
    "per_page": 6,
    "total_pages": 4,
    "total_count": 23,
    "next_page": 2,
    "prev_page": null
  }
}
```

### Other Receipt Endpoints

```bash
POST   /api/v1/receipts                       # Create receipt
GET    /api/v1/receipts/:id                   # Show receipt
PATCH  /api/v1/receipts/:id                   # Update receipt
DELETE /api/v1/receipts/:id                   # Delete receipt
PATCH  /api/v1/receipts/:id/link_to_expense   # Link to expense
GET    /api/v1/receipts/stats                 # Get statistics
```

## 🎯 Pagination Best Practices

### Frontend Implementation

```javascript
// React example
const [expenses, setExpenses] = useState([]);
const [pagination, setPagination] = useState({});
const [page, setPage] = useState(1);

const fetchExpenses = async (pageNumber = 1) => {
  const response = await fetch(`/api/v1/expenses?page=${pageNumber}&per_page=10`);
  const data = await response.json();

  setExpenses(data.expenses);
  setPagination(data.pagination);
  setPage(pageNumber);
};

// Load more pattern
const loadMore = () => {
  if (pagination.next_page) {
    fetchExpenses(pagination.next_page);
  }
};

// Infinite scroll
const hasMoreData = pagination.next_page !== null;
```

### Performance Considerations

- **Mobile First**: Default page sizes optimized for mobile screens
- **Grid Layouts**: Receipts default to 12 items (3x4 or 4x3 grid)
- **List Layouts**: Shopping items default to 20 items (longer lists)
- **Detailed Views**: Expenses default to 10 items (more complex data)

### URL Patterns

```bash
# Clean URLs for first page
GET /api/v1/expenses                    # page=1 implicit

# Explicit pagination
GET /api/v1/expenses?page=2&per_page=5  # page 2, 5 items per page

# Combined with filters
GET /api/v1/expenses?page=1&category=groceries&sort_by=date_desc
```

## 🌍 Brazilian Localization

All APIs return Brazilian-formatted data:

- **Currency**: R$ 1.234,56 format
- **Dates**: DD/MM/YYYY format
- **Categories**: Portuguese names with emojis
- **Status**: Portuguese descriptions

## 📊 Error Handling

```json
{
  "error": "Resource not found",
  "status": 404
}
```

```json
{
  "errors": [
    "Amount can't be blank",
    "Description is too short (minimum is 3 characters)"
  ],
  "status": 422
}
```

---

🤖 **API Documentation - Updated with Pagination Support**